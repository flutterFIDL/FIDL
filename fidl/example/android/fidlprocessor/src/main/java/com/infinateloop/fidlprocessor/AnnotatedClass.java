package com.infinateloop.fidlprocessor;

import com.squareup.javapoet.ClassName;
import com.squareup.javapoet.CodeBlock;
import com.squareup.javapoet.FieldSpec;
import com.squareup.javapoet.JavaFile;
import com.squareup.javapoet.MethodSpec;
import com.squareup.javapoet.ParameterizedTypeName;
import com.squareup.javapoet.TypeName;
import com.squareup.javapoet.TypeSpec;
import com.sun.tools.javac.code.Type;

import java.util.List;

import javax.lang.model.element.Modifier;
import javax.lang.model.element.TypeElement;
import javax.lang.model.type.TypeKind;
import javax.lang.model.util.Elements;

public class AnnotatedClass {

    public TypeElement mClassElement;
    public Elements mElementUtils;
    public FidlStructure structure;

    public AnnotatedClass(TypeElement classElement, Elements elementUtils, FidlStructure structure) {
        this.mClassElement = classElement;
        this.mElementUtils = elementUtils;
        this.structure = structure;
    }

    //获取包名
    public String getPackageName(TypeElement type) {
        return mElementUtils.getPackageOf(type).getQualifiedName().toString();
    }

    //获取类名
    private static String getClassName(TypeElement type, String packageName) {
        int packageLen = packageName.length() + 1;
        return type.getQualifiedName().toString().substring(packageLen).replace('.', '$');
    }

    public JavaFile generateFidlStubClass() throws Exception {
        String packageName = getPackageName(mClassElement);
        String className = getClassName(mClassElement, packageName);

        ClassName interfaceClassName = ClassName.get(packageName, className);

        List<FidlStructure.Method> methods = structure.methods;
        CodeBlock.Builder blockBuilder = CodeBlock.builder();
        if (methods.size() > 0) {
            generateFidlStubCodeBlock(methods, blockBuilder);
        }

        // Stub 类继承 Channel 类，实现其中的 getChannelName 和 onMethodCall方法
        TypeSpec channelClass = TypeSpec.classBuilder(interfaceClassName.simpleName() + "Stub")
                .addModifiers(Modifier.PUBLIC, Modifier.ABSTRACT)
                .superclass(ClassName.bestGuess("com.infiniteloop.fidl.Channel"))
                .addSuperinterface(ParameterizedTypeName.get(mClassElement.asType()))

                .addField(FieldSpec.builder(String.class, "CHANNEL_NAME", Modifier.PRIVATE, Modifier.STATIC, Modifier.FINAL)
                        .initializer("\"$L\"", interfaceClassName.canonicalName()).build())

                .addMethod(MethodSpec.methodBuilder("getChannelName")
                        .addAnnotation(Override.class)
                        .addModifiers(Modifier.PUBLIC).returns(String.class)
                        .addStatement("return CHANNEL_NAME").build())

                .addMethod(MethodSpec.methodBuilder("onMethodCall")
                        .addAnnotation(Override.class)
                        .addModifiers(Modifier.PUBLIC)
                        .addParameter(TypeName.get(String.class), "method")
                        .addParameter(ParameterizedTypeName.get(List.class, byte[].class), "arguments")
                        .returns(TypeName.OBJECT)
                        .addCode(blockBuilder.build())
                        .addStatement("return null").build())
                .build();


        JavaFile javaFile = JavaFile.builder(packageName, channelClass).build();
//        try {
//            javaFile.writeTo(System.out);
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
        return javaFile;
    }

    /**
     * 解析FIDL接口中的方法，生成解析参数和返回值的代码
     * 例如：
     * if(method.equals("setupConversation")) {
     * Conversation p0 = FidlChannel.objectCodec.decode(arguments.get(0),new TypeLiteral<Conversation>(){});
     * setupConversation(p0);
     * return null;
     * }
     * if(method.equals("getConversationDesc")) {
     * String ret = getConversationDesc();
     * return ret;
     * }
     */
    private void generateFidlStubCodeBlock(List<FidlStructure.Method> methods, CodeBlock.Builder builder) {
        for (FidlStructure.Method method : methods) {
            ClassName clsFidlChannel = ClassName.bestGuess("com.infiniteloop.fidl.FidlChannel");
            ClassName clsTypeLiteral = ClassName.bestGuess("com.infiniteloop.fidl.TypeLiteral");

            builder.beginControlFlow("if(method.equals(\"$L\"))", method.name);
            List<FidlStructure.Parameter> parameterTypes = method.parameters;

            Type returnType = method.returns;
            if (parameterTypes.size() > 0) {
                for (int i = 0; i < method.parameters.size(); i++) {
                    Type paramType = parameterTypes.get(i).type;
                    // 参数类型判断
                    builder.addStatement("$T p$L = $T.objectCodec.decode(arguments.get($L),new $T<$T>(){})", paramType, i, clsFidlChannel, i, clsTypeLiteral, paramType);
                }
            }

            if (returnType.getKind() == TypeKind.VOID) {
                builder.add("$L(", method.name);
            } else {
                builder.add("$T ret = $L(", returnType, method.name);
            }
            for (int i = 0; i < parameterTypes.size(); i++) {
                if (i == parameterTypes.size() - 1) {
                    builder.add("p$L", i);
                } else {
                    builder.add("p$L, ", i);
                }
            }
            builder.add(");\n");

            if (returnType.getKind() != TypeKind.VOID) {
                builder.addStatement("return ret");
            } else {
                builder.addStatement("return null");
            }
            builder.endControlFlow();
        }
    }
}