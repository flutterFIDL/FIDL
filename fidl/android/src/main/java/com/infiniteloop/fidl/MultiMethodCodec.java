package com.infiniteloop.fidl;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodCodec;

/**
 * A {@link MethodCodec} using the Flutter standard binary encoding.
 *
 * <p>This codec is guaranteed to be compatible with the corresponding
 * <a href="https://docs.flutter.io/flutter/services/StandardMethodCodec-class.html">StandardMethodCodec</a>
 * on the Dart side. These parts of the Flutter SDK are evolved synchronously.</p>
 *
 * <p>Values supported as method arguments and result payloads are those supported by
 * {@link MultiMessageCodec}.</p>
 */
public final class MultiMethodCodec implements MethodCodec {
    public static final MultiMethodCodec INSTANCE = new MultiMethodCodec(MultiMessageCodec.INSTANCE);
    private final MultiMessageCodec messageCodec;

    /**
     * Creates a new method codec based on the specified message codec.
     */
    public MultiMethodCodec(MultiMessageCodec messageCodec) {
        this.messageCodec = messageCodec;
    }

    @Override
    public ByteBuffer encodeMethodCall(MethodCall methodCall) {
        final ExposedByteArrayOutputStream stream = new ExposedByteArrayOutputStream();
        messageCodec.writeValue(stream, methodCall.method);
        messageCodec.writeValue(stream, methodCall.arguments);
        final ByteBuffer buffer = ByteBuffer.allocateDirect(stream.size());
        buffer.put(stream.buffer(), 0, stream.size());
        return buffer;
    }

    @Override
    public MethodCall decodeMethodCall(ByteBuffer methodCall) {
        methodCall.order(ByteOrder.nativeOrder());
        final Object method = messageCodec.readValue(methodCall);
        final Object arguments = messageCodec.readValue(methodCall);
        if (method instanceof String && !methodCall.hasRemaining()) {
            return new MethodCall((String) method, arguments);
        }
        throw new IllegalArgumentException("Method call corrupted");
    }

    @Override
    public ByteBuffer encodeSuccessEnvelope(Object result) {
        final ExposedByteArrayOutputStream stream = new ExposedByteArrayOutputStream();
        stream.write(0);
        messageCodec.writeValue(stream, result);
        final ByteBuffer buffer = ByteBuffer.allocateDirect(stream.size());
        buffer.put(stream.buffer(), 0, stream.size());
        return buffer;
    }

    @Override
    public ByteBuffer encodeErrorEnvelope(String errorCode, String errorMessage,
                                          Object errorDetails) {
        final ExposedByteArrayOutputStream stream = new ExposedByteArrayOutputStream();
        stream.write(1);
        messageCodec.writeValue(stream, errorCode);
        messageCodec.writeValue(stream, errorMessage);
        messageCodec.writeValue(stream, errorDetails);
        final ByteBuffer buffer = ByteBuffer.allocateDirect(stream.size());
        buffer.put(stream.buffer(), 0, stream.size());
        return buffer;
    }

    @Override
    public Object decodeEnvelope(ByteBuffer envelope) {
        envelope.order(ByteOrder.nativeOrder());
        final byte flag = envelope.get();
        switch (flag) {
            case 0: {
                final Object result = messageCodec.readValue(envelope);
                if (!envelope.hasRemaining()) {
                    return result;
                }
            }
            // Falls through intentionally.
            case 1: {
                final Object code = messageCodec.readValue(envelope);
                final Object message = messageCodec.readValue(envelope);
                final Object details = messageCodec.readValue(envelope);
                if (code instanceof String && (message == null || message instanceof String)
                        && !envelope.hasRemaining()) {
                    throw new FlutterException((String) code, (String) message, details);
                }
            }
        }
        throw new IllegalArgumentException("Envelope corrupted");
    }
}
