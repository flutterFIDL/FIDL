library fidl_model;

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:args/args.dart';
import 'package:path/path.dart' as path;
import 'build_runner.dart' as br;

const tpl = "import 'package:json_annotation/json_annotation.dart';\n"
    "%t\n"
    "part '%s.g.dart';\n\n"
    "@JsonSerializable()\n"
    "class %s {\n"
    "  %s();\n\n"
    "  %s\n"
    "  factory %s.fromJson(Map<String, dynamic> json) => _\$%sFromJson(json);\n\n"
    "  Map<String, dynamic> toJson() => _\$%sToJson(this);\n"
    "}\n";

const enumTpl = "enum %s {\n"
    "%s"
    "}\n";

void main(List<String> args) {
  String src;
  String dist;
  String tag;
  var parser = new ArgParser();
  parser.addOption('src',
      defaultsTo: './fidl',
      callback: (v) => src = v,
      help: "Specify the json directory.");
  parser.addOption('dist',
      defaultsTo: 'lib/fidl',
      callback: (v) => dist = v,
      help: "Specify the dist directory.");
  parser.addOption('tag',
      defaultsTo: '\$', callback: (v) => tag = v, help: "Specify the tag ");
  parser.parse(args);
  if (walk(src, dist, tag)) {
    br.run(['build', '--delete-conflicting-outputs']);
  }
}

bool walk(String srcDir, String distDir, String tag) {
  if (srcDir.endsWith("/")) srcDir = srcDir.substring(0, srcDir.length - 1);
  if (distDir.endsWith("/")) distDir = distDir.substring(0, distDir.length - 1);
  var src = Directory(srcDir);
  var list = src.listSync(recursive: true);
  String indexFile = "";
  if (list.isEmpty) return false;
  if (!Directory(distDir).existsSync()) {
    Directory(distDir).createSync(recursive: true);
  }

  list.forEach((f) {
    if (FileSystemEntity.isFileSync(f.path)) {
      var paths = path.basename(f.path).split(".");
      String basename = path.basename(f.path);
      if (basename.length > 9 && basename.endsWith("fidl.json")) {
        print('fidl code object');
        generateFidlFile(f, srcDir, distDir);
        return;
      }
      if (paths.last.toLowerCase() != "json") return;
      generateModelFile(f, srcDir, distDir);
    }
  });
//  if (indexFile.isNotEmpty) {
//    File(path.join(distDir, "index.dart")).writeAsStringSync(indexFile);
//  }
//  return indexFile.isNotEmpty;
  return true;
}

