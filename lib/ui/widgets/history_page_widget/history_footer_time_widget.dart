import 'package:flutter/material.dart';
import 'package:proweb_qr/ui/widgets/history_page_widget/history_time_widget.dart';

class HistoryFooterTimeWidget extends StatelessWidget {
  final String differenceTime;
  final bool isChoce;
  final IconData icon;

  const HistoryFooterTimeWidget({
    Key? key,
    required this.differenceTime,
    required this.isChoce,
    this.icon = Icons.schedule,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(
          height: 26,
          color: Color(0xff323232),
        ),
        Row(children: [
          HistoryTimeWidget(
            isChose: isChoce,
            icon: icon,
            time: differenceTime,
          ),
        ]),
      ],
    );
  }
}
