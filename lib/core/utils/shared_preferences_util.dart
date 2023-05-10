import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static SharedPreferencesUtil? _instance;
  static SharedPreferences? _sharedPreferences;

  static const String keyAccessToken = "accessToken";
  static const String keyDataHotel = "dataHotel";
  static const String keyKeycard = "Keycard";
  static const String keyTotalCustomers = "totalCustomers";

  static Future<SharedPreferencesUtil> getInstance() async {
    if (_instance == null) {
      _instance = SharedPreferencesUtil();
    }
    if (_sharedPreferences == null) {
      _sharedPreferences = await SharedPreferences.getInstance();
    }
    return _instance ?? SharedPreferencesUtil();
  }

  String? getString(String key) => _sharedPreferences!.getString(key);

  Future<bool> putString(String key, String value) async =>
      await _sharedPreferences!.setString(key, value);

  int? getInt(String key) => _sharedPreferences!.getInt(key);

  Future<bool> putInt(String key, int value) async =>
      await _sharedPreferences!.setInt(key, value);

  bool? getBool(String key) => _sharedPreferences!.getBool(key);

  Future<bool> putBool(String key, bool value) =>
      _sharedPreferences!.setBool(key, value);

  removeString(String key) {
    _sharedPreferences?.remove(key);
  }

  removeAll() async {
    await _sharedPreferences?.clear();
  }
}