void generateModelFile(File f, String srcDir, String distDir) {
  String basename = path.basename(f.path);
  basename = basename.substring(0, basename.lastIndexOf("."));
  int index = basename.lastIndexOf(".");
  String name;
  String dirPath;
  if (index < 0) {
    name = basename;
    dirPath = '.';
  } else {
    name = basename.substring(index + 1);
    dirPath = basename.substring(0, index);
  }
  if (name.startsWith("_")) return;

  //生成模板
  var map = json.decode(f.readAsStringSync());
  StringBuffer attrs = new StringBuffer();
  String kind = map['kind'];
  String type = map['type'];

  if (type == null || type.length < 1) {
    return;
  }

  String dist = '';
  // 保证类以大写字母为首
  String className = name[0].toUpperCase() + name.substring(1);

  if (kind == 'fidl') {
    generateFidlFile(f, srcDir, distDir);
    return;
  } else if (kind == 'enum') {
    int leftIndex = type.indexOf('(');
    if (leftIndex >= 0) {
      int rightIndex = type.lastIndexOf(')');
      String middle = type.substring(leftIndex + 1, rightIndex);
      // 生成枚举
      // 对于没有元素的枚举，自动添加一个`none`元素，否则会有dart语法错误
      if (middle.length < 1) {
        attrs.writeln("  none");
      } else {
        List<String> fields = middle.split(',');
        fields.forEach((field) {
          attrs.write("  ");
          attrs.write(field);
          attrs.writeln(',');
        });
      }
    }

    dist = format(enumTpl, [className, attrs.toString()]);
  } else if (kind == 'class') {
    print('class type.');

    String superType = map['superType'];
    List<dynamic> list = map['fields'];
    Map<String, String> imports = Map<String, String>();

    String classDesc = parseType(type, imports);
    if (superType != null && superType.length > 0) {
      classDesc += ' extends ' + parseType(superType, imports);
    }

    // 遍历内部变量
    list.forEach((field) {
      String fieldType = field['type'];
      if (fieldType.contains('@Generic')) {
        // @GenericConverter()用于给泛型类生成fromJson/toJson方法，避免编译错误
        attrs.writeln('@GenericConverter()');
        attrs.write("  ");
        imports['package:fidl/fidl'] = '';
      }
      attrs.write(parseType(field['type'], imports));
      attrs.write(' ');
      attrs.write(field['name']);
      attrs.writeln(';');
      attrs.write("  ");
    });

    dist = format(tpl, [
      name,
      classDesc,
      className,
      attrs.toString(),
      className,
      className,
      className
    ]);

    String _import = '';
    imports.remove(basename);
    imports.forEach((String type, String alias) {
      int index = type.lastIndexOf('.');
      String package = '';
      String shortName = type;
      if (index >= 0) {
        package = type.substring(0, index);
        shortName = type.substring(index + 1);

        if (package == dirPath) {
          _import += 'import "$shortName.dart"';
        } else {
          _import += 'import "../$package/$shortName.dart"';
        }
      } else {
        _import += 'import "$shortName.dart"';
      }

      if (alias != null && alias.length > 0) {
        _import += ' as $alias';
      }
      _import += ';\n';
    });
    dist = dist.replaceFirst("%t", _import);
  } else {
    return;
  }

  //将生成的模板输出
  var p =
      f.parent.path.replaceFirst(srcDir, distDir + path.separator + dirPath);
  p += path.separator + name + '.dart';
  File(p)
    ..createSync(recursive: true)
    ..writeAsStringSync(dist);
}

String changeFirstChar(String str, [bool upper = true]) {
  return (upper ? str[0].toUpperCase() : str[0].toLowerCase()) +
      str.substring(1);
}

bool isBuiltInType(String type) {
  return ['int', 'num', 'string', 'double', 'map', 'list'].contains(type);
}

const fidlTpl = '''import 'dart:async';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:fidl/fidl.dart';
%t
part '%s.g.dart';

class %s {
  static const String CHANNEL_NAME = '%s';
  static const MethodChannel _channel =
      const MethodChannel(CHANNEL_NAME, const MultiMethodCodec());

%s
}

%s
''';

/// 生成FIDL Channel类
void generateFidlFile(File f, String srcDir, String distDir) {
  var map = json.decode(f.readAsStringSync());
  String cls = map['cls'];
  int index = cls.lastIndexOf('.');
  String package = '.';
  String clsName;
  if (index < 0) {
    clsName = cls;
  } else {
    package = cls.substring(0, index);
    clsName = cls.substring(index + 1);
  }

  Map<String, String> imports = Map<String, String>();
  List methods = map['methods'];
  StringBuffer attrs = StringBuffer();
  StringBuffer extras = StringBuffer();
  generateFidlMethods(methods, attrs, imports, extras);

  String dist = format(
      fidlTpl, [clsName, clsName, cls, attrs.toString(), extras.toString()]);

  String _import = '';
  imports.remove(cls);
  imports.forEach((String type, String alias) {
    int index = type.lastIndexOf('.');
    String packageStr = '';
    String shortName = type;
    if (index >= 0) {
      packageStr = type.substring(0, index);
      shortName = type.substring(index + 1);

      if (packageStr == package) {
        _import += 'import "$shortName.dart"';
      } else {
        _import += 'import "../$packageStr/$shortName.dart"';
      }
    } else {
      _import += 'import "$shortName.dart"';
    }

    if (alias != null && alias.length > 0) {
      _import += ' as $alias';
    }
    _import += ';\n';
  });
  dist = dist.replaceFirst("%t", _import);

  var p =
      f.parent.path.replaceFirst(srcDir, '$distDir${path.separator}$package');
  p += '${path.separator}$clsName.dart';
  File(p)
    ..createSync(recursive: true)
    ..writeAsStringSync(dist);
  var relative = p.replaceFirst(distDir + path.separator, "");
//  indexFile += "export '$relative' ; \n";
}

