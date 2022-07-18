class History {
  int? status;
  HistoryResult? result;

  History({this.status, this.result});

  History.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result = json['result'] != null ? HistoryResult.fromJson(json['result']) : null;
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

class HistoryResult {
  int? count;
  List<DateList>? list;

  HistoryResult({this.count, this.list});

  HistoryResult.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (json['list'] != null) {
      list = <DateList>[];

      json['list'].forEach((v) {
        list!.add(DateList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['count'] = count;
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DateList {
  String? scanner;
  String? date;
  String? timeCame;
  String? timeGone;
  String? difference;
  bool? payment;

  bool isChoce = false; 

  DateList({
    this.scanner,
    this.date,
    this.timeCame,
    this.timeGone,
    this.difference,
    this.payment,
  });

  DateList.fromJson(Map<String, dynamic> json) {
    scanner = json['scanner'];
    date = json['date'];
    timeCame = json['time_came'];
    timeGone = json['time_gone'];
    difference = json['difference'];
    payment = json['payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['scanner'] = scanner;
    data['date'] = date;
    data['time_came'] = timeCame;
    data['time_gone'] = timeGone;
    data['difference'] = difference;
    data['payment'] = payment;
    return data;
  }
}
