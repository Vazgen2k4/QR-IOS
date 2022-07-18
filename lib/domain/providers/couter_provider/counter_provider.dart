import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:proweb_qr/domain/json/history.dart';

class CounterProvider extends ChangeNotifier {
  static final CounterProviderData _data = CounterProviderData(
    days: 0,
    time: '0',
  );
  List<DateList> historyList = [];
  CounterProviderData get data => _data;
  
  bool isCloset = false;

  void onChoice(int index) async {
    if (historyList[index].difference == null) {
      await Fluttertoast.showToast(
        msg: "День не закончен",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color(0xff222222),
        textColor: const Color(0xffffffff),
        fontSize: 16.0,
      );
    } else {
      historyList[index].isChoce = !historyList[index].isChoce;
      setData();
    }
  }

  void setData({bool choceListReset = false}) {
    List<DateList> _choceList = [];

    if (!choceListReset) {
      _choceList = historyList.where((element) => element.isChoce).toList();
    }

    _data.days = _choceList.length;

    int _hours = 0;
    int _minutes = 0;
    int _seconds = 0;

    for (var element in _choceList) {
      final timeArr = (element.difference ?? '00:00:00').split(':');

      _hours += int.parse(timeArr[0]);
      _minutes += int.parse(timeArr[1]);
      _seconds += int.parse(timeArr[2]);

      if (_minutes >= 60) {
        _hours += _minutes ~/ 60;
        _minutes = _minutes % 60;
      }

      if (_seconds >= 60) {
        _minutes += _seconds ~/ 60;
        _seconds = _seconds % 60;
      }
    }

    final String _hoursStr = '${_hours < 10 ? '0$_hours' : _hours}';
    final String _minutesStr = '${_minutes < 10 ? '0$_minutes' : _minutes}';
    final String _secondsStr = '${_seconds < 10 ? '0$_seconds' : _seconds}';

    final String _time = '$_hoursStr:$_minutesStr:$_secondsStr';

    _data.time = _time;
    notifyListeners();
  }

  Future<bool> onWillPop() async {
    for (var e in historyList) {
      e.isChoce = false;
    }

    var days = data.days;
    data.days = 0;
    notifyListeners();

    return days == 0;
  }

  void onChoiceDatePiker({DateTimeRange? dateRange}) {
    if (dateRange != null) {
      for (var e in historyList) {
        e.isChoce = false;
      }

      for (var i = 0; i < historyList.length; i++) {
        if (historyList[i].date != null) {
          var itemDateTime =
              DateFormat('dd.MM.yyyy').parse(historyList[i].date!.trim());

          final _isAfter = itemDateTime.isAfter(
            dateRange.start.subtract(
              const Duration(days: 1),
            ),
          );

          final _isBefore = itemDateTime.isBefore(
            dateRange.end.add(
              const Duration(days: 1),
            ),
          );

          if (_isAfter && _isBefore) {
            onChoice(i);
          }
        }
      }
    }
  }

  void close() {
    for (var e in historyList) {
      e.isChoce = false;
    }

    isCloset = true;
    data.days = 0;

    notifyListeners();
  }
}

class CounterProviderData {
  String time;
  int days;

  CounterProviderData({required this.days, required this.time});
}
