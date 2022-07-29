import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:proweb_qr/domain/json/history.dart';
import 'package:proweb_qr/domain/providers/couter_provider/counter_provider.dart';
import 'package:proweb_qr/ui/widgets/history_page_widget/history_body_time_widget.dart';
import 'package:proweb_qr/ui/widgets/history_page_widget/history_footer_time_widget.dart';
import 'package:proweb_qr/ui/widgets/history_page_widget/history_header_time_widget.dart';

class HistoryItemWidget extends StatelessWidget {
  final DateList data;
  final int index;

  const HistoryItemWidget({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CounterProvider>();
    final date = data.date ?? '00-00-0000';

    final difference = data.difference ?? '-- : -- : --';

    final bg = data.isChoce
        ? const Color.fromRGBO(0, 229, 243, 0.2)
        : const Color.fromRGBO(83, 83, 83, 0.5);

    final List<Color> rgradient = difference.contains('-')
        ? [
            const Color.fromRGBO(255, 0, 0, .22),
            const Color.fromRGBO(255, 187, 187, 0),
          ]
        : [
            const Color.fromRGBO(0, 128, 136, .22),
            const Color.fromRGBO(50, 50, 50, 0),
          ];

    return GestureDetector(
      onTap: () {
        model.onChoice(index);
        HapticFeedback.heavyImpact();
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(colors: rgradient),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 10),
              blurRadius: 15,
            ),
          ],
        ),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 19, sigmaY: 19),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: bg,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  HistoryHeaderTimeWidget(
                    dayCompleate: !difference.contains('-'),
                    date: date,
                    isChose: data.isChoce,
                  ),
                  const Divider(
                    height: 26,
                    color: Color(0xff323232),
                  ),
                  HistoryBodyTimeWidget(data: data),
                  if (!difference.contains('-'))
                    HistoryFooterTimeWidget(
                      differenceTime: difference,
                      isChoce: data.isChoce,
                    ),
                  HistoryFooterTimeWidget(
                    differenceTime: data.scanner!,
                    isChoce: data.isChoce,
                    icon: Icons.location_on_outlined,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
