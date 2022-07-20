import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proweb_qr/ui/theme/app_colors.dart';

class CustomInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool hasError;

  const CustomInputWidget({
    Key? key,
    required this.controller,
    this.hintText = 'Текст',
    this.hasError = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: controller,
      style: const TextStyle(color: Colors.black),
      textCapitalization: TextCapitalization.sentences,
      placeholder: hintText,
    );
  }
}
