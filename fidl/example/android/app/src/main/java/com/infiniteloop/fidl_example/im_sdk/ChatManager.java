package com.infiniteloop.fidl_example.im_sdk;

import com.infiniteloop.fidl_example.bean.User;

import io.flutter.plugin.common.BinaryMessenger;

public class ChatManager {
    private static ChatManager INST;

    public static void init(User<String> user) {
        if (INST != null) {
            return;
        }
        INST = new ChatManager(user);
    }

    private User<String> me;
    private BinaryMessenger messenger;

    private ChatManager(User<String> me) {
        this.me = me;
    }

    public static ChatManager Instance() throws NullPointerException {
        if (INST == null) {
            throw new NullPointerException("ChatManager is not initialized!");
        }
        return INST;
    }

    public static User<String> getMe() {
        return Instance().me;
    }

    public void setBinaryMessenger(BinaryMessenger messenger) {
        this.messenger = messenger;
    }

    public BinaryMessenger getMessenger() {
        return messenger;
    }
}