const innerClassTpl = "@JsonSerializable()\n"
    "class %s {\n"
    "  %s(%s);\n\n"
    "%s\n"
    "  factory %s.fromJson(Map<String, dynamic> json) => _\$%sFromJson(json);\n\n"
    "  Map<String, dynamic> toJson() => _\$%sToJson(this);\n"
    "}\n";

/// 生成FIDL类的方法，以及参数Model类和返回值Model类
void generateFidlMethods(List methods, StringBuffer attrs,
    Map<String, String> imports, StringBuffer extras) {
  int methodIndex = -1;
  methods?.forEach((method) {
    methodIndex++;

    String methodName = method['name'];
    String returns = method['returns'];
    String retType = parseType(returns, imports);
    List parameters = method['parameters'];

    // 生成内部类
    String returnClassName = 'FRet$methodIndex';

    String methodClassName = 'FParam$methodIndex';
    StringBuffer classAttr = StringBuffer();
    String methodClassConstructorAttr = '';
    String methodParams = '';

    if (!isVoidType(retType)) {
      String retClass = format(innerClassTpl, [
        returnClassName,
        returnClassName,
        'this.ret',
        '  $retType ret;\n',
        returnClassName,
        returnClassName,
        returnClassName
      ]);
      extras.write(retClass);
    }

    attrs.write('  static Future<$retType> $methodName');
    attrs.write('(');

    if (parameters != null && parameters.length > 0) {
      int i = 0;
      parameters.forEach((param) {
        String paramType = param['type'];
        String paramName = param['name'];
        String realType = parseType(paramType, imports);
        attrs.write('$realType $paramName');

        // 局部变量和构造参数
        classAttr.write('  $realType p$i;\n');
        methodClassConstructorAttr += 'this.p$i';
        methodParams += '$paramName';

        if (i != parameters.length - 1) {
          attrs.write(', ');
          methodClassConstructorAttr += ', ';
          methodParams += ', ';
        }
        i++;
      });

      String paramClass = format(innerClassTpl, [
        methodClassName,
        methodClassName,
        methodClassConstructorAttr,
        classAttr,
        methodClassName,
        methodClassName,
        methodClassName
      ]);
      extras.write(paramClass);
    }

    attrs.write(') ');
    attrs.write('async {\n');

    if (parameters != null && parameters.length > 0) {
      int i = 0;
      String encodeParams = '';
      parameters.forEach((param) {
        attrs.write(
            '    var p$i = $methodClassName($methodParams).toJson()[\'p$i\'];\n');
        encodeParams += 'p$i';
        if (i != parameters.length - 1) {
          encodeParams += ', ';
        }
        i++;
      });
      attrs
          .write('    var param = Fidl.objectCodec.encode([$encodeParams]);\n');
      attrs.write(
          '    var ret = await _channel.invokeMethod(\'$methodName\', param);\n');
    } else {
      attrs.write(
          '    var ret = await _channel.invokeMethod(\'$methodName\');\n');
    }

    if (!isVoidType(retType)) {
      attrs.write('    var json = Fidl.objectCodec.decode(ret[0]);\n');
      attrs.write('    return $returnClassName.fromJson(json).ret;\n');
    }

    attrs.write('  }\n');
  });
}

bool isBasicType(String type) {
  switch (type) {
    case 'int':
    case 'short':
    case 'byte':
    case 'long':
    case 'char':
    case 'float':
    case 'double':
    case 'String':
      return true;
  }
  return false;
}

bool isVoidType(String type) {
  return type == 'void';
}

bool isEnumType(String type) {
  return type.startsWith('@enum');
}

