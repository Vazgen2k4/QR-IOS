import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proweb_qr/domain/providers/couter_provider/counter_provider.dart';

class HistoryAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final bool hasPopButton;

  HistoryAppBar({
    Key? key,
    double? height,
    this.name = '',
    this.hasPopButton = false,
  })  : preferredSize = Size.fromHeight(height ?? kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CounterProvider>();
    final days = model.data.days;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: double.infinity,
      color: const Color(0xff535353),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 15,
        right: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _HistoryDaysCounter(
            days: days,
            name: name,
            hasPopButton: hasPopButton,
          ),
          if (days != 0) const _HistoryTimeCounter()
        ],
      ),
    );
  }
}

class _HistoryDaysCounter extends StatelessWidget {
  final bool hasPopButton;
  final String name;
  const _HistoryDaysCounter({
    Key? key,
    required this.days,
    required this.name,
    required this.hasPopButton,
  }) : super(key: key);

  final int days;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CounterProvider>();
    final days = model.data.days;
    final Widget _child = days == 0
        ? Text(
            'История: $name',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              height: 1.18,
              color: Colors.white,
            ),
          )
        : const Padding(
            padding: EdgeInsets.only(right: 13),
            child: Icon(
              Icons.insert_invitation,
              color: Colors.white,
              size: 24,
            ),
          );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // if (hasPopButton)
        //   IconButton(
        //     padding: const EdgeInsets.only(right: 10),
        //     splashRadius: 20,
        //     onPressed: () {
        //       model.setData(choceListReset: true);
        //       Navigator.of(context).pop();
        //     },
        //     icon: const Icon(
        //       Icons.arrow_back,
        //       color: Colors.white,
        //       size: 24,
        //     ),
        //   ),
        _child,
        if (days != 0)
          AnimatedDigitWidget(
            value: days,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              height: 1.18,
              color: Colors.white,
            ),
          ),
      ],
    );
  }
}

class _HistoryTimeCounter extends StatelessWidget {
  const _HistoryTimeCounter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<CounterProvider>();
    final time = model.data.time.split(':');

    const _style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      height: 1.18,
      color: Colors.white,
    );

    return Row(
      children: [
        const Icon(Icons.schedule, color: Colors.white, size: 24),
        const SizedBox(width: 12),
        ListView.separated(
          shrinkWrap: true,
          itemCount: time.length,
          scrollDirection: Axis.horizontal,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) {
            return const Center(
              child: Text(':', style: _style),
            );
          },
          itemBuilder: (context, i) {
            final parseValue = int.parse(time[i]);
            final value = parseValue > 9 ? parseValue : parseValue / 10;

            return AnimatedDigitWidget(
              value: value,
              fractionDigits: parseValue > 9 ? 0 : 1,
              decimalSeparator: '',
              textStyle: _style,
            );
          },
        ),
      ],
    );
  }
}
