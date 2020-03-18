package com.infinateloop.fidl;

public class FlutterPlugin {
    public interface MethodCallHandler {
        void onMethodCall(MethodCall call, Result result);
    }

    public static class Result {
    }
}
