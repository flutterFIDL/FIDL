package com.infiniteloop.fidl;

import android.util.Log;

import io.flutter.BuildConfig;

public class FlutterException extends RuntimeException {
  private static final String TAG = "FlutterException#";

  public final String code;
  public final Object details;

  public FlutterException(String code, String message, Object details) {
    super(message);
    if (BuildConfig.DEBUG && code == null) {
      Log.e(TAG, "Parameter code must not be null.");
    }
    this.code = code;
    this.details = details;
  }
}