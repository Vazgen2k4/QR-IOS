import 'package:flutter/material.dart';

class AppMenuHeader extends StatelessWidget {
  const AppMenuHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: const Text(
        'PROWEB',
        style: TextStyle(
          color: Colors.white, 
          fontWeight: FontWeight.w900,
          fontSize: 30,
          height: 1.16,
        ),
      ),
    );
  }
}
