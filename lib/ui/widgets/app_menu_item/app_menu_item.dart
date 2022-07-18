import 'package:flutter/material.dart';

class AppMenuItem extends StatelessWidget {

  final IconData icon;
  final double thumpRadius;
  final String title;
  final Widget? subtitle;

  const AppMenuItem({
    Key? key,
    required this.icon,
    required this.title,
    this.thumpRadius = 8,
    this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 10,
      horizontalTitleGap: 16 - thumpRadius,
      leading: SizedBox(
        height: double.infinity,
        child: Icon(
          icon,
          size: 24,
          color: Colors.white,
        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(
          left: thumpRadius,
          bottom: 12,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            height: 1.14,
            color: Color(0xffd6d6d6),
          ),
        ),
      ),
      subtitle: subtitle,
    );
  }
}
