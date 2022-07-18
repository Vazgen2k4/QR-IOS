import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proweb_qr/domain/attendance_api/attedance_api.dart';
import 'package:proweb_qr/domain/json/history.dart';
import 'package:proweb_qr/domain/providers/couter_provider/counter_provider.dart';
import 'package:proweb_qr/ui/pages/history_page/history_appbar.dart';
import 'package:proweb_qr/ui/pages/history_page/history_page_content.dart';

class HistoryPage extends StatefulWidget {
  final int? id;
  final String? name;
  final bool hasBackButton;

  const HistoryPage({
    Key? key,
    this.id,
    this.hasBackButton = false,
    this.name,
  }) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: context.read<CounterProvider>().onWillPop,
      child: Scaffold(
        appBar: HistoryAppBar(
          name: widget.name ?? '',
          hasPopButton: widget.hasBackButton,
        ),
        body: FutureBuilder(
          future: AttedanceApi.getHistory(id: widget.id),
          builder: (context, AsyncSnapshot<History> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final _history = snapshot.data;
              final _historyList = _history?.result?.list;

              if (_historyList == null || _historyList.isEmpty) {
                return const Center(
                  child: Text(
                    'Нет данных',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      height: 1.15,
                      color: Colors.white,
                    ),
                  ),
                );
              }
              return HistoryPageContent(historyList: _historyList);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