/// import第一个字段表示类型，第二个字段表示导入别名
/// 推算类型
String parseType(String typeName, Map<String, String> imports) {
  if (typeName == null || typeName.length < 1) {
    return "";
  }

  if (imports.containsKey(typeName)) {
    String alias = imports[typeName];
    int index = typeName.lastIndexOf('.');
    String name;
    if (index < 0) {
      name = typeName;
    } else {
      name = typeName.substring(index + 1);
    }
    if (alias != null && alias.length > 0) {
      name = alias + '.' + name;
    }
    return name;
  }

  int leftIndex = typeName.indexOf('(');
  if (leftIndex < 0) {
    switch (typeName) {
      case 'int':
      case 'short':
      case 'byte':
      case 'long': // TODO java不支持int64，java解析时应当做Long解析
      case 'char':
        return 'int';
      case 'float':
      case 'double':
        return 'double';
      case 'void':
        return 'void';
      case 'var':
        return 'dynamic';
      case 'String':
        return 'String';
      case '?':
        return 'Object';
      case 'bool':
        return 'bool';
      case '@list':
        return 'List';
      case '@set':
        return 'Set';
      case '@map':
        return 'Map';
      default:
        {
          addUniqueTypeToMap(typeName, imports);
          return parseType(typeName, imports);
        }
    }
  }

  String left = typeName.substring(0, leftIndex);
  int rightIndex = typeName.lastIndexOf(')');
  String middle = typeName.substring(leftIndex + 1, rightIndex);
  switch (left) {
    case '@list':
      {
        if (middle == null || middle.length < 1) {
          return 'List';
        }
        return 'List<' + parseType(middle, imports) + '>';
      }
    case '@set':
      {
        if (middle == null || middle.length < 1) {
          return 'Set';
        }
        return 'Set<' + parseType(middle, imports) + '>';
      }
    case '@map':
      {
        List<String> params = splitParams(middle);
        if (params.length < 2) {
          return 'Map';
        }
        return 'Map<' +
            parseType(params[0], imports) +
            ',' +
            parseType(params[1], imports) +
            '>';
      }
    case '@Generic':
      {
        return middle;
      }
    case '@enum':
      {
        addUniqueTypeToMap(middle, imports);
        return parseType(middle, imports);
      }
  }

  List<String> params = splitParams(middle);
  if (params.length < 1) {
    return parseType(typeName, imports);
  }
  String type = parseType(left, imports) + '<';
  for (int i = 0; i < params.length; i++) {
    type += parseType(params[i], imports);
    if (i != params.length - 1) {
      type += ',';
    }
  }
  type += '>';
  return type;
}

/// 解析参数
/// 如：字符串"(String,@list(String),int)"，解析后得到[String,@list(String),int]
List<String> splitParams(String typeStr) {
  List<String> params = [];
  if (typeStr == null || typeStr.length < 1) {
    return params;
  }
  int len = typeStr.length;

  int bracketsWeight = 0;
  int startIndex = 0;
  for (int i = 0; i < len; i++) {
    if (typeStr[i] == '(') {
      bracketsWeight++;
    } else if (typeStr[i] == ')') {
      bracketsWeight--;
    } else if (typeStr[i] == ',' && bracketsWeight == 0) {
      params.add(typeStr.substring(startIndex, i));
      startIndex = i + 1;
    }
    if (i == len - 1) {
      params.add(typeStr.substring(startIndex, len));
    }
  }
  return params;
}

/// 返回alias 别名
String addUniqueTypeToMap(String typeName, Map<String, String> imports) {
  if (imports.containsKey(typeName)) {
    return imports[typeName];
  }

  int index = typeName.lastIndexOf('.');
  String name;
  if (index < 0) {
    name = typeName;
  } else {
    name = typeName.substring(index + 1);
  }

  String mAlias = '';
  imports.forEach((String type, String alias) {
    if (type.endsWith('.$name') || type == name) {
      do {
        mAlias = 't${Random().nextInt(9999)}';
      } while (imports.containsValue(mAlias));
      return;
    }
  });
  imports[typeName] = mAlias;
  return mAlias;
}

/// 替换模板占位符
String format(String fmt, List<Object> params) {
  int matchIndex = 0;
  String replace(Match m) {
    if (matchIndex < params.length) {
      switch (m[0]) {
        case "%s":
          return params[matchIndex++].toString();
      }
    } else {
      throw new Exception("Missing parameter for string format");
    }
    throw new Exception("Invalid format string: " + m[0].toString());
  }

  return fmt.replaceAllMapped("%s", replace);
}
