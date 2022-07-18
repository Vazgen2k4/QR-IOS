class AuthResult {
  int? status;
  Result? result;

  AuthResult({this.status, this.result});

  AuthResult.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
        json['result'] != null ? Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data ={};
    data['status'] = status;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class Result {
  int? id;

  Result({this.id});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    return data;
  }
}