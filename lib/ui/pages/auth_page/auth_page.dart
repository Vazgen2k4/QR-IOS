import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proweb_qr/domain/providers/auth_provider/auth_provider.dart';
import 'package:proweb_qr/ui/pages/ban_page/ban_page.dart';
import 'package:proweb_qr/ui/pages/home_page/home_page.dart';
import 'package:proweb_qr/ui/pages/not_internet_page/not_internet_page.dart';

import 'auth_page_content.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<AuthProvider>();

    return FutureBuilder(
      future: model.hasAuth(),
      builder: (context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const CupertinoPageScaffold(
            child: Center(
              child: CupertinoActivityIndicator(
                color: Colors.white,
              ),
            ),
          );
        } else {
          if (!model.hasInternet) {
            return const NotInternetPage();
          }
          if (model.isBaned) {
            return const BanPage();
          }
          if (snapshot.data == true) {
            return const HomePage();
          }
          return const AuthPageContent();
        }
      },
    );
  }
}
