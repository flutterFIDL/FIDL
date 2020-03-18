package com.infiniteloop.fidl;

import java.io.ByteArrayOutputStream;

public final class ExposedByteArrayOutputStream extends ByteArrayOutputStream {
    byte[] buffer() {
        return buf;
    }
}