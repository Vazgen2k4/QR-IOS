import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:proweb_qr/domain/providers/auth_provider/auth_user_data.dart';
import 'package:proweb_qr/ui/widgets/app_menu_item/app_menu_item.dart';
import 'package:proweb_qr/ui/widgets/britness_control/brightness_control.dart';

class AppMenuBody extends StatelessWidget {
  const AppMenuBody({Key? key}) : super(key: key);

  String captitalize(String s) =>
      s[0].toUpperCase() + s.substring(1).toLowerCase();

  Widget subtitle(String txt, {bool isCapitalize = true}) {
    txt = isCapitalize ? captitalize(txt) : txt;

    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: AutoSizeText(
        txt,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white,
          height: 1.17,
        ),
        maxLines: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: ListView(
        children: [
          AppMenuItem(
            icon: Icons.face,
            title: 'Имя',
            subtitle: subtitle(AuthUserData.data.name),
          ),
          const Divider(color: Color(0xff626262)),
          AppMenuItem(
            icon: Icons.account_circle,
            title: 'Фамилия',
            subtitle: subtitle(AuthUserData.data.lastName),
          ),
          const Divider(color: Color(0xff626262)),
          AppMenuItem(
            icon: Icons.work,
            title: 'Должность ',
            subtitle: subtitle(AuthUserData.data.position, isCapitalize: false),
          ),
          const Divider(color: Color(0xff626262)),
          const BrightnessControl(),
        ],
      ),
    );
  }
}
