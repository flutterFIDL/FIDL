package com.infiniteloop.fidl;

import java.util.List;

public interface ObjectCodec {
    List<byte[]> encode(Object... objects);

    <T> T decode(byte[] input, TypeLiteral<T> type);
}
