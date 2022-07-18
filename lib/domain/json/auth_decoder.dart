class AuthDecoder {
  String? firstName;
  String? lastName;
  String? born;
  String? position;

  AuthDecoder({this.firstName, this.lastName, this.born, this.position});

  AuthDecoder.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    born = json['born'];
    position = json['position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['born'] = born;
    data['position'] = position;
    return data;
  }
}
