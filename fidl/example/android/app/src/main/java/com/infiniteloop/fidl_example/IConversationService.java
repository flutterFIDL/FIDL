package com.infiniteloop.fidl_example;

import com.infinateloop.fidl.annotation.FIDL;
import com.infiniteloop.fidl_example.bean.Conversation;
import com.infiniteloop.fidl_example.bean.UiMessage;

import java.util.List;

@FIDL
public interface IConversationService {
    void setupConversation(Conversation conversation);
    String getConversationDesc();

    List<UiMessage> getMessages();
    void sendMessage(String message);
    int getMessageCount();
}
