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
    final BorderRadius radius = BorderRadius.circular(10);

    return TextField(
      controller: controller,
      style: const TextStyle(color: AppColors.whiteColor),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        fillColor: AppColors.inputBgColor,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.whiteColor.withOpacity(.6),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: const BorderSide(
            color: AppColors.inputBorderColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: radius,
          borderSide: const BorderSide(
            color: AppColors.inputBorderColor,
          ),
        ),
        errorText: hasError ? 'Заполните поле' : null,
        errorBorder: OutlineInputBorder(
          borderRadius: radius.copyWith(),
          borderSide: const BorderSide(color: AppColors.tgInputRed),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: AppColors.whiteColor),
        ),
      ),
    );
  }
}
