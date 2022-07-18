import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proweb_qr/domain/providers/auth_provider/auth_provider.dart';

class NotInternetPage extends StatelessWidget {
  const NotInternetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> _refreshConect() async {
      await Provider.of<AuthProvider>(context, listen: false).internetChecker();
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Нет подключения к сети',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                height: 1.18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _refreshConect,
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(
                    horizontal: 63,
                    vertical: 14,
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(
                  const Color(0xff535353),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                ),
              ),
              child: const Text(
                'Повторить попытку',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  height: 1.18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
