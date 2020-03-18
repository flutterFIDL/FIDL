package com.infiniteloop.fidl_example;

import com.infinateloop.fidl.annotation.FIDL;
import com.infiniteloop.fidl_example.bean.User;

@FIDL
public interface IChatService {
    public boolean init(User<String> user);
}
