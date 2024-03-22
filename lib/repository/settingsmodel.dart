import 'settingrep.dart';
import 'package:flutter/material.dart';

class SettingViewModel extends ChangeNotifier {
  late bool _isDark;
  late String _pseudo;
  late List _score;
  late SettingRepository _settingRepository;
  bool get isDark => _isDark;
  String get pseudos => _pseudo;
  List get score => _score;
  SettingViewModel() {
    _isDark = false;
    _score = [];
    _settingRepository = SettingRepository();
    getSettingsDark();
    getSettingsPseudo();
    getSettingsScore();
  }
//Switching the themes
  set isDark(bool value) {
    _isDark = value;
    _settingRepository.saveSettingsDark(value);
    notifyListeners();
  }

  set pseudo(String value) {
    _pseudo = value;
    _settingRepository.saveSettingsPseudo(value);
    notifyListeners();
  }

  addScore(String pseudo, int score, int level) {
    _score.add("$pseudo:$score:$level");
    _settingRepository.saveSettingsScore(pseudo, score, level);
    notifyListeners();
  }

  getSettingsDark() async {
    _isDark = await _settingRepository.getSettingsDark();
    notifyListeners();
  }

  getSettingsPseudo() async {
    _pseudo = await _settingRepository.getSettingsPseudo() ?? "";
    notifyListeners();
  }

  getSettingsScore() async {
    _score = await _settingRepository.getSettingsScore();
    notifyListeners();
  }
}
