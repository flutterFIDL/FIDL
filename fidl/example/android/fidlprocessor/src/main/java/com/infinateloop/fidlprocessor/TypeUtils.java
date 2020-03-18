package com.infinateloop.fidlprocessor;

import com.squareup.javapoet.TypeName;
import com.sun.tools.javac.code.Scope;
import com.sun.tools.javac.code.Symbol;
import com.sun.tools.javac.code.Type;
import com.sun.tools.javac.code.TypeTag;
import com.sun.tools.javac.util.Filter;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.lang.model.element.Element;
import javax.lang.model.element.ElementKind;
import javax.lang.model.element.Modifier;
import javax.lang.model.type.TypeMirror;

public class TypeUtils {
    public static boolean isBasicType(Type type) {
        if (type.isPrimitiveOrVoid()) {
            return true;
        }
        return typeEquals(type,
                void.class, Void.class,
                boolean.class, Boolean.class,
                byte.class, Byte.class,
                short.class, Short.class,
                int.class, Integer.class,
                long.class, Long.class,
                char.class, Character.class,
                float.class, Float.class,
                double.class, Double.class,
                String.class,
                List.class,
                Map.class);
    }

    public static String typeToClassType(Type type) {
        if (typeEquals(type, void.class, Void.class)) {
            return "Void";
        }
        if (typeEquals(type, boolean.class, Boolean.class)) {
            return "Boolean";
        }
        if (typeEquals(type, byte.class, Byte.class)) {
            return "Byte";
        }
        if (typeEquals(type, short.class, Short.class)) {
            return "Short";
        }
        if (typeEquals(type, int.class, Integer.class)) {
            return "Integer";
        }
        if (typeEquals(type,
                long.class, Long.class)) {
            return "Long";
        }
        if (typeEquals(type, char.class, Character.class)) {
            return "Character";
        }
        if (typeEquals(type, float.class, Float.class)) {
            return "Float";
        }
        if (typeEquals(type, double.class, Double.class)) {
            return "Double";
        }
        return type.toString();
    }

    public static boolean typeEquals(Type type, Class... clazz) {
        TypeName typeName = argToType(type);
        for (Class cls : clazz) {
            if (typeName.equals(argToType(cls))) {
                return true;
            }
        }
        return false;
    }

    private static void collectNonBasicType(Type type, Set<Type> result) {
        if (type == null) {
            return;
        }
        if (TypeUtils.isBasicType(type)) {
            return;
        }
        if (result.contains(type)) {
            return;
        }

        // 处理不同的TypeTag类型，有ARRAY,CLASS
        TypeTag tag = type.getTag();
        if (tag == TypeTag.ARRAY) {
            Type elemType = ((Type.ArrayType) type).elemtype;
            if (elemType != null) {
                collectNonBasicType(elemType, result);
            }
            return;
        }

        if (tag != TypeTag.CLASS) {
            return;
        }
        Type.ClassType clsType = (Type.ClassType) type;
        // 处理ENUM枚举类
        if (clsType.tsym.getKind() == ElementKind.ENUM) {
            result.add(clsType);
            return;
        }

        // 处理泛型参数
        List<Type> params = clsType.typarams_field;
        if (params != null && params.size() > 0) {
            Set<Type> typeSet = new HashSet<>(params);
            collectNonBasicTypes(typeSet, result);
        }

        // 处理List/Map/Set/Queue等集合类
        if (isSet(clsType)) {
            return;
        }
        if (isList(clsType)) {
            return;
        }
        if (isMap(clsType)) {
            return;
        }

        if (clsType.tsym.type.toString().equals("java.lang.Object")) {
            return;
        }

        result.add(clsType.tsym.type);

        // 处理父类
        Type superType = ((Type.ClassType) type.tsym.type).supertype_field;
        if (superType != null) {
            collectNonBasicType(superType, result);
        }

        // 处理类型内部的成员变量的参数类型
        Scope scope = clsType.tsym.members();
        if (scope == null) {
            return;
        }
        for (Symbol symbol : scope.getElements(new Filter<Symbol>() {
            @Override
            public boolean accepts(Symbol symbol) {
                return symbol instanceof Symbol.VarSymbol &&
                        (!symbol.getModifiers().contains(Modifier.STATIC)) &&
                        (symbol.getKind() != ElementKind.ENUM);
            }
        })) {
            collectNonBasicType(symbol.type, result);
        }
    }

    public static void collectNonBasicTypes(Set<Type> types, Set<Type> result) {
        if (types == null) {
            return;
        }
        for (Type mType : types) {
            collectNonBasicType(mType, result);
        }
    }

    /**
     * 获取Type内部的成员变量参数和变量类型
     */
    public static List<FidlStructure.Parameter> getTypeFields(Type type) {
        List<FidlStructure.Parameter> types = new ArrayList<>();
        Scope scope = type.tsym.members();
        if (scope == null) {
            return types;
        }
        for (Symbol symbol : scope.getElements(new Filter<Symbol>() {
            @Override
            public boolean accepts(Symbol symbol) {
                return symbol instanceof Symbol.VarSymbol && (!symbol.getModifiers().contains(Modifier.STATIC));
            }
        })) {
            // enum 元素处理
            types.add(new FidlStructure.Parameter(symbol.name.toString(), symbol.type));
        }
        return types;
    }

    public static TypeName argToType(Object o) {
        if (o instanceof TypeName) {
            return (TypeName) o;
        } else if (o instanceof TypeMirror) {
            return TypeName.get((TypeMirror) o);
        } else if (o instanceof Element) {
            return TypeName.get(((Element) o).asType());
        } else if (o instanceof java.lang.reflect.Type) {
            return TypeName.get((java.lang.reflect.Type) o);
        } else {
            throw new IllegalArgumentException("expected type but was " + o);
        }
    }

    public static boolean isTypeExtends(Type.ClassType type, String... typeName) {
        // 参考instanceof的实现方法，遍历super链直到Object
        for (String name : typeName) {
            if (type.toString().equals(name) ||
                    type.tsym.toString().equals(name)) {
                return true;
            }
        }
        if (type.toString().equals("java.lang.Object")) {
            return false;
        }
        if (type.tsym.type.getTag() != TypeTag.CLASS) {
            return false;
        }

        List<Type> superTypes = ((Type.ClassType) type.tsym.type).interfaces_field;
        if (superTypes != null) {
            for (Type mType : superTypes) {
                if (mType.getTag() == TypeTag.CLASS) {
                    if (isTypeExtends((Type.ClassType) mType, typeName)) {
                        return true;
                    }
                }
            }
        }

        Type superType = ((Type.ClassType) type.tsym.type).supertype_field;
        if (superType != null && superType.getTag() == TypeTag.CLASS) {
            return isTypeExtends((Type.ClassType) superType, typeName);
        }
        return false;
    }
    // TODO 修改isBasicType方法，加上list/map/queue/stack的判定

    public static boolean isList(Type.ClassType type) {
        return isTypeExtends(type, "java.util.List", "java.util.Collection");
    }

    public static boolean isSet(Type.ClassType type) {
        return isTypeExtends(type, "java.util.Set");
    }

    public static boolean isMap(Type.ClassType type) {
        return isTypeExtends(type, "java.util.Map");
    }
}
