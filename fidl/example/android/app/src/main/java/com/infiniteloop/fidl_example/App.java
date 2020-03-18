package com.infiniteloop.fidl_example;

import com.infiniteloop.fidl.FidlChannel;
import com.infiniteloop.fidl.JsonObjectCodec;

import io.flutter.app.FlutterApplication;

public class App extends FlutterApplication {
    @Override
    public void onCreate() {
        super.onCreate();
        FidlChannel.registerObjectCodec(new JsonObjectCodec());
    }
}
