import 'package:flutter/material.dart';

class AppMenuBtn extends StatelessWidget {
  
  const AppMenuBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashRadius: 24,
      onPressed: () => Scaffold.of(context).openDrawer(),
      icon: const Icon(
        Icons.menu_outlined,
        color: Colors.white,
        size: 24,
      ),
    );
  }
}
