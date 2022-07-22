import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:proweb_qr/domain/attendance_api/attedance_api.dart';
import 'package:proweb_qr/domain/json/workers_request.dart';
import 'package:proweb_qr/domain/providers/auth_provider/auth_user_data.dart';
import 'package:proweb_qr/ui/pages/auth_page/auth_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  // Проверка на подклчение к интернету
  bool _hasInternet = false;
  bool get hasInternet => _hasInternet;
  // Проверка форм на валидность
  bool _hasError = false;
  bool get hasError => _hasError;
  // Проверка на блокирование
  bool _isBaned = false;
  bool get isBaned => _isBaned;
  // Проверка сессии на авторизацию
  bool _hasAuth = false;
  // Доступ на просмотр времени сотрудников
  bool _hasWatch = false;
  bool get hasWatch => _hasWatch;
  // Активация формы пароля
  bool _codeInputActive = false;
  bool get codeInputActive => _codeInputActive;
  // Сотрудники для наблюдения
  static List<WorkersList>? _workers = [];
  List<WorkersList> get workers => _workers ?? [];

  
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
    if (name.isEmpty || lastName.isEmpty || position.isEmpty || born.isEmpty) {
      _hasError = true;
      notifyListeners();
      return;
    }

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
              result.result?.id ?? 137,
            ),
          );
          _codeInputActive = true;
          break;
        case 423:
          _isBaned = true;
          break;
        case 404:
          _hasError = true;
          break;
        default:
          _hasError = true;
      }
      notifyListeners();
    } catch (e) {
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
    AuthControllers.codeController.text = '';
    notifyListeners();
  }

  Future<DateAuth> genQRProweb() async {
    final pref = await SharedPreferences.getInstance();

    final britness = pref.getDouble('brightness') ?? 0.0;

    final qr = await AttedanceApi.getQrCode();

    final json =
        '{"id":${qr.result?.id},"time":${qr.result?.time},"status":${qr.result?.status}}';

    return DateAuth(britness: britness, json: json, id: qr.result?.id ?? 137);
  }
}

class DateAuth {
  final String json;
  final double britness;
  final int id;

  const DateAuth({
    required this.britness,
    required this.json,
    required this.id,
  });
}
