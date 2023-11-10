import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedpreferences;
  static init() async {
    sharedpreferences = await SharedPreferences.getInstance();
  }

  static dynamic getdata({required String key}) {
    return sharedpreferences!.get(key);
  }

  static Future<bool> saveData({required String key, dynamic value}) async {
    if (value is String) return await sharedpreferences!.setString(key, value);
    if (value is int) return await sharedpreferences!.setInt(key, value);
    if (value is double) return await sharedpreferences!.setDouble(key, value);
    return await sharedpreferences!.setBool(key, value);
  }

  static Future<bool> removeData({required String key}) async {
    return await sharedpreferences!.remove(key);
  }
}
