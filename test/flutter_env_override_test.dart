import 'package:flutter_env_override/flutter_env_override.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AppConfig appConfig;

  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    appConfig = AppConfig();
  });

  test('get expected values', () async {
    // arranje

    await appConfig.load(
      filePath: 'lib/appsettings.dev.json',
    );

    Map<String, String> scenarios = {
      'LogLevel1:LogLevel2:LogLevel3:LogLevel4:LogLevel5:LogLevel6:LogLevel7:LogLevel8:LogLevel9:LogLevel10:Default':
          'Information',
      'LogLevel1:LogLevel2:LogLevel3:LogLevel4:LogLevel5:LogLevel6:LogLevel7:LogLevel8:LogLevel9:Default':
          'Information',
      'LogLevel1:LogLevel2:LogLevel3:LogLevel4:LogLevel5:LogLevel6:LogLevel7:LogLevel8:Default':
          'Information',
      'LogLevel1:LogLevel2:LogLevel3:LogLevel4:LogLevel5:LogLevel6:LogLevel7:Default':
          'Information',
      'LogLevel1:LogLevel2:LogLevel3:LogLevel4:LogLevel5:LogLevel6:Default':
          'Information',
      'LogLevel1:LogLevel2:LogLevel3:LogLevel4:LogLevel5:Default':
          'Information',
      'LogLevel1:LogLevel2:LogLevel3:LogLevel4:Default': 'Information',
      'LogLevel1:LogLevel2:LogLevel3:Default': 'Information',
      'LogLevel1:LogLevel2:Default': 'Information',
      'LogLevel1:Default': 'Information',
    };

    for (var test in scenarios.entries) {
      // act

      final value = appConfig.value(key: test.key);

      // assert

      expect(value, test.value);
    }
  });

  test('throws an exception on invalid keys', () async {
    // arranje

    await appConfig.load();

    // act && assert

    expect(
        () => appConfig.value(
              key: 'key one',
              defaultValue: 'defaultValue',
            ),
        throwsA(
          const TypeMatcher<Exception>(),
        ));
  });

  test('throws an exception on invalid env level', () async {
    // arranje

    await appConfig.load(
      filePath: 'lib/appsettings.dev.json',
    );

    // act && assert

    expect(
        () => appConfig.value(
              key:
                  'LogLevel1:LogLevel2:LogLevel3:LogLevel4:LogLevel5:LogLevel6:LogLevel7:LogLevel8:LogLevel9:LogLevel10:Default:Exception',
            ),
        throwsA(
          const TypeMatcher<Exception>(),
        ));
  });

  test('get expected default value', () async {
    // arranje

    const expectedValue = 'defaultValue';
    // act && assert

    final value = appConfig.value(key: 'asdf', defaultValue: expectedValue);

    expect(value, expectedValue);
  });
}
