import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:proweb_qr/domain/json/history.dart';
import 'package:proweb_qr/domain/providers/couter_provider/counter_provider.dart';
import 'package:proweb_qr/ui/widgets/history_page_widget/history_item_widget.dart';

class HistoryPageContent extends StatelessWidget {
  final List<DateList> historyList;
  const HistoryPageContent({
    Key? key,
    required this.historyList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<CounterProvider>();
    model.historyList = historyList;

    return Column(
      children: <Widget>[
        const ChoseDataPikerBtn(),
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: model.historyList.length,
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 16,
            ),
            separatorBuilder: (_, __) => const SizedBox(height: 15),
            itemBuilder: (context, i) {
              return HistoryItemWidget(
                index: i,
                data: model.historyList[i],
              );
            },
          ),
        ),
      ],
    );
  }
}

class ChoseDataPikerBtn extends StatefulWidget {
  const ChoseDataPikerBtn({
    Key? key,
  }) : super(key: key);

  @override
  State<ChoseDataPikerBtn> createState() => _ChoseDataPikerBtnState();
}

class _ChoseDataPikerBtnState extends State<ChoseDataPikerBtn> {
  DateTimeRange? dateRange;
  final String _dateFormatePatern = 'dd.MM.yyyy';

  Future getDateRange(BuildContext context) async {
    final initRange = DateTimeRange(
      start: DateTime.now().subtract(const Duration(days: 3)),
      end: DateTime.now(),
    );

    final newDateRange = await showDateRangePicker(
        confirmText: 'fdsf',
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        saveText: 'Сохранить',
        context: context,
        initialDateRange: initRange,
        firstDate: DateTime(2021, 5, 19),
        lastDate: DateTime.now(),
        builder: (context, datePicker) {
          return Theme(
            data: ThemeData().copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color(0xff323232),
                surface: Colors.white,
                onSurface: Colors.white,
              ),
              scaffoldBackgroundColor: const Color(0xff535353),
            ),
            child: datePicker ??
                Container(
                  alignment: Alignment.center,
                  child: const Text('Произошла ошибка'),
                ),
          );
        });

    if (newDateRange == null) return;

    final model = context.read<CounterProvider>();
    setState(() {
      dateRange = newDateRange;
      model.onChoiceDatePiker(dateRange: dateRange);
    });
  }

  String? getFrom() {
    if (dateRange == null) {
      return null;
    } else {
      return DateFormat(_dateFormatePatern).format(dateRange!.start);
    }
  }

  String? getUntil() {
    if (dateRange == null) {
      return null;
    } else {
      return DateFormat(_dateFormatePatern).format(dateRange!.end);
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CounterProvider>();

    String _title = 'Выбрать даты';
    if (getFrom() != null && getUntil() != null && !model.isCloset) {
      _title = '${getFrom()} - ${getUntil()}';
    } else {
      _title = 'Выбрать даты';
    }

    return InkWell(
      onTap: () => getDateRange(context),
      child: Ink(
        padding: const EdgeInsets.symmetric(
          vertical: 26,
          horizontal: 18,
        ),
        child: Row(
          children: <Widget>[
            const Icon(
              Icons.filter_list,
              color: Colors.white,
            ),
            const SizedBox(width: 18),
            Text(
              _title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                height: 1.18,
                color: Colors.white,
              ),
            ),
            const Expanded(child: SizedBox()),
            if (model.data.days > 0)
              InkWell(
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
                onTap: model.close,
              ),
          ],
        ),
      ),
    );
  }
}
