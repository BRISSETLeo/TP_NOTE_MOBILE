import 'package:shared_preferences/shared_preferences.dart';

class SettingRepository {
  // ignore: constant_identifier_names
  static const THEME_KEY = "darkMode";
  // ignore: constant_identifier_names
  static const PSEUDO_KEY = "pseudo";
  saveSettingsDark(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(THEME_KEY, value);
  }

  saveSettingsPseudo(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(PSEUDO_KEY, value);
  }

  saveSettingsScore(String pseudo, int score, int level) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList("score", [
      "$pseudo:$score:$level",
      ...sharedPreferences.getStringList("score") ?? []
    ]);
  }

  Future<List<String>> getSettingsScore() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList("score") ?? [];
  }

  Future<bool> getSettingsDark() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(THEME_KEY) ?? false;
  }

  Future<String?> getSettingsPseudo() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(PSEUDO_KEY);
  }
}
