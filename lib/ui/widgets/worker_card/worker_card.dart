import 'dart:ui';

import 'package:flutter/material.dart';

class WorkerCard extends StatelessWidget {
  final String name;
  final String born;
  final String position;
  final int id;

  const WorkerCard({
    Key? key,
    required this.born,
    required this.name,
    required this.position,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: RadialGradient(colors: [
          Color.fromRGBO(0, 128, 136, .22),
          Color.fromRGBO(50, 50, 50, 0),
        ]),
        boxShadow: [
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
          child: Container(
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(83, 83, 83, 0.5),
              borderRadius: BorderRadius.circular(6),
            ),
            child: InkWell(
              splashColor: const Color(0xff882900),
              highlightColor: const Color(0xff285659),
              onTap: () {
                Navigator.of(context).pushNamed(
                  '/history/$id',
                  arguments: name,
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  WorkerCardItem(icon: Icons.account_circle, label: name),
                  const Divider(
                    height: 30,
                    color: Color(0xff323232),
                  ),
                  WorkerCardItem(icon: Icons.insert_invitation, label: born),
                  const Divider(
                    height: 30,
                    color: Color(0xff323232),
                  ),
                  WorkerCardItem(
                    icon: Icons.work,
                    label: position,
                    isBold: true,
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

class WorkerCardItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isBold;

  const WorkerCardItem({
    Key? key,
    required this.icon,
    required this.label,
    this.isBold = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
        const SizedBox(width: 17),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w400,
            fontSize: isBold ? 16 : 14,
            height: isBold ? 1.18 : 1.14,
          ),
        )
      ],
    );
  }
}
