package com.infinateloop.fidlprocessor;

import com.sun.tools.javac.code.Scope;
import com.sun.tools.javac.code.Symbol;
import com.sun.tools.javac.code.Type;
import com.sun.tools.javac.code.TypeTag;
import com.sun.tools.javac.util.Filter;

import java.util.ArrayList;
import java.util.List;

import javax.lang.model.element.ElementKind;
import javax.lang.model.type.TypeKind;

import static com.infinateloop.fidlprocessor.TypeUtils.isList;
import static com.infinateloop.fidlprocessor.TypeUtils.isMap;
import static com.infinateloop.fidlprocessor.TypeUtils.isSet;
import static com.infinateloop.fidlprocessor.TypeUtils.typeEquals;

public class JsonFidlStructure {
    public String cls;
    public String kind;
    public List<Method> methods = new ArrayList<>();

    public static JsonFidlStructure from(FidlStructure structure) {
        JsonFidlStructure fidlStructure = new JsonFidlStructure(structure.className);
        for (FidlStructure.Method method : structure.methods) {
            Method mMethod = new Method(method.name, typeToString(method.returns));
            for (FidlStructure.Parameter parameter : method.parameters) {
                String type;
                if (parameter.type.asElement().getKind() == ElementKind.ENUM) {
                    type = "@enum(" + parameter.type.toString() + ")";
                } else {
                    type = typeToString(parameter.type);
                }
                mMethod.parameters.add(new Parameter(parameter.name, type));
            }
            fidlStructure.methods.add(mMethod);
        }
        fidlStructure.kind = "fidl";
        return fidlStructure;
    }

    private JsonFidlStructure(String className) {
        this.cls = className;
    }

    private static class Method {
        public String name;
        public String returns;
        public List<Parameter> parameters = new ArrayList<>();

        public Method(String name, String returns) {
            this.name = name;
            this.returns = returns;
        }
    }

    public static class Parameter {
        public String name;
        public String type;

        public Parameter(String name, String type) {
            this.name = name;
            this.type = type;
        }
    }

    public static class Class {
        public String type;
        public String kind;
        public List<Parameter> fields = new ArrayList<>();
        public String superType;

        private Class(String type) {
            this.type = type;
        }

        public static Class from(FidlStructure.Class clazz) {
            Class mClazz = new Class(typeToString(clazz.type));
            mClazz.superType = getSuperTypeString(clazz.type);
            for (FidlStructure.Parameter parameter : clazz.fields) {
                if (parameter.type.asElement().getKind() == ElementKind.ENUM) {
                    mClazz.fields.add(new Parameter(parameter.name, parameter.type.asElement().getQualifiedName().toString()));
                } else {
                    mClazz.fields.add(new Parameter(parameter.name, typeToString(parameter.type)));
                }
            }
            mClazz.kind = getTypeKind(clazz.type);
            return mClazz;
        }
    }

    private static String getSuperTypeString(Type type) {
        if (type.asElement().getKind() == ElementKind.ENUM) {
            return "";
        }
        if (type.getTag() == TypeTag.CLASS) {
            Type mType = ((Type.ClassType) type).supertype_field;
            if (mType != null) {
                return typeToString(mType);
            }
        }
        return "";
    }

    private static String typeToString(Type type) {
        if (typeEquals(type, void.class, Void.class)) {
            return "void";
        }
        if (typeEquals(type, boolean.class, Boolean.class)) {
            return "bool";
        }
        if (typeEquals(type, byte.class, Byte.class)) {
            return "byte";
        }
        if (typeEquals(type, short.class, Short.class)) {
            return "short";
        }
        if (typeEquals(type, int.class, Integer.class)) {
            return "int";
        }
        if (typeEquals(type, long.class, Long.class)) {
            return "long";
        }
        if (typeEquals(type, char.class, Character.class)) {
            return "char";
        }
        if (typeEquals(type, float.class, Float.class)) {
            return "float";
        }
        if (typeEquals(type, double.class, Double.class)) {
            return "double";
        }
        if (typeEquals(type, String.class)) {
            return "String";
        }
        if (type.getKind() == TypeKind.ARRAY) {
            Type.ArrayType arrayType = (Type.ArrayType) type;
            return "@list(" + typeToString(arrayType.elemtype) + ")";
        }

        if (type.getKind() == TypeKind.TYPEVAR) {
            // "?" 符号修饰泛型
            // TODO 支持泛型限制
            return "@Generic(" + type.toString() + ")"; // 泛型
        }

        if (type.toString().equals("java.lang.Object")) {
            return "?";
        }

        if (type.asElement().getKind() == ElementKind.ENUM) {
            StringBuilder sb = new StringBuilder(type.toString());
            sb.append("(");
            Scope scope = type.tsym.members();
            if (scope != null) {
                int size = 0;
                for (Symbol symbol : scope.getElements(new Filter<Symbol>() {
                    @Override
                    public boolean accepts(Symbol symbol) {
                        return symbol.getKind() == ElementKind.ENUM_CONSTANT;
                    }
                })) {
                    sb.append(symbol.toString());
                    sb.append(",");
                    size++;
                }
                if (size > 0) {
                    sb.setLength(sb.length() - 1);
                }
            }
            sb.append(")");
            return sb.toString();
        }

        if (!(type instanceof Type.ClassType)) {
            return type.toString();
        }

        Type.ClassType classType = (Type.ClassType) type;
        if (isSet(classType)) {
            List<Type> fields = classType.typarams_field;
            StringBuilder sb = new StringBuilder("@set(");
            if (fields != null && fields.size() > 0) {
                for (Type subType : fields) {
                    sb.append(typeToString(subType));
                }
            } else {
                sb.append("?");
            }
            sb.append(")");
            return sb.toString();
        }

        if (isList(classType)) {
            List<Type> fields = classType.typarams_field;
            StringBuilder sb = new StringBuilder("@list(");
            if (fields != null && fields.size() > 0) {
                for (Type subType : fields) {
                    sb.append(typeToString(subType));
                }
            } else {
                sb.append("?");
            }
            sb.append(")");
            return sb.toString();
        }

        if (isMap(classType)) {
            List<Type> fieldTypes = classType.typarams_field;
            if (fieldTypes == null || fieldTypes.size() == 0) {
                return "@map()";
            } else {
                return "@map(" + typeToString(fieldTypes.get(0))
                        + "," + typeToString(fieldTypes.get(1)) + ")";
            }
        }

        List<Type> fieldTypes = classType.typarams_field;
        if (fieldTypes != null && fieldTypes.size() > 0) {
            StringBuilder sb = new StringBuilder(classType.tsym.toString() + "(");
            for (int i = 0; i < fieldTypes.size(); i++) {
                sb.append(typeToString(fieldTypes.get(i)));
                if (i != fieldTypes.size() - 1) {
                    sb.append(",");
                }
            }
            sb.append(")");
            return sb.toString();
        }
        return type.toString();
    }

    private static String getTypeKind(Type type) {
        switch (type.asElement().getKind()) {
            case ENUM:
                return "enum";
            case CLASS:
            case INTERFACE:
                return "class";
            default:
                return "unknown";
        }
    }
}

