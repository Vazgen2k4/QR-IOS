import 'package:flutter/material.dart';

class HistoryHeaderTimeWidget extends StatelessWidget {
  const HistoryHeaderTimeWidget({
    Key? key,
    required this.isChose,
    required this.dayCompleate,
    required this.date,
  }) : super(key: key);

  final bool isChose;
  final bool dayCompleate;
  final String date;

  @override
  Widget build(BuildContext context) {
    final icon = !isChose ? Icons.insert_invitation : Icons.done;
    final color = !dayCompleate && !isChose
        ? const Color(0xff882900)
        : const Color(0xff008088);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          alignment: Alignment.center,
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: color,
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 15),
                color: Color(0xff323232),
                spreadRadius: -10,
                blurRadius: 15,
              )
            ],
          ),
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 16),
        Text(
          date,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            height: 1.14,
          ),
        )
      ],
    );
  }
}
