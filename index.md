## FIDL

FIDL 可以实现原生类和 Dart 类的映射（根据`fidl.json`自动生成类），进而实现传输“对象”的能力，解决原生代码和 Flutter 共享数据需要编写大量样板代码的痛点。

FIDL 的出现是为了弥补 Flutter Platfrom Channel 只支持基础数据类型的不足，把支持的类型扩展到枚举、类、泛型。

`项目现阶段只完成了 Android 和 Flutter 之间的对象传输功能，暂不支持iOS。`

### 使用场景

1、 比较复杂的第三方库，比如一个IM SDK，不支持flutter，只能在native侧集成，而又想在flutter层实现统一的UI，完成聊天功能的开发。这就需要从native侧传递大量的对象到flutter侧

2、已经有一定体量的native应用，想接入flutter，难以避免需要和native共享数据

3、可能会出现的flutter负责ui，native侧负责数据和业务逻辑的开发模式

### 快速使用

#### Android侧

1、定义FIDL接口

```java
@FIDL
public interface IUserService {
	void initUser(User user);
}
```

2、执行命令`./gradlew assembleDebug`，生成IUserServiceStub类和fidl.json文件

3、打开通道，向Flutter公开方法

```java
FidlChannel.openChannel(getFlutterEngine().getDartExecutor(), new IUserServiceStub() {
  @Override
  void initUser(User user){
    System.out.println(user.name + " is " + user.age + "years old!");
  }
}
```

#### Flutter侧

1、拷贝fidl.json文件到fidl目录，执行命令`flutter packages pub run fidl_model`，生成Dart接口类

2、绑定Android侧的IUserServiceStub通道

```dart
await Fidl.bindChannel(IUserService.CHANNEL_NAME, _channelConnection);
```

3、调用公开方法

```dart
await IUserService.initUser(User());
```

### 交流群

QQ: 1055952922
