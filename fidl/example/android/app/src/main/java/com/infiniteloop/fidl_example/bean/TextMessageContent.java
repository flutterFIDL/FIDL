package com.infiniteloop.fidl_example.bean;

import android.os.Parcel;

public class TextMessageContent extends MessageContent {
    private String content;

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        super.writeToParcel(dest, flags);
        dest.writeString(this.content);
    }

    public TextMessageContent() {
    }

    public TextMessageContent(String content) {
        this.content = content;
        this.extra = content;
    }

    protected TextMessageContent(Parcel in) {
        super(in);
        this.content = in.readString();
    }

    public static final Creator<TextMessageContent> CREATOR = new Creator<TextMessageContent>() {
        @Override
        public TextMessageContent createFromParcel(Parcel source) {
            return new TextMessageContent(source);
        }

        @Override
        public TextMessageContent[] newArray(int size) {
            return new TextMessageContent[size];
        }
    };
}
