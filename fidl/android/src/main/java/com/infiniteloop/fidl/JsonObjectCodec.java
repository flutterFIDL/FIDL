package com.infiniteloop.fidl;

import com.jsoniter.JsonIterator;
import com.jsoniter.output.JsonStream;

import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

public class JsonObjectCodec implements ObjectCodec {
    public static final JsonObjectCodec INSTANCE = new JsonObjectCodec();
    private static final byte[] NULL = "\"null\"".getBytes();

    @Override
    public List<byte[]> encode(Object... objects) {
        List<byte[]> bytes = new ArrayList<>();
        if (objects == null || objects.length == 0) {
            bytes.add(NULL);
        } else {
            for (Object obj : objects) {
                if (obj == null) {
                    bytes.add(NULL);
                } else {
                    String json = JsonStream.serialize(obj);
                    LogUtils.d(json);
                    bytes.add(json.getBytes());
//                    ExposedByteArrayOutputStream outputStream = new ExposedByteArrayOutputStream();
//                    JsonStream.serialize(obj, outputStream);
//                    bytes.add(outputStream.buffer());
                }
            }
        }
        return bytes;
    }

    @Override
    public <T> T decode(byte[] input, TypeLiteral<T> type) {
        T ret = JsonIterator.deserialize(input, getRealType(type));
        LogUtils.d(ret);
        return ret;
    }

    private static <T> com.jsoniter.spi.TypeLiteral<T> getRealType(TypeLiteral<T> type) {
        return com.jsoniter.spi.TypeLiteral.create(type.getSuperclassTypeParameter());
    }
}
