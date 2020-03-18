package com.infiniteloop.fidl;

import android.support.annotation.NonNull;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public abstract class Channel implements FlutterPlugin, MethodChannel.MethodCallHandler, IChannel {
    private MethodChannel channel;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    }

    public abstract String getChannelName();

    @Override
    public void onDetachedFromEngine(FlutterPluginBinding binding) {
    }

    public void attachMethodChannel(BinaryMessenger messenger) {
        if (channel == null) {
            channel = new MethodChannel(messenger, getChannelName(), MultiMethodCodec.INSTANCE);
        }
        channel.setMethodCallHandler(this);
    }

    void detachMethodChannel() {
        channel.setMethodCallHandler(null);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        Object obj = onMethodCall(call.method, (List<byte[]>) call.arguments);
        Map<String, Object> map = new HashMap<>();
        map.put("ret", obj);
        result.success(FidlChannel.objectCodec.encode(map));
    }

    public abstract Object onMethodCall(String method, List<byte[]> arguments);
}
