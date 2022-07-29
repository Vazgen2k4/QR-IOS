import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:proweb_qr/domain/attendance_api/attedance_api.dart';
import 'package:proweb_qr/domain/providers/auth_provider/auth_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QrProvider extends ChangeNotifier {
  double _britness = .15;
  double get britness => _britness;

  final _minBritness = .15;
  double get minBritness => _minBritness;

  final double _maxBritness = 1;
  double get maxBritness => _maxBritness;

  // bool _banScreenShot = false;
  // bool get banScreenShot => _banScreenShot;

  QrProvider() {
    inintQr();
  }

  void inintQr() async {
    final pref = await SharedPreferences.getInstance();
    _britness = pref.getDouble('brightness') ?? _minBritness;
  }

  // void initInternetChecker() {
  //   InternetConnectionChecker().onStatusChange.listen((status) async {
  //     _banScreenShot = status == InternetConnectionStatus.disconnected;
  //     notifyListeners();
  //   });
  // }

  Future<DateAuth> genQRProweb() async {
    final pref = await SharedPreferences.getInstance();

    _britness = pref.getDouble('brightness') ?? minBritness;

    final qr = await AttedanceApi.getQrCode();

    final json =
        '{"id":${qr.result?.id},"time":${qr.result?.time},"status":${qr.result?.status}}';

    return DateAuth(britness: britness, json: json, id: qr.result?.id ?? 137);
  }

  Future<void> setBritness(double value) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setDouble('brightness', value);
    _britness = value;

    notifyListeners();
  }
}
