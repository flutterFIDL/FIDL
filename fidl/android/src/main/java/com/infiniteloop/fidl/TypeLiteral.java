package com.infiniteloop.fidl;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.security.InvalidParameterException;

public class TypeLiteral<T> {

    public Type getSuperclassTypeParameter() {
        Class<?> subclass = getClass();
        Type superclass = subclass.getGenericSuperclass();
        if (superclass instanceof Class) {
            throw new InvalidParameterException("Missing type parameter.");
        }
        ParameterizedType parameterized = (ParameterizedType) superclass;
        return parameterized.getActualTypeArguments()[0];
    }
}
