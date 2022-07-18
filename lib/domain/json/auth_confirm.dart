class AuthConfirm {
  int? id;
  int? code;

  AuthConfirm({this.id, this.code});

  AuthConfirm.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['code'] = code;
    return data;
  }
}