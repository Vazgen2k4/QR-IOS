import 'package:shared_preferences/shared_preferences.dart';

class AuthUserData {
  static AuthUserDataParameters data = AuthUserDataParameters(
    'Имя',
    'Фамилия',
    'Должность',
    137,
  );

  static int? _id;

  static Future<int> getId() async {
    final pref = await SharedPreferences.getInstance();
    _id = pref.getInt('_id');
    return _id ?? -1;
  }

  static void setId(int? value) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setInt('_id', value ?? -1);

    _id = value;
  }

  static Future<AuthUserDataParameters> getParameters() async {
    final pref = await SharedPreferences.getInstance();
    data.name = pref.getString('_name') ?? 'Имя';
    data.lastName = pref.getString('_lastName') ?? 'Фамилия';
    data.position = pref.getString('_position') ?? 'Должность';
    data.id = pref.getInt('_id') ?? 137;

    return data;
  }

  static void setParameters(AuthUserDataParameters value) async {
    final pref = await SharedPreferences.getInstance();

    await pref.setString('_name', value.name);
    await pref.setString('_lastName', value.lastName);
    await pref.setString('_position', value.position);

    data.name = value.name;
    data.lastName = value.lastName;
    data.position = value.position;
  }
}

class AuthUserDataParameters {
  AuthUserDataParameters(
    this.name,
    this.lastName,
    this.position,
    this.id,
  );

  String name;
  String lastName;
  String position;
  int id;
}
