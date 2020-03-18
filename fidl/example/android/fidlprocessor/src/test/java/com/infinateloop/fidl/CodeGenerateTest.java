package com.infinateloop.fidl;

import com.squareup.javapoet.ClassName;
import com.squareup.javapoet.CodeBlock;
import com.squareup.javapoet.FieldSpec;
import com.squareup.javapoet.JavaFile;
import com.squareup.javapoet.MethodSpec;
import com.squareup.javapoet.TypeName;
import com.squareup.javapoet.TypeSpec;

import org.junit.Test;

import java.lang.reflect.Method;
import java.lang.reflect.Type;
import java.util.List;
import java.util.Map;

import javax.lang.model.element.Modifier;

public class CodeGenerateTest {
    private String packageName = "com.infinateloop.fidl";
    private String className = "IUserService";
    private ClassName interfaceClassName = ClassName.get(packageName, className);

    @Test
    public void superclass() throws Exception {
        TypeSpec channelClass = TypeSpec.classBuilder(interfaceClassName.simpleName() + "Stub")
                .addModifiers(Modifier.PUBLIC, Modifier.ABSTRACT)
                .superclass(ClassName.bestGuess("com.infiniteloop.fidl.Binder"))
                .build();

        JavaFile javaFile = JavaFile.builder(packageName, channelClass).build();
        javaFile.writeTo(System.out);
    }

    @Test
    public void addSuperinterface() throws Exception {
        TypeSpec channelClass = TypeSpec.classBuilder(interfaceClassName.simpleName() + "Stub")
                .addModifiers(Modifier.PUBLIC, Modifier.ABSTRACT)
                .superclass(ClassName.bestGuess("com.infiniteloop.fidl.Binder"))
                .addSuperinterface(Class.forName(interfaceClassName.canonicalName()))
                .build();

        JavaFile javaFile = JavaFile.builder(packageName, channelClass).build();
        javaFile.writeTo(System.out);
    }

    @Test
    public void addField() throws Exception {
        TypeSpec channelClass = TypeSpec.classBuilder(interfaceClassName.simpleName() + "Stub")
                .addModifiers(Modifier.PUBLIC, Modifier.ABSTRACT)
                .superclass(ClassName.bestGuess("com.infiniteloop.fidl.Binder"))
                .addSuperinterface(Class.forName(interfaceClassName.canonicalName()))
                .addField(FieldSpec.builder(String.class, "CHANNEL_NAME", Modifier.PRIVATE, Modifier.STATIC, Modifier.FINAL)
                        .initializer(interfaceClassName.simpleName()).build())
                .build();
        JavaFile javaFile = JavaFile.builder(packageName, channelClass).build();
        javaFile.writeTo(System.out);
    }

    @Test
    public void addMethod() throws Exception {
        ClassName interfaceClassName = ClassName.get(packageName, className);
        TypeSpec channelClass = TypeSpec.classBuilder(interfaceClassName.simpleName() + "Stub")
                .addModifiers(Modifier.PUBLIC, Modifier.ABSTRACT)
                .superclass(ClassName.bestGuess("com.infiniteloop.fidl.Binder"))
                .addSuperinterface(Class.forName(interfaceClassName.canonicalName()))

                .addField(FieldSpec.builder(String.class, "CHANNEL_NAME", Modifier.PRIVATE, Modifier.STATIC, Modifier.FINAL)
                        .initializer(interfaceClassName.simpleName()).build())

                .addMethod(MethodSpec.methodBuilder("getChannelName")
                        .addAnnotation(Override.class)
                        .addModifiers(Modifier.PUBLIC).returns(String.class)
                        .addStatement("return CHANNEL_NAME").build())

                .addMethod(MethodSpec.methodBuilder("onMethodCall")
                        .addAnnotation(Override.class)
                        .addModifiers(Modifier.PUBLIC)
                        .addParameter(Class.forName("com.infinateloop.fidl.MethodCall"), "call")
                        .addParameter(Class.forName("com.infinateloop.fidl.MethodChannel$Result"), "result")
                        .returns(TypeName.VOID)
                        .addStatement("").build())
                .build();
        JavaFile javaFile = JavaFile.builder(packageName, channelClass).build();
        javaFile.writeTo(System.out);
    }

    @Test
    public void addInnerMethodParams() throws Exception {
        ClassName interfaceClassName = ClassName.get(packageName, className);
        TypeSpec channelClass = TypeSpec.classBuilder(interfaceClassName.simpleName() + "Stub")
                .addModifiers(Modifier.PUBLIC, Modifier.ABSTRACT)
                .superclass(ClassName.bestGuess("com.infiniteloop.fidl.Binder"))
                .addSuperinterface(Class.forName(interfaceClassName.canonicalName()))

                .addField(FieldSpec.builder(String.class, "CHANNEL_NAME", Modifier.PRIVATE, Modifier.STATIC, Modifier.FINAL)
                        .initializer(interfaceClassName.simpleName()).build())

                .addMethod(MethodSpec.methodBuilder("getChannelName")
                        .addAnnotation(Override.class)
                        .addModifiers(Modifier.PUBLIC).returns(String.class)
                        .addStatement("return CHANNEL_NAME").build())

                .addMethod(MethodSpec.methodBuilder("onMethodCall")
                        .addAnnotation(Override.class)
                        .addModifiers(Modifier.PUBLIC)
                        .addParameter(Class.forName("com.infinateloop.fidl.MethodCall"), "call")
                        .addParameter(Class.forName("com.infinateloop.fidl.FlutterPlugin$Result"), "result")
                        .returns(TypeName.VOID)
                        .addStatement("").build())
                .build();
        JavaFile javaFile = JavaFile.builder(packageName, channelClass).build();
        javaFile.writeTo(System.out);
    }

