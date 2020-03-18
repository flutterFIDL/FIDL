package com.infiniteloop.fidl_example;

import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

import com.infiniteloop.fidl.FidlChannel;
import com.infiniteloop.fidl_example.bean.AUser;
import com.infiniteloop.fidl_example.bean.Conversation;
import com.infiniteloop.fidl_example.bean.EmptyEnum;
import com.infiniteloop.fidl_example.bean.Gender;
import com.infiniteloop.fidl_example.bean.MessageStatus;
import com.infiniteloop.fidl_example.bean.UiMessage;
import com.infiniteloop.fidl_example.bean.User;
import com.infiniteloop.fidl_example.bean.UserInfo;
import com.infiniteloop.fidl_example.im_sdk.ChatManager;
import com.infiniteloop.fidl_example.im_sdk.ChatService;

import java.util.AbstractCollection;
import java.util.AbstractList;
import java.util.AbstractMap;
import java.util.AbstractQueue;
import java.util.AbstractSet;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.LinkedHashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Queue;
import java.util.Set;
import java.util.Stack;
import java.util.TreeSet;
import java.util.Vector;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.CopyOnWriteArrayList;
import java.util.concurrent.CopyOnWriteArraySet;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
    }

    private IChatServiceStub chatServiceStub;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        chatServiceStub = new IChatServiceStub() {
            @Override
            public boolean init(User<String> user) {
                ChatManager.init(user);
                ChatManager.Instance().setBinaryMessenger(getFlutterEngine().getDartExecutor());
                startService(new Intent(MainActivity.this, ChatService.class));
                return true;
            }
        };
        FidlChannel.openChannel(getFlutterEngine().getDartExecutor(), chatServiceStub);

        FidlChannel.openChannel(getFlutterEngine().getDartExecutor(), new IUserServiceStub() {
            @Override
            public void initArr0(int[] ids) {

            }

            @Override
            public void initArr1(int[][] ids) {

            }

            @Override
            public void initEnum0(EmptyEnum e) {

            }

            @Override
            public String initEnum1(MessageStatus status) {
                System.out.println(status + " is be callback");
                return "inited";
            }

            @Override
            public void initList0(List<String> ids) {

            }

            @Override
            public void initList1(Collection<String> ids) {

            }

            @Override
            public void initList2(Vector<String> ids) {

            }

            @Override
            public void initList3(AbstractList<String> ids) {

            }

            @Override
            public void initList4(AbstractCollection<String> ids) {

            }

            @Override
            public void initList5(CopyOnWriteArrayList<String> ids) {

            }

            @Override
            public void initList6(LinkedList<String> ids) {

            }

            @Override
            public void initList7(Stack<String> ids) {

            }

            @Override
            public void initList8(Queue ids) {

            }

            @Override
            public void initList9(AbstractQueue<String> ids) {

            }

            @Override
            public void initList10(BlockingQueue ids) {

            }

            @Override
            public void initSet0(Set ids) {

            }

            @Override
            public void initSet1(AbstractSet ids) {

            }

            @Override
            public void initSet2(HashSet<String> ids) {

            }

            @Override
            public void initSet3(CopyOnWriteArraySet ids) {

            }

            @Override
            public void initSet4(TreeSet<String> ids) {

            }

            @Override
            public void initSet5(LinkedHashSet<String> ids) {

            }

            @Override
            public void initMap0(Map<String, String> ids) {

            }

            @Override
            public void initMap1(AbstractMap map) {

            }

            @Override
            public void initMap2(AbstractMap<?, String> map) {

            }

            @Override
            public void initMap3(AbstractMap<?, Object> map) {

            }

            @Override
            public void initMap4(AbstractMap<?, ?> map) {

            }

            @Override
            public void initMap5(HashMap<?, List<HashMap<String, String>>> map) {

            }

            @Override
            public void initMap6(HashMap<String, String> ids) {

            }

            @Override
            public void initMap7(Hashtable<String, String> ids) {

            }

            @Override
            public void initMap8(Properties ids) {

            }

            @Override
            public void initObj0(UserInfo info) {

            }

            @Override
            public void initObj1(User user) {

            }

            @Override
            public void initObj2(AUser user) {

            }

            @Override
            public void initObj3(User<String> user) {

            }

            @Override
            public String initRet0() {
                return "empty";
            }

            @Override
            public boolean initRet1() {
                return false;
            }

            @Override
            public int initRet2() {
                return 0;
            }

            @Override
            public byte initRet3() {
                return 0;
            }

            @Override
            public short initRet4() {
                return 0;
            }

            @Override
            public long initRet5() {
                return 0;
            }

            @Override
            public char initRet6() {
                return 0;
            }

            @Override
            public Boolean initRet7() {
                return false;
            }

            @Override
            public boolean[] initRet8() {
                return new boolean[0];
            }

            @Override
            public Byte initRet9() {
                return 0;
            }

            @Override
            public byte[] initRet10() {
                return new byte[0];
            }

            @Override
            public Short initRet11() {
                return null;
            }

            @Override
            public short[] initRet12() {
                return new short[0];
            }

            @Override
            public Long initRet13() {
                return 0L;
            }

            @Override
            public long[] initRet14() {
                return new long[0];
            }

            @Override
            public Character initRet15() {
                return 0;
            }

            @Override
            public char[] initRet16() {
                return new char[0];
            }

            @Override
            public String[] initRet17() {
                return new String[0];
            }

            @Override
            public List<String> initRet18() {
                return new ArrayList<>();
            }

            @Override
            public void init(String name, Integer age, Gender gender, Conversation conversation) {

            }
        });
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        FidlChannel.closeChannel(chatServiceStub);
        stopService(new Intent(this, ChatService.class));
    }
}
