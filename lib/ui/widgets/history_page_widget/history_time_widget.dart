import 'package:flutter/material.dart';

class HistoryTimeWidget extends StatelessWidget {
  final IconData icon;
  final String time;
  final bool isChose;

  const HistoryTimeWidget({
    Key? key,
    required this.icon,
    required this.time,
    required this.isChose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bg = isChose
        ? (const Color.fromRGBO(66, 96, 98, 1))
        : (const Color(0xff505555));

    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 12,
        ),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(6),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0, 15),
              color: Color(0xff323232),
              spreadRadius: -10,
              blurRadius: 15,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 19),
            Text(
              time,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
