package com.infiniteloop.fidl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.EventChannel;

public final class FidlChannel {
    private Map<String, List<ChannelConnection>> map;
    private static FidlChannel instance = Holder.instance;
    public static ObjectCodec objectCodec = JsonObjectCodec.INSTANCE;

    private FidlChannel() {
        map = new HashMap<>();
    }

    private static class Holder {
        private static final FidlChannel instance = new FidlChannel();
    }

    public static void registerObjectCodec(ObjectCodec codec) {
        if (codec != null) {
            objectCodec = codec;
        }
    }

    static boolean bindChannel(BinaryMessenger messenger, String channelName, int connectionCode) {
        if (!instance.map.containsKey(channelName)) {
            return false;
        }
        List<ChannelConnection> list = instance.map.get(channelName);
        if (list == null) {
            list = new ArrayList<>();
        }
        list.add(new ChannelConnection(messenger, channelName, connectionCode));
        return true;
    }

    private static final class ChannelConnection {
        EventChannel.EventSink eventSink;
        int connectionCode;

        ChannelConnection(BinaryMessenger messenger, String channelName, int connectionCode) {
            this.connectionCode = connectionCode;
            String eventChannelName = channelName + connectionCode;
            new EventChannel(messenger, eventChannelName).setStreamHandler(new EventChannel.StreamHandler() {
                @Override
                public void onListen(Object arguments, EventChannel.EventSink events) {
                    eventSink = events;
                    eventSink.success(true);
                }

                @Override
                public void onCancel(Object arguments) {
                    eventSink.success(false);
                }
            });
        }
    }

    static void unbindChannel(String channelName, int connectionCode) {
        if (!instance.map.containsKey(channelName)) {
            return;
        }
        List<ChannelConnection> list = instance.map.get(channelName);
        if (list != null && list.size() > 0) {
            Iterator<ChannelConnection> it = list.iterator();
            while (it.hasNext()) {
                ChannelConnection connection = it.next();
                if (connection.connectionCode == connectionCode) {
                    if (connection.eventSink != null) {
                        connection.eventSink.success(false);
                    }
                    it.remove();
                }
            }
        }
    }

    public static void openChannel(BinaryMessenger messenger, Channel channel) {
        if (channel != null && messenger != null) {
            instance.map.put(channel.getChannelName(), new ArrayList<ChannelConnection>());
            channel.attachMethodChannel(messenger);
        }
    }

    public static void closeChannel(Channel channel) {
        channel.detachMethodChannel();
        if (!instance.map.containsKey(channel.getChannelName())) {
            return;
        }
        List<ChannelConnection> list = instance.map.get(channel.getChannelName());
        if (list != null && list.size() > 0) {
            for (ChannelConnection connection : list) {
                if (connection.eventSink != null) {
                    connection.eventSink.success(false);
                }
            }
            list.clear();
        }
        instance.map.remove(channel.getChannelName());
    }
}