    @Test
    public void generateCodeBlock() throws Exception {
        ClassName interfaceClassName = ClassName.get(packageName, className);
        Class interfaceClass = Class.forName(interfaceClassName.canonicalName());
        Method[] methods = interfaceClass.getMethods();
        CodeBlock.Builder blockBuilder = CodeBlock.builder();
        if (methods.length > 0) {
            generateCode(methods, blockBuilder);
        }

        TypeSpec channelClass = TypeSpec.classBuilder(interfaceClassName.simpleName() + "Stub")
                .addModifiers(Modifier.PUBLIC, Modifier.ABSTRACT)
                .superclass(ClassName.bestGuess("com.infiniteloop.fidl.Binder"))
                .addSuperinterface(Class.forName(interfaceClassName.canonicalName()))

                .addField(FieldSpec.builder(String.class, "CHANNEL_NAME", Modifier.PRIVATE, Modifier.STATIC, Modifier.FINAL)
                        .initializer("\"$L\"", interfaceClassName.canonicalName()).build())

                .addMethod(MethodSpec.methodBuilder("getChannelName")
                        .addAnnotation(Override.class)
                        .addModifiers(Modifier.PUBLIC).returns(String.class)
                        .addStatement("return CHANNEL_NAME").build())

                .addMethod(MethodSpec.methodBuilder("onMethodCall")
                        .addAnnotation(Override.class)
                        .addModifiers(Modifier.PUBLIC)
                        .addParameter(Class.forName("com.infinateloop.fidl.MethodCall"), "call")
                        .addParameter(Class.forName("com.infinateloop.fidl.FlutterPlugin$Result"), "result")
                        .returns(TypeName.VOID)
                        .addCode(blockBuilder.build()).build())
                .build();
        JavaFile javaFile = JavaFile.builder(packageName, channelClass).build();
        javaFile.writeTo(System.out);
    }

    private boolean isBasicType(Type type) {
        return type.equals(void.class) || type.equals(Void.TYPE) ||
                type.equals(boolean.class) || type.equals(Boolean.TYPE) ||
                type.equals(byte.class) || type.equals(Byte.TYPE) ||
                type.equals(short.class) || type.equals(Short.TYPE) ||
                type.equals(int.class) || type.equals(Integer.TYPE) ||
                type.equals(long.class) || type.equals(Long.TYPE) ||
                type.equals(float.class) || type.equals(Float.TYPE) ||
                type.equals(double.class) || type.equals(Double.TYPE) ||
                type.equals(String.class) ||
                type.equals(byte[].class) || type.equals(Byte[].class) ||
                type.equals(int[].class) || type.equals(Integer[].class) ||
                type.equals(long[].class) || type.equals(Long[].class) ||
                type.equals(double[].class) || type.equals(Double[].class) ||
                type.equals(List.class) ||
                type.equals(Map.class);
    }

    private void generateCode(Method[] methods, CodeBlock.Builder builder) {
        for (Method method : methods) {

            ClassName jsonIteratorClazz = ClassName.get("com.jsoniter", "JsonIterator");
            ClassName typeLiteralClazz = ClassName.get("com.jsoniter.spi", "TypeLiteral");

            builder.beginControlFlow("if(call.method.equals(\"$L\"))", method.getName());
            Type[] parameterTypes = method.getGenericParameterTypes();
            Type returnType = method.getGenericReturnType();
            if (parameterTypes.length > 0) {
                for (int i = 0; i < parameterTypes.length; i++) {
                    // 参数类型判断
                    if (isBasicType(parameterTypes[i])) {
                        builder.addStatement("$T p$L = call.argument(\"$L\")", parameterTypes[i], i, i);
                    } else {
                        builder.addStatement("$T json$L = call.argument(\"$L\")", String.class, i, i);
                        builder.addStatement("$T p$L = $T.deserialize(json$L, new $T<$T>(){})", parameterTypes[i], i, jsonIteratorClazz, i, typeLiteralClazz, parameterTypes[i]);
                    }
                }
            }

            if (returnType.equals(Void.TYPE)) {
                builder.add("$L(", method.getName());
            } else {
                builder.add("$T ret = $L(", returnType, method.getName());
            }
            for (int i = 0; i < parameterTypes.length; i++) {
                if (i == parameterTypes.length - 1) {
                    builder.add("p$L", i);
                } else {
                    builder.add("p$L,", i);
                }
            }
            builder.add(");\n");

            if (returnType.equals(Void.TYPE)) {
                builder.addStatement("result.success(null)");
            } else {
                builder.addStatement("result.success(ret)");
            }
            builder.addStatement("return");

            builder.endControlFlow();
        }
    }

    @Test
    public void getInterfaceMethods() throws Exception {
        Class clazz = Class.forName("com.infinateloop.fidl.IUserService");
        Method[] methods = clazz.getMethods();
        for (Method method : methods) {
            System.out.println(method.getName() + ":");
            System.out.println("params:");
            Type[] types = method.getGenericParameterTypes();
            if (types.length > 0) {
                for (int i = 0; i < types.length; i++) {
                    System.out.println(i + ":" + types[i]);
                }
            } else {
                System.out.println("void");
            }
//            System.out.println("signature:"+method.get);
            Type returnType = method.getGenericReturnType();
            System.out.println("return:" + returnType.toString());
            System.out.println(returnType.equals(void.class));
        }
    }
}
