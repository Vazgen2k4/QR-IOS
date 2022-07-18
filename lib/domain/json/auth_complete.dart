class AuthComplete {
  int? status;
  AuthCompleteResult? result;

  AuthComplete({this.status, this.result});

  AuthComplete.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result = json['result'] != null ? AuthCompleteResult.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class AuthCompleteResult {
  int? id;
  double? time;
  int? status;

  AuthCompleteResult({this.id, this.time, this.status});

  AuthCompleteResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    time = json['time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['time'] = time;
    data['status'] = status;
    return data;
  }
}
