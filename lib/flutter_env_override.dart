library flutter_env_override;

import 'dart:convert';

import 'package:flutter/services.dart';

class AppConfig {
  static final AppConfig _instance = AppConfig._internal();

  factory AppConfig() {
    return _instance;
  }

  AppConfig._internal();

  dynamic _appConfig;

  Future<void> load({String? filePath}) async {
    if (filePath != null && filePath.isNotEmpty) {
      final contents = await rootBundle.loadString(
        filePath,
        cache: true,
      );
      _appConfig = jsonDecode(contents);
    }
  }

  /// Use ':' to navigate through the your group variables.
  /// Exemple:
  ///
  /// {
  ///   'keyOne': 'valueOne',
  ///   'keyTwo': {
  ///     'keyTwoLevelOne': 'true'
  ///     'keyTwoLevelTwo': 'false'
  ///   }
  /// }
  ///
  /// Use: "keyTwo:keyTwoLevelTwo"
  ///
  /// To .ENV we will parse ':' to '__'
  /// Exemple:
  ///
  /// .ENV ->
  ///
  /// keyTwo__keyTwoLevelOne
  /// keyTwo__keyTwoLevelTwo
  ///
  /// Use the same: "keyTwo:keyTwoLevelTwo"
  ///
  /// Actualy supports 10 levels of search
  /// value1:value2:value3:value4...
  String value({
    required String key,
    String defaultValue = '',
  }) {
    if (key.contains(' ')) {
      throw Exception(
          'Invalid environment variable value.\nCan\'t use empty spaces');
    }

    final fromEnv = String.fromEnvironment(
      key.replaceAll(':', '__'),
    );

    if (fromEnv.isNotEmpty) {
      return fromEnv;
    }

    if (_appConfig == null) {
      return defaultValue;
    }

    final value = extractFromJsonAppSettings(key);

    if (value == null || value.isEmpty) {
      return defaultValue;
    }

    return value;
  }

  String? extractFromJsonAppSettings(String key) {
    List<String> k = key.split(':');

    dynamic value;

    switch (k.length) {
      case 1:
        value = _appConfig[k[0]];
        break;
      case 2:
        value = _appConfig[k[0]][k[1]];
        break;
      case 3:
        value = _appConfig[k[0]][k[1]][k[2]];
        break;
      case 4:
        value = _appConfig[k[0]][k[1]][k[2]][k[3]];
        break;
      case 5:
        value = _appConfig[k[0]][k[1]][k[2]][k[3]][k[4]];
        break;
      case 6:
        value = _appConfig[k[0]][k[1]][k[2]][k[3]][k[4]][k[5]];
        break;
      case 7:
        value = _appConfig[k[0]][k[1]][k[2]][k[3]][k[4]][k[5]][k[6]];
        break;
      case 8:
        value = _appConfig[k[0]][k[1]][k[2]][k[3]][k[4]][k[5]][k[6]][k[7]];
        break;
      case 9:
        value =
            _appConfig[k[0]][k[1]][k[2]][k[3]][k[4]][k[5]][k[6]][k[7]][k[8]];
        break;
      case 10:
        value = _appConfig[k[0]][k[1]][k[2]][k[3]][k[4]][k[5]][k[6]][k[7]][k[8]]
            [k[9]];
        break;
      case 11:
        value = _appConfig[k[0]][k[1]][k[2]][k[3]][k[4]][k[5]][k[6]][k[7]][k[8]]
            [k[9]][k[10]];
        break;
      default:
        const message =
            'AppConfigSettings actualy do not support JSON with more than 10 levels!';
        throw Exception(message);
    }
    return value;
  }
}
