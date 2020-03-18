T getEnumFromString<T>(Iterable<T> values, String value) {
  return values.firstWhere((type) => type.toString().split(".").last == value,
      orElse: () => null);
}

String enumToString<T>(T enumValue) {
  return enumValue.toString().split('.').last;
}
