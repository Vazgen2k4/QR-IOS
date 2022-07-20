import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:proweb_qr/ui/widgets/app_menu/app_menu_body.dart';

import '../../../domain/providers/auth_provider/auth_provider.dart';

class AppMenu extends StatelessWidget {
  const AppMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(
          'Меню',
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: const [
            AppMenuBody(),
            ExitButton(),
          ],
        ),
      ),
    );
  }
}

class ExitButton extends StatelessWidget {
  const ExitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<AuthProvider>();

    return CupertinoButton.filled(
      child: const Text('Выход'),
      onPressed: () async {
        await model.logOut();
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/',
          (route) => false,
        );
      },
    );
  }
}
