package com.infinateloop.fidlprocessor;

import com.infinateloop.fidl.annotation.FIDL;
import com.jsoniter.output.JsonStream;
import com.sun.tools.javac.code.Symbol;
import com.sun.tools.javac.code.Type;
import com.sun.tools.javac.model.FilteredMemberList;

import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.processing.AbstractProcessor;
import javax.annotation.processing.Filer;
import javax.annotation.processing.ProcessingEnvironment;
import javax.annotation.processing.RoundEnvironment;
import javax.lang.model.SourceVersion;
import javax.lang.model.element.Element;
import javax.lang.model.element.ElementKind;
import javax.lang.model.element.TypeElement;
import javax.lang.model.util.Elements;
import javax.tools.FileObject;
import javax.tools.StandardLocation;

public class FIDLAnnotationProcessor extends AbstractProcessor {

    private Filer mFiler;
    private Elements mElements;
    private Map<String, AnnotatedClass> mAnnotatedClassMap = new HashMap<>();

    @Override
    public synchronized void init(ProcessingEnvironment processingEnv) {
        super.init(processingEnv);
        mElements = processingEnv.getElementUtils();
        mFiler = processingEnv.getFiler();
    }

    @Override
    public boolean process(Set<? extends TypeElement> annotations, RoundEnvironment roundEnv) {
        mAnnotatedClassMap.clear();
        Set<Type> collections = new HashSet<>();
        for (Element element : roundEnv.getElementsAnnotatedWith(FIDL.class)) {
            if (element.getKind() == ElementKind.INTERFACE) {
                collectAnnotatedClass(element, collections);
            } else {
                throw new IllegalArgumentException(String.format("FIDL annotation supports only interface, so % is not valid", element.getSimpleName()));
            }
        }

        for (AnnotatedClass annotatedClass : mAnnotatedClassMap.values()) {
            try {
                // generate FIDL json
                annotatedClass.generateFidlStubClass().writeTo(mFiler);
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
        }

        // generate Classes json
        List<FidlStructure.Class> classes = new ArrayList<>();
        for (Type type : collections) {
            classes.add(new FidlStructure.Class(type));
        }

        for (FidlStructure.Class clazz : classes) {
            JsonFidlStructure.Class jClazz = JsonFidlStructure.Class.from(clazz);
            FileObject fileObject = null;
            try {
                fileObject = mFiler.createResource(StandardLocation.SOURCE_OUTPUT, "", clazz.type.tsym.getQualifiedName().toString() + ".json");
                Writer writer = fileObject.openWriter();
                writer.write(JsonStream.serialize(jClazz));
                writer.flush();
                writer.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        return true;
    }

    @Override
    public Set<String> getSupportedAnnotationTypes() {
        Set<String> types = new LinkedHashSet<>();
        types.add(FIDL.class.getCanonicalName());
        return types;
    }

    @Override
    public SourceVersion getSupportedSourceVersion() {
        return SourceVersion.latestSupported();
    }

    private void collectAnnotatedClass(Element element, Set<Type> typeSet) {
        TypeElement mElement = (TypeElement) element;

        FilteredMemberList members = (FilteredMemberList) mElements.getAllMembers(mElement);
        Iterator<Symbol> iterator = members.iterator();
        List<FidlStructure.Method> methodList = new ArrayList<>();
        while (iterator.hasNext()) {
            Symbol symbol = iterator.next();
            if (!(symbol.type instanceof Type.MethodType) ||
                    symbol.owner.flatName().contentEquals(Object.class.getName())) {
                continue;
            }

            Symbol.MethodSymbol mSymbol = (Symbol.MethodSymbol) symbol;
            List<FidlStructure.Parameter> parameters = new ArrayList<>();
            if (mSymbol.params != null) {
                for (Symbol.VarSymbol var : mSymbol.params) {
                    parameters.add(new FidlStructure.Parameter(var.name.toString(), var.type));
                }
            }
            methodList.add(new FidlStructure.Method(mSymbol.name.toString(), ((Type.MethodType) mSymbol.type).restype, parameters));
        }

        String fullClassName = mElement.getQualifiedName().toString();
        FidlStructure structure = new FidlStructure(fullClassName, methodList);
        AnnotatedClass annotatedClass = mAnnotatedClassMap.get(fullClassName);
        if (annotatedClass == null) {
            annotatedClass = new AnnotatedClass(mElement, mElements, structure);
            mAnnotatedClassMap.put(fullClassName, annotatedClass);

            try {
                FileObject fileObject = mFiler.createResource(StandardLocation.SOURCE_OUTPUT, "", structure.className + ".fidl.json");
                Writer writer = fileObject.openWriter();
                Set<Type> types = structure.getTypes();
                writer.write(JsonStream.serialize(JsonFidlStructure.from(structure)));
                writer.flush();
                writer.close();

                TypeUtils.collectNonBasicTypes(types, typeSet);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
