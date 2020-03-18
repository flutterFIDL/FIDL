# Flutter Interface Definition Language (FIDL)

[README in English(TODO)](README.en.md)

FIDL 即 Flutter 接口定义语言，类似于AIDL(Android Interface Definition Language)。您可以利用它定义不同平台（不限于 Android/iOS/Web）都可以识别的统一接口`fidl.json`文件，再通过静态代码生成的方式，自动化生成平台原生接口，进而快速/高效实现 Flutter 和原生之间的通信。

FIDL 可以实现原生类和 Dart 类的映射（根据`fidl.json`自动生成类），进而实现传输“对象”的能力，解决原生代码和 Flutter 共享数据需要编写大量样板代码的痛点。

FIDL 的出现是为了弥补 Flutter Platfrom Channel 只支持基础数据类型的不足，把支持的类型扩展到枚举、类、泛型。

注：项目现阶段只完成了 Android 和 Flutter 之间的对象传输功能，暂不支持iOS。项目还未在线上使用，待功能完善，会发布到 [Dart Pub](https://pub.dev/)。

### 目标

- 实现 Dart/Java/iOS/JS 接口转 fidl.json
- 实现 fidl.json 转 Dart/Java/iOS/JS
- 实现高性能对象编解码器

### 使用场景

1、 比较复杂的第三方库，比如一个IM SDK，不支持flutter，只能在native侧集成，而又想在flutter层实现统一的UI，完成聊天功能的开发。这就需要从native侧传递大量的对象到flutter侧

2、已经有一定体量的native应用，想接入flutter，难以避免需要和native共享数据

3、可能会出现的flutter负责ui，native侧负责数据和业务逻辑的开发模式

### 简易教程

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

### 技术特性

在Flutter侧调用Android侧的方法，除了基础数据类型，还允许传递对象。支持的接口方法如下：

1、多个参数的接口方法

```java
void init(String name, Integer age, Gender gender, Conversation conversation);
```

2、带返回值的接口方法

```java
UserInfo getUserInfo();
```

3、参数是泛型子类的接口方法

```java
public class User<T> {
  T country;
}
public class AUser<String>{}
// AUser是泛型子类
void initUser(AUser user);
```

4、参数是枚举

```java
void initEnum0(EmptyEnum e);
String initEnum1(MessageStatus status);
```

5、参数是集合、Map

```java
void initList0(List<String> ids);
void initList1(Collection<String> ids);
void initList7(Stack<String> ids);
void initList10(BlockingQueue ids);
```

### 开始体验

1、克隆项目

```shell
git clone git@github.com:flutterFIDL/FIDL.git
```

2、运行fidl/example项目

```shell
cd FIDL/fidl/example
flutter run
```

### Demo

Demo模拟了一个在Android侧依赖了IM(即时通讯)SDK，需要在Flutter侧聊天、获取消息、发消息的场景。以下是Demo的截图：

1、首页，点击按钮调用Android侧方法，开启聊天服务

![](https://user-gold-cdn.xitu.io/2020/3/16/170e227def17e66c?w=762&h=254&f=png&s=19309)

2、聊天页面

![](https://user-gold-cdn.xitu.io/2020/3/16/170e2280e1d9e13e?w=764&h=684&f=png&s=69889)

3、发一条消息给Lucy并获取和Lucy的聊天记录

![](https://user-gold-cdn.xitu.io/2020/3/16/170e2283eecd022e?w=764&h=718&f=png&s=74185)

4、调用Android侧方法发送N条消息给Wilson并获取聊天记录

![](https://user-gold-cdn.xitu.io/2020/3/16/170e22898c921464?w=766&h=794&f=png&s=95107)

- [Android Demo](https://github.com/flutterFIDL/Demo)

### 详细教程

具体使用方法可以参考demo的代码。

#### Android侧

1、定义一个接口，添加注解@FIDL。这个注解将告知annotationProcessor生成一些接口和类的描述文件。

```java
@FIDL
public interface IUserService {
	void initUser(User user);
}
```

接口方法的限制如下：

- 由于dart不支持方法重载，所以接口中不能出现同名方法
- 参数只支持实体类，不支持回调
- 由于JSON解码的限制，Java需要有无参构造函数

2、Android Studio点击sync，或者执行：

```shell
./gradlew assembleDebug
```

然后就会产生一堆json文件，如下：

![](https://user-gold-cdn.xitu.io/2020/3/16/170e226e1aeed837?w=1158&h=1012&f=png&s=185472)

这些json文件就是FIDL和类的描述文件。没错，**也会同时生成User引用的Gender类的描述文件**。

同时，还会生成IUserService的实现IUserServiceStub。即：

- com.infiniteloop.fidl_example.IUserService.fidl.json
- com.infiniteloop.fidl_example.User.json
- com.infiniteloop.fidl_example.Gender.json
- com.infiniteloop.fidl_example.IUserServiceStub.java

限制：只能生成有强引用关系的FIDL文件，被FIDL接口强引用的类的子类如果没有被FIDL接口强引用，则不会生成相应的描述文件。

3、在合适的地方打开通道，向Flutter公开方法

```java
IUserServiceStub userService = new IUserServiceStub() {
  @Override
  void initUser(User user){
    System.out.println(user.name + " is " + user.age + "years old!");
  }
FidlChannel.openChannel(getFlutterEngine().getDartExecutor(), userService);
```

4、如有需要，可以在合适的地方关闭通道

```
FidlChannel.closeChannel(userService);
```

关闭的消息将通知到Flutter侧。

5、Android侧需要注意代码混淆问题，FIDL接口和被引用的实体类不能被混淆。

#### Flutter侧

1、进入到你的flutter项目，在lib目录下创建fidl目录，把上面的json文件拷贝到这个目录，然后执行：

```shell
flutter packages pub run fidl_model
```

然后就能在fidl目录下自动生成相关的dart类：

![](https://user-gold-cdn.xitu.io/2020/3/16/170e2273c94ff59f?w=982&h=856&f=png&s=117571)

即：

- User.dart
- Gender.dart
- IUserService.dart

2、绑定Android侧的IUserServiceStub通道

```dart
bool connected = await Fidl.bindChannel(IUserService.CHANNEL_NAME, _channelConnection);
```

_channelConnection用于跟踪IUserService通道的连接状态，通道连接成功时，会回调它的onConnected方法；通道连接断开时，会回调它的onDisconnected方法。

3、调用通道的公开方法

```dart
if (_channelConnection.connected) {
  await IUserService.initUser(User());
}
```

4、如果不再需要使用这个通道了，可以解除绑定

```dart
await Fidl.unbindChannel(IUserService.CHANNEL_NAME, _channelConnection);
```

### 文档

[FIDL：Flutter与原生通讯的新姿势，不局限于基础数据类型](https://juejin.im/post/5e6f23eef265da574f355950)

### FIDL语法

FIDL使用json格式描述数据结构。

fidl文件：

- 文件名：com.infiniteloop.fidl_example.IChatService.fidl.json
- 结构

```json
{
  "cls": "com.infiniteloop.fidl_example.IChatService",
  "kind": "fidl",
  "methods": [
    {
      "name": "init",
      "returns": "bool",
      "parameters": [
        {
          "name": "user",
          "type": "com.infiniteloop.fidl_example.bean.User(String)"
        }
      ]
    }
  ]
}
```

- cls 即FIDL接口类的类名
- kind 可选 fidl/class，用于区分类型
- methods 描述FIDL接口类中的方法
- methods[0].name 表示方法名
- methods[0].returns 表示方法的返回类型
- methods[0].parameters 表示方法的参数列表
- methods[0].parameters[0].name 表示参数名
- methods[0].parameters[0].type 表示参数类型

类文件：

- 文件名：com.infiniteloop.fidl_example.bean.User.json
- 结构

```json
{
  "type": "com.infiniteloop.fidl_example.bean.User(@Generic(T))",
  "kind": "class",
  "fields": [
    {
      "name": "country",
      "type": "@Generic(T)"
    },
    {
      "name": "age",
      "type": "int"
    },
    {
      "name": "name",
      "type": "String"
    },
    {
      "name": "uid",
      "type": "String"
    }
  ],
  "superType": "?"
}
```

- fields字段描述类中的变量
- fields[0].type 表示变量的类型
- fields[0].name 表示变量的名字

类型描述：

| Dart                                                 | Java                                                 | FIDL                                            | OC                                             | Swift                                   |
| ---------------------------------------------------- | ---------------------------------------------------- | ----------------------------------------------- | ---------------------------------------------- | --------------------------------------- |
| null                                                 | null                                                 | null                                            | nil (NSNull when nested)                       | nil                                     |
| bool                                                 | java.lang.Boolean                                    | bool                                            | NSNumber numberWithBool:                       | NSNumber(value: Bool)                   |
| int                                                  | java.lang.Integer                                    | int                                             | NSNumber numberWithInt:                        | NSNumber(value: Int32)                  |
| int, if 32 bits not enough                           | java.lang.Long                                       | long                                            | NSNumber numberWithLong:                       | NSNumber(value: Int)                    |
| double                                               | java.lang.Double                                     | double                                          | NSNumber numberWithDouble:                     | NSNumber(value: Double)                 |
| String                                               | java.lang.String                                     | String                                          | NSString                                       | String                                  |
| Uint8List                                            | byte[]                                               | @list(byte)                                     | FlutterStandardTypedData typedDataWithBytes:   | FlutterStandardTypedData(bytes: Data)   |
| Int32List                                            | int[]                                                | @list(int)                                      | FlutterStandardTypedData typedDataWithInt32:   | FlutterStandardTypedData(int32: Data)   |
| Int64List                                            | long[]                                               | @list(long)                                     | FlutterStandardTypedData typedDataWithInt64:   | FlutterStandardTypedData(int64: Data)   |
| Float64List                                          | double[]                                             | @list(double)                                   | FlutterStandardTypedData typedDataWithFloat64: | FlutterStandardTypedData(float64: Data) |
| List                                                 | java.util.ArrayList                                  | @list()                                         | NSArray                                        | Array                                   |
| Map                                                  | java.util.HashMap                                    | @map()                                          | NSDictionary                                   | Dictionary                              |
| User`<`T`>`                                          | User`<`T`>`                                          | User(@Generic(T))                               |                                                |                                         |
| User`<`T1`,T2>`                                      | User`<`T1`,T2>`                                      | User(@Generic(T1),@Generic(T2))                 |                                                |                                         |
| Set                                                  | java.util.Set                                        | @set()                                          |                                                |                                         |
| User<String`>                                        | User<String`>                                        | User(String)                                    |                                                |                                         |
| enum ConversationType{Channel,ChatRoom,Group,Single} | enum ConversationType{Channel,ChatRoom,Group,Single} | ConversationType(Channel,ChatRoom,Group,Single) |                                                |                                         |

### 欢迎捐赠

![](art/alipay.jpg)

欢迎使用支付宝手扫描上面的二维码，对该项目进行捐赠。捐赠款项将用于持续维护、优化FIDL以及完善文档。

FIDL交流群：1055952922（QQ群），FIDL集成、调优，应用场景讨论。

