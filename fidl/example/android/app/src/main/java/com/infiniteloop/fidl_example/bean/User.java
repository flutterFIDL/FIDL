package com.infiniteloop.fidl_example.bean;

public class User<T> {
    public String uid;
    public String name;
    public int age;
    public T country;

    public User() {
    }

    public User(String uid, String name, int age) {
        this.uid = uid;
        this.name = name;
        this.age = age;
    }
}