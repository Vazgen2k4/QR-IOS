import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:proweb_qr/ui/pages/auth_page/auth_controllers.dart';
class AuthDateButton extends StatefulWidget {
  const AuthDateButton({Key? key}) : super(key: key);

  @override
  State<AuthDateButton> createState() => _AuthDateButtonState();
}

class _AuthDateButtonState extends State<AuthDateButton> {
  final controllerValue = AuthControllers.bornController.value.text;
  late String title;

  Future getDate(BuildContext context) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (context) {
       

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
