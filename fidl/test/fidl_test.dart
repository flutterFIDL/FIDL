import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fidl/fidl.dart';

void main() {
  const MethodChannel channel = MethodChannel('fidl');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await Fidl.platformVersion, '42');
  });
}
