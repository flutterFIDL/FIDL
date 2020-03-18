package com.infinateloop.fidlprocessor;

import com.sun.tools.javac.code.Type;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class FidlStructure {
    public String className;
    public List<Method> methods = new ArrayList<>();

    public FidlStructure(String className, List<Method> methodList) {
        this.className = className;
        this.methods.addAll(methodList);
    }

    public static class Method {
        public String name;
        public Type returns;
        public List<Parameter> parameters = new ArrayList<>();

        public Method(String name, Type returns, List<Parameter> parameterList) {
            this.name = name;
            this.returns = returns;
            this.parameters.addAll(parameterList);
        }
    }

    public static class Parameter {
        public String name;
        public Type type;

        public Parameter(String name, Type type) {
            this.name = name;
            this.type = type;
        }
    }

    public static class Class {
        public Type type;
        public List<Parameter> fields;

        public Class(Type type) {
            this.type = type;
            fields = TypeUtils.getTypeFields(type);
        }
    }

    public Set<Type> getTypes() {
        Set<Type> list = new HashSet<>();
        for (Method method : methods) {
            list.add(method.returns);
            for (Parameter parameter : method.parameters) {
                list.add(parameter.type);
            }
        }
        return list;
    }
}
