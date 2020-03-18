package com.infiniteloop.fidl_example.bean;

public class AUser extends User<String> {
    public AUser() {
    }

    public AUser(String uid, String name, int age) {
        super(uid, name, age);
    }
}
