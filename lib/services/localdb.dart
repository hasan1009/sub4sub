import 'package:shared_preferences/shared_preferences.dart';

class LocalDB {
  static const uidKey = "fsfjkfskjfsfv";
  static const mKey = "sfklsfjsfkdhghdhrsffsf";
  static const nkey = "sfklsfjsfkdhdeyokjwsffsf";
  static const pkey = "sflskflkajfoiweflkjsdlkfjlskdj";
  static const totalPointsKey = "totalPoints";

  static Future<bool> saveUserID(String uid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(uidKey, uid);
  }

  static Future<String?> getUserID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final savedUid = preferences.getString(uidKey);

    return savedUid;
  }

  static Future<bool> saveMoney(String money) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(mKey, money);
  }

  static Future<String?> getMoney() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(mKey);
  }

  static Future<bool> saveName(String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(nkey, name);
  }

  static Future<String?> getName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(nkey);
  }

  static Future<bool> saveUrl(String prourl) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(pkey, prourl);
  }

  static Future<String?> getUrl() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(pkey);
  }

  static Future<int> getTotalPoints() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt(totalPointsKey) ?? 0;
  }

  static Future<bool> saveTotalPoints(int points) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setInt(totalPointsKey, points);
  }
}
