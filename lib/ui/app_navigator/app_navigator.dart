import 'package:flutter/material.dart';
import 'package:proweb_qr/ui/pages/history_page/history_page.dart';

class AppNavigator {
  static Route<dynamic> generate(RouteSettings settings) {
    final route = settings.name!.split('/');

    if (route[1] == 'history' && route.length == 3) {
      return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          return HistoryPage(
            id: int.parse(route[2]),
            hasBackButton: true,
            name: settings.arguments as String,
          );
        },
      );
    } else {
      return MaterialPageRoute(builder: (context) {
        return const Scaffold(
          body: Center(
            child: Text(
              'Доступ запрещен',
              style: TextStyle(
                fontSize: 20,
                height: 1.15,
                color: Colors.white,
              ),
            ),
          ),
        );
      });
    }
  }
}
