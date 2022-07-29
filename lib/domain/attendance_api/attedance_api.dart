import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:proweb_qr/domain/json/auth_complete.dart';
import 'package:proweb_qr/domain/json/auth_result.dart';
import 'package:proweb_qr/domain/json/history.dart';
import 'package:proweb_qr/domain/json/workers_request.dart';
import 'package:proweb_qr/domain/providers/auth_provider/auth_user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AttedanceApi {
  static const String _host = 'attendance.proweb.uz';
  static int _id = -1;

  static Future<AuthResult> auth({
    required String name,
    required String lastName,
    required String born,
    required String position,
  }) async {
    const path = 'api/auth';

    Uri url = Uri(
      host: _host,
      scheme: 'https',
      path: path,
    );

    final body = json.encode({
      "first_name": name,
      "born": born,
      "last_name": lastName,
      "position": position,
    });

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: body,
    );

    final AuthResult request = AuthResult.fromJson(jsonDecode(response.body));

    switch (request.status) {
      case 200:
        _id = request.result?.id ?? -1;
        final pref = await SharedPreferences.getInstance();
        await pref.setInt('_id', _id);
        break;
      default:
    }

    return request;
  }

  static Future<bool> authIsComplete({required int codeTg}) async {
    if (_id == -1) return false;
    const path = 'api/auth-accept';

    Uri url = Uri(
      host: _host,
      scheme: 'https',
      path: path,
    );

    final body = json.encode({
      "id": _id,
      "code": codeTg,
    });

    final request = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: body,
    );

    int status = AuthResult.fromJson(jsonDecode(request.body)).status ?? 401;

    return status == 200;
  }

  static Future<AuthComplete> getQrCode() async {
    final idUser = (await AuthUserData.getId()).toString();
    Uri uri = Uri.parse('https://attendance.proweb.uz/api/qr-data');

    final client = await http.get(uri, headers: {'Authorization': idUser});

    final debagStatus = AuthComplete.fromJson(json.decode(client.body));

    return debagStatus;
  }

  static Future<History> getHistory({int? id}) async {
    final idUser = (id == null)
        ? (await AuthUserData.getId()).toString()
        : (id.toString());

    Uri uri =
        Uri.parse('https://attendance.proweb.uz/api/attendance-list?page=1');

    final client = await http.get(uri, headers: {'Authorization': idUser});

    final result = History.fromJson(json.decode(client.body));

    return result;
  }

  static Future<List<WorkersList>?> getWorkers() async {
    final idUser = (await AuthUserData.getId()).toString();

    Uri url =
        Uri.parse('https://attendance.proweb.uz/api/observation/staff-list');

    final client = await http.get(url, headers: {'Authorization': idUser});

    final request = WorkersRequest.fromJson(json.decode(client.body));

    return request.result?.list;
  }

  static Future youAreGondon() async {
    Uri url = Uri.parse('https://attendance.proweb.uz/api/screenshot');
    final idUser = (await AuthUserData.getId()).toString();
    await http.get(url, headers: {'Authorization': idUser});
  }
}
