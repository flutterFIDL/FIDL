package com.infiniteloop.fidl_example;

import com.alibaba.fastjson.JSON;
import com.infiniteloop.fidl.LogUtils;
import com.infiniteloop.fidl.ObjectCodec;
import com.infiniteloop.fidl.TypeLiteral;

import java.util.ArrayList;
import java.util.List;

public class FastJsonObjectCodec implements ObjectCodec {
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
                    bytes.add(JSON.toJSONString(obj).getBytes());
                }
            }
        }
        return bytes;
    }

    @Override
    public <T> T decode(byte[] input, TypeLiteral<T> type) {
        T ret = JSON.parseObject(input, type.getSuperclassTypeParameter());
        LogUtils.d(ret);
        return ret;
    }
}
