package com.infiniteloop.fidl_example;

import com.infinateloop.fidl.annotation.FIDL;
import com.infiniteloop.fidl_example.bean.AUser;
import com.infiniteloop.fidl_example.bean.Conversation;
import com.infiniteloop.fidl_example.bean.EmptyEnum;
import com.infiniteloop.fidl_example.bean.Gender;
import com.infiniteloop.fidl_example.bean.MessageStatus;
import com.infiniteloop.fidl_example.bean.User;
import com.infiniteloop.fidl_example.bean.UserInfo;

import java.util.AbstractCollection;
import java.util.AbstractList;
import java.util.AbstractMap;
import java.util.AbstractQueue;
import java.util.AbstractSet;
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

@FIDL
public interface IUserService {
    // 基础类型
    void initArr0(int[] ids);
    void initArr1(int[][] ids);

    // 枚举
    void initEnum0(EmptyEnum e);
    String initEnum1(MessageStatus status);

    // 集合
    void initList0(List<String> ids);
    void initList1(Collection<String> ids);
    void initList2(Vector<String> ids);
    void initList3(AbstractList<String> ids);
    void initList4(AbstractCollection<String> ids);
    void initList5(CopyOnWriteArrayList<String> ids);
    void initList6(LinkedList<String> ids);
    void initList7(Stack<String> ids);

    // TODO Queue细分
    void initList8(Queue ids);
    void initList9(AbstractQueue<String> ids);
    void initList10(BlockingQueue ids);


    void initSet0(Set ids);
    void initSet1(AbstractSet ids);
    void initSet2(HashSet<String> ids);
    void initSet3(CopyOnWriteArraySet ids);
    void initSet4(TreeSet<String> ids);
    void initSet5(LinkedHashSet<String> ids);

    void initMap0(Map<String,String> ids);
    void initMap1(AbstractMap map);
    void initMap2(AbstractMap<?, String> map);
    void initMap3(AbstractMap<?, Object> map);
    void initMap4(AbstractMap<?, ?> map);
    void initMap5(HashMap<?,List<HashMap<String,String>>> map);
    void initMap6(HashMap<String,String> ids);
    void initMap7(Hashtable<String,String> ids);
    void initMap8(Properties ids);

    void initObj0(UserInfo info);
    void initObj1(User user);
    void initObj2(AUser user);
    void initObj3(User<String> user);

    String initRet0();
    boolean initRet1();
    int initRet2();
    byte initRet3();
    short initRet4();
    long initRet5();
    char initRet6();

    Boolean initRet7();
    boolean[] initRet8();
    Byte initRet9();
    byte[] initRet10();
    Short initRet11();
    short[] initRet12();
    Long initRet13();
    long[] initRet14();
    Character initRet15();
    char[] initRet16();

    String[] initRet17();
    List<String> initRet18();

    void init(String name, Integer age, Gender gender, Conversation conversation);
}
