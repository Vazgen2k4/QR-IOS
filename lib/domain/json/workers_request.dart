class WorkersRequest {
  int? status;
  WorkersRequestResult? result;

  WorkersRequest({this.status, this.result});

  WorkersRequest.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result = json['result'] != null
        ? WorkersRequestResult.fromJson(json['result'])
        : null;
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

class WorkersRequestResult {
  List<WorkersList>? list;

  WorkersRequestResult({this.list});

  WorkersRequestResult.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <WorkersList>[];
      json['list'].forEach((v) {
        list!.add(WorkersList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkersList {
  int? id;
  String? firstName;
  String? lastName;
  String? born;
  String? position;
  int? status;

  WorkersList({
    this.id,
    this.firstName,
    this.lastName,
    this.born,
    this.position,
    this.status,
  });

  WorkersList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    born = json['born'];
    position = json['position'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['born'] = born;
    data['position'] = position;
    data['status'] = status;
    return data;
  }
}
