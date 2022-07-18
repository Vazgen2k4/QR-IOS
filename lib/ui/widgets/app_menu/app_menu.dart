import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proweb_qr/ui/widgets/app_menu/app_menu_body.dart';
import 'package:proweb_qr/ui/widgets/app_menu/app_menu_header.dart';

import '../../../domain/providers/auth_provider/auth_provider.dart';

class AppMenu extends StatelessWidget {
  const AppMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: const [
            AppMenuHeader(),
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

    return Ink(
      width: double.infinity,
      height: 80,
      child: FloatingActionButton.extended(
        heroTag: 'exit',
        elevation: 0,
        backgroundColor: const Color(0xff535353),
        icon: const Icon(Icons.logout_outlined),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        onPressed: () async {
          await model.logOut();
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/',
            (route) => false,
          );
        },
        label: const Text(
          'Выход',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
