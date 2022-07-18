import 'package:flutter/material.dart';
import 'package:proweb_qr/domain/json/history.dart';
import 'package:proweb_qr/ui/widgets/history_page_widget/history_time_widget.dart';

class HistoryBodyTimeWidget extends StatelessWidget {
  const HistoryBodyTimeWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  final DateList data;

  @override
  Widget build(BuildContext context) {
    final timeCame = data.timeCame ?? '-- : -- : --';
    final timeGone = data.timeGone ?? '-- : -- : --';

    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        HistoryTimeWidget(
          isChose: data.isChoce,
          icon: Icons.apartment,
          time: timeCame,
        ),
        const SizedBox(width: 12.5),
        HistoryTimeWidget(
          isChose: data.isChoce,
          icon: Icons.home,
          time: timeGone,
        ),
      ],
    );
  }
}
