package com.infiniteloop.fidl_example.bean;

import android.os.Parcel;

public class ImageMessageContent extends MessageContent {
    public String localPath;
    public String remoteUrl;
    private byte[] thumbnailBytes;

    public ImageMessageContent(String path) {
        this.localPath = path;
    }

    @Override
    public int describeContents() {
        return 0;
    }

    @Override
    public void writeToParcel(Parcel dest, int flags) {
        super.writeToParcel(dest, flags);
        dest.writeString(this.localPath);
        dest.writeString(this.remoteUrl);
        dest.writeByteArray(this.thumbnailBytes);
    }

    protected ImageMessageContent(Parcel in) {
        super(in);
        this.localPath = in.readString();
        this.remoteUrl = in.readString();
        this.thumbnailBytes = in.createByteArray();
    }

    public static final Creator<ImageMessageContent> CREATOR = new Creator<ImageMessageContent>() {
        @Override
        public ImageMessageContent createFromParcel(Parcel source) {
            return new ImageMessageContent(source);
        }

        @Override
        public ImageMessageContent[] newArray(int size) {
            return new ImageMessageContent[size];
        }
    };
}
