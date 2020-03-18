package com.infinateloop.fidl;

import com.jsoniter.JsonIterator;
import com.jsoniter.output.JsonStream;
import com.jsoniter.spi.TypeLiteral;

import org.junit.Test;

import java.util.PriorityQueue;
import java.util.Queue;

public class JsonStreamTest {
    @Test
    public void charObj() {
        class Char {
            char a = 'x';
            char b = 'y';
        }
        System.out.println(JsonStream.serialize(new Char()));
    }

    @Test
    public void voidObj() {
        class VO {
            Void a = null;
            Void b = null;
        }
        System.out.println(JsonStream.serialize(new VO()));
    }

    @Test
    public void arrayObj() {
        class AO {
            String[] a = new String[]{"x", "y"};
        }
        System.out.println(JsonStream.serialize(new AO()));
    }

    @Test
    public void dynamicParams() {
        test();
        test(null);
        test((Object) null);
        test(null, null);
        System.out.println(JsonIterator.deserialize((String) "null", Object.class));
    }

    private void test(Object... objects) {
        if (objects == null) {
            System.out.println("null");
            return;
        }
        System.out.println(objects.length);
    }

    enum E {
        A(0), B(3), C(4);
        int value;

        E(int i) {
            value = i;
        }
    }

    @Test
    public void enumObj() {
        class EO {
            E a = E.A;
        }
        System.out.println(JsonStream.serialize(new EO()));
    }

    static class EO {
        MessageStatus status = MessageStatus.AllMentioned;
    }

    @Test
    public void enumObj1() {
        EO obj = new EO();
        String json = JsonStream.serialize(obj);
        System.out.println(json);
        EO obj1 = JsonIterator.deserialize(json, EO.class);
        System.out.println(obj1.status);
    }

    @Test
    public void streamQueue() {
        Queue<Object> queue = new PriorityQueue<>();
        queue.offer("1");
        queue.offer("a");
        queue.offer("E.B");
        System.out.println(JsonStream.serialize(queue));
    }

    @Test
    public void streamUserInfo() {
        UserInfo info = new UserInfo("","",1);
        info.age = 16;
        System.out.println(JsonStream.serialize(info));
    }

    @Test
    public void deserializeUserInfo() {
        String json = "{\"age\":16,\"name\":null,\"uid\":null}";
        UserInfo info = JsonIterator.deserialize(json, new TypeLiteral<UserInfo>(){});
        System.out.println(info.age);
    }
}
