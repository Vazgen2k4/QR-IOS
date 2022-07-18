import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proweb_qr/domain/providers/auth_provider/auth_provider.dart';

class BanPage extends StatelessWidget {
  const BanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Доступ запрещен',
              style: TextStyle(
                fontSize: 20,
                height: 1.15,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 23,
            ),
            FloatingActionButton.extended(
              backgroundColor: const Color(0xff535353),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              elevation: 0,
              onPressed: () async {
                final model = context.read<AuthProvider>();
                await model.logOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/', (route) => false);
              },
              label: Row(
                children: const [
                  Icon(
                    Icons.logout_outlined,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Выход',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
