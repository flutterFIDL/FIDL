package com.infiniteloop.fidl;

import android.support.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * FidlPlugin
 */
public class FidlPlugin implements FlutterPlugin, MethodCallHandler {
    private BinaryMessenger messenger;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        final MethodChannel channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "fidl");
        channel.setMethodCallHandler(this);
        messenger = flutterPluginBinding.getBinaryMessenger();
    }

    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "fidl");
        FidlPlugin plugin = new FidlPlugin();
        plugin.messenger = registrar.messenger();
        channel.setMethodCallHandler(plugin);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else if (call.method.equals("bind")) {
            String name = call.argument("name");
            int code = call.argument("code");
            boolean success = FidlChannel.bindChannel(messenger, name, code);
            result.success(success);
        } else if (call.method.equals("unbind")) {
            String name = call.argument("name");
            int code = call.argument("code");
            FidlChannel.unbindChannel(name, code);
            result.success(null);
        } else {
            result.notImplemented();
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    }
}
