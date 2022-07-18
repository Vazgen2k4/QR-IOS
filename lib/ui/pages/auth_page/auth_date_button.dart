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

    final newDateTime = await showDatePicker(
      locale: const Locale('ru'),
      initialDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      context: context,
      firstDate: DateTime(1951, 5, 19),
      lastDate: DateTime.now(),
      builder: (context, datePicker) {
        Widget _error() {
          return Container(
            alignment: Alignment.center,
            child: const Text('Произошла ошибка'),
          );
        }

        

        return Theme(
          data: ThemeData().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xff323232),
            ),
            scaffoldBackgroundColor: const Color(0xff535353),
          ),
          child: datePicker ?? _error(),
        );
      },
    );

    if (newDateTime != null) {
      setState(() {
        title = DateFormat(_dateFormatPatern).format(newDateTime);
        AuthControllers.bornController.text = title;
      });
    }
  }

  @override
  void initState() {
    title = controllerValue.trim().isEmpty ? 'Дата рождения' : controllerValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextButton(
        style: ButtonStyle(
          alignment: Alignment.centerLeft,
          backgroundColor: MaterialStateProperty.all(AppColors.inputBgColor),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              side: const BorderSide(
                width: 1,
                color: AppColors.inputBorderColor,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        onPressed: () => getDate(context),
        child: Text(
          title,
          textAlign: TextAlign.left,
          style: TextStyle(
            color: AppColors.whiteColor.withOpacity(0.7),
            fontSize: 16,
            fontWeight: FontWeight.w400,
            height: 1.18,
          ),
        ),
      ),
    );
  }
}
