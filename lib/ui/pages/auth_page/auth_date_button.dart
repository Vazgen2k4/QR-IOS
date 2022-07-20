import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proweb_qr/ui/pages/auth_page/auth_controllers.dart';
import 'package:proweb_qr/ui/theme/app_colors.dart';

class AuthDateButton extends StatefulWidget {
  const AuthDateButton({Key? key}) : super(key: key);

  @override
  State<AuthDateButton> createState() => _AuthDateButtonState();
}

class _AuthDateButtonState extends State<AuthDateButton> {
  final String _dateFormatPatern = 'dd.MM.yyyy';
  final controllerValue = AuthControllers.bornController.value.text;
  late String title;

  Future getDate(BuildContext context) async {
    // print()

    final newDateTime = await showCupertinoModalPopup(
      context: context,
      // firstDate: DateTime(1951, 5, 19),
      // lastDate: DateTime.now(),
      builder: (context) {
        Widget _error() {
          return Container(
            alignment: Alignment.center,
            child: const Text('Произошла ошибка'),
          );
        }

        return Container(
          height: 250,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: CupertinoDatePicker(
            backgroundColor: Colors.white,
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (value) {
              setState(() {
                title =
                    '${value.day < 10 ? '0${value.day}' : value.day}.${value.month < 10 ? '0${value.month}' : value.month}.${value.year}';
                AuthControllers.bornController.text = title;
              });
            },
          ),
        );

        // return Theme(
        //   data: ThemeData().copyWith(
        //     colorScheme: const ColorScheme.light(
        //       primary: Color(0xff323232),
        //     ),
        //     scaffoldBackgroundColor: const Color(0xff535353),
        //   ),
        //   child: datePicker ?? _error(),
        // );
      },
    );
  }

  @override
  void initState() {
    title = controllerValue.trim().isEmpty ? 'Дата рождения' : controllerValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton.filled(
      onPressed: () => getDate(context),
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.18,
        ),
      ),
    );
  }
}
