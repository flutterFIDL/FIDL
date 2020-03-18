package com.infiniteloop.fidl_example.im_sdk;

import android.app.Service;
import android.content.Intent;
import android.os.IBinder;
import android.support.annotation.Nullable;

import com.infiniteloop.fidl.FidlChannel;
import com.infiniteloop.fidl.LogUtils;
import com.infiniteloop.fidl_example.IConversationServiceStub;
import com.infiniteloop.fidl_example.bean.Conversation;
import com.infiniteloop.fidl_example.bean.Message;
import com.infiniteloop.fidl_example.bean.MessageDirection;
import com.infiniteloop.fidl_example.bean.TextMessageContent;
import com.infiniteloop.fidl_example.bean.UiMessage;
import com.infiniteloop.fidl_example.bean.UserInfo;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ChatService extends Service {
    private IConversationServiceStub conversationServiceStub;

    private Conversation currentConversation;

    private List<UserInfo> userRepo = Arrays.asList(
            new UserInfo("10", "Amy", 16),
            new UserInfo("11", "Wilson", 18),
            new UserInfo("12", "Lucy", 20)
    );

    private Map<String, List<UiMessage>> messageRepo = new HashMap<String, List<UiMessage>>() {{
        for (UserInfo info : userRepo) {
            List<UiMessage> messages = new ArrayList<>();
            Conversation amyConversation = new Conversation();
            amyConversation.target = info.uid;
            amyConversation.type = Conversation.ConversationType.Single;

            Message message0 = new Message();
            message0.conversation = amyConversation;
            message0.direction = MessageDirection.Receive;
            message0.content = new TextMessageContent("Hi! I'm " + info.name + ", nice to meet you!");
            messages.add(new UiMessage(message0));

            Message message1 = new Message();
            message1.conversation = amyConversation;
            message1.direction = MessageDirection.Send;
            message1.content = new TextMessageContent("Nice to meet you, too!");
            messages.add(new UiMessage(message1));

            put(info.uid, messages);
        }
    }};

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }

    @Override
    public void onCreate() {
        super.onCreate();
        conversationServiceStub = new IConversationServiceStub() {
            @Override
            public void setupConversation(Conversation conversation) {
                LogUtils.d("setupConversation: " + conversation);
                currentConversation = conversation;
            }

            @Override
            public String getConversationDesc() {
                LogUtils.d("getConversationDesc");
                StringBuilder sb = new StringBuilder("My id: " + ChatManager.getMe().uid + "\n");
                sb.append("My age：").append(ChatManager.getMe().age).append("\n");
                sb.append("My name：").append(ChatManager.getMe().name).append("\n\n");
                if (currentConversation == null) {
                    sb.append("Conversation seems not being initialized!");
                } else {
                    UserInfo userInfo = null;
                    for (UserInfo info : userRepo) {
                        if (info.uid.equals(currentConversation.target)) {
                            userInfo = info;
                            break;
                        }
                    }
                    if (userInfo == null) {
                        sb.append("Partner is not found!");
                    } else {
                        sb.append("Partner's id：").append(userInfo.uid).append("\n");
                        sb.append("Partner's age：").append(userInfo.age).append("\n");
                        sb.append("Partner's name：").append(userInfo.name);
                    }
                }
                LogUtils.d(sb);
                return sb.toString();
            }

            @Override
            public List<UiMessage> getMessages() {
                if (currentConversation == null) {
                    LogUtils.e("Conversation is not initialized!");
                    return new ArrayList<>();
                }
                return messageRepo.get(currentConversation.target);
            }

            @Override
            public void sendMessage(String message) {
                if (currentConversation == null) {
                    LogUtils.e("Conversation is not initialized!");
                    return;
                }
                Message message0 = new Message();
                message0.conversation = currentConversation;
                message0.direction = MessageDirection.Send;
                message0.content = new TextMessageContent(message);
                messageRepo.get(currentConversation.target).add(new UiMessage(message0));
            }

            @Override
            public int getMessageCount() {
                if (currentConversation == null) {
                    return 0;
                }
                return messageRepo.get(currentConversation.target).size();
            }
        };
        FidlChannel.openChannel(ChatManager.Instance().getMessenger(), conversationServiceStub);
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        FidlChannel.closeChannel(conversationServiceStub);
    }
}
