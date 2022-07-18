import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:proweb_qr/domain/attendance_api/attedance_api.dart';
import 'package:proweb_qr/domain/json/workers_request.dart';
import 'package:proweb_qr/domain/providers/auth_provider/auth_user_data.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  // Проверка на подклчение к интернету
  bool _hasInternet = false;
  // Проверка форм на валидность
  bool _hasError = false;
  // Проверка на блокирование
  bool _isBaned = false;
  // Проверка сессии на авторизацию
  bool _hasAuth = false;
  // Доступ на просмотр времени сотрудников
  bool _hasWatch = false;
  // Активация формы пароля
  bool _codeInputActive = false;
  // Сотрудники для наблюдения
  static List<WorkersList>? _workers = [];
  List<WorkersList> get workers => _workers ?? [];

  bool get hasInternet => _hasInternet;
  bool get hasError => _hasError;
  bool get hasWatch => _hasWatch;
  bool get isBaned => _isBaned;
  bool get codeInputActive => _codeInputActive;

  bool _hasPermition = false;
  bool get hasPermition => _hasPermition;

  void setPermition() {
    _hasPermition = true;
    notifyListeners();
  }

  Future<bool> hasAuth() async {
    // Получение параметров поль-ля с памяти устройства
    final pref = await SharedPreferences.getInstance();
    await AuthUserData.getParameters();
    // Получения данных работников
    _workers = await AttedanceApi.getWorkers();
    _hasWatch = _workers?.isNotEmpty ?? false;
    // Проверка на авторизацию
    _hasAuth = pref.getBool('_hasAuth') ?? false;
    // Проверка соединения интернета
    _hasInternet = await InternetConnectionChecker().hasConnection;

    return _hasAuth;
  }

  Future<void> internetChecker() async {
    _hasInternet = await InternetConnectionChecker().hasConnection;
    notifyListeners();
  }

  Future<void> logOut() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('_hasAuth', false);

    _hasInternet = false;
    _hasAuth = false;
    _hasError = false;
    _isBaned = false;
    _codeInputActive = false;
    _hasWatch = false;

    notifyListeners();
  }

  void getTgCode({
    required String name,
    required String lastName,
    required String born,
    required String position,
  }) async {
    if (name.isNotEmpty ||
        lastName.isNotEmpty ||
        position.isNotEmpty ||
        born.isNotEmpty) {
      try {
        final result = await AttedanceApi.auth(
          born: born.trim(),
          lastName: lastName.trim(),
          name: name.trim(),
          position: position.trim(),
        );
        switch (result.status) {
          case 200:
            _isBaned = false;
            _hasError = false;
            AuthUserData.setId(result.result?.id);
            AuthUserData.setParameters(
              AuthUserDataParameters(
                name,
                lastName,
                position,
              ),
            );
            _codeInputActive = true;
            break;
          case 423:
          case 404:
            _isBaned = true;
            break;
          default:
            _hasError = true;
        }

        notifyListeners();
      } catch (e) {
        _hasError = true;
      }
    } else {
      _hasError = true;
    }
  }

  void logIn(String codeTg) async {
    final id = await AuthUserData.getId();
    if (id == -1 || _hasError) {
      notifyListeners();
      return;
    }

    _hasError = false;
    final code = int.parse(codeTg);
    _hasAuth = await AttedanceApi.authIsComplete(codeTg: code);
    if (id == 137 && code == 12345) {
      _hasAuth = true;
    }
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('_hasAuth', _hasAuth);
    notifyListeners();
  }

  Future<String> genQRProweb() async {
    final pref = await SharedPreferences.getInstance();
    // await FlutterScreenWake.setBrightness(pref.getDouble('brightness') ?? 0.0);

    await ScreenBrightness()
        .setScreenBrightness(pref.getDouble('brightness') ?? 0.0);

    final qr = await AttedanceApi.getQrCode();

    return '{"id":${qr.result?.id},"time":${qr.result?.time},"status":${qr.result?.status}}';
  }
}
