package com.infiniteloop.fidl;

import android.util.Log;

public class LogUtils {
    public static boolean DEBUG = true;
    private static final String TAG = "FIDL";

    public static void d(Object... objects) {
        if (!DEBUG) {
            return;
        }
        StringBuilder sb = new StringBuilder();
        for (Object obj : objects) {
            sb.append(obj.toString()).append("\n");
        }
        Log.d(TAG, sb.toString());
    }

    public static void i(Object... objects) {
        StringBuilder sb = new StringBuilder();
        for (Object obj : objects) {
            sb.append(obj.toString()).append("\n");
        }
        Log.i(TAG, sb.toString());
    }

    public static void e(Object... objects) {
        StringBuilder sb = new StringBuilder();
        for (Object obj : objects) {
            sb.append(obj.toString()).append("\n");
        }
        Log.e(TAG, sb.toString());
    }
}
