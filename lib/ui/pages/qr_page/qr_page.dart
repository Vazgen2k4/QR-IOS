import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proweb_qr/domain/providers/auth_provider/auth_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart';

class QrPage extends StatefulWidget {
  final double brightness;
  const QrPage({Key? key, required this.brightness}) : super(key: key);
  @override
  _QrPageState createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  bool isPressed = false;

  void action() async {
    await showDialog(
      context: context,
      barrierColor: Colors.black,
      builder: (BuildContext context) {
        final model = context.read<AuthProvider>();

        return FutureBuilder<DateAuth>(
          future: model.genQRProweb(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              double _br = snapshot.data?.britness ?? 0.3;
              const _brKef = .15;
              if (snapshot.data?.id == 137) {
                _br = 1;
              }
              return Opacity(
                opacity: _br < _brKef ? _brKef : _br,
                child: Center(
                  child: QrImage(
                    backgroundColor: Colors.white,
                    data: snapshot.data?.json ?? 'nonononon',
                  ),
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      },
    );
    // .then((value) async =>
    //     await ScreenBrightness().setScreenBrightness(_brightness));

    HapticFeedback.heavyImpact();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(
          'QR CODE',
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Для создания QR кода нажмите на кнопку "Генерировать"\n\nГенерация QR-кода нужна для того, чтобы вы могли отметиться на приход/уход в PROWEB\n\nВаши данные храняться на сервере PROWEB для проведения статистики и подсчет отработанных часов. Ваши данные могут видеть только Вы и Ваш руководитель',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 20,
                  height: 1.15,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CupertinoButton.filled(
                onPressed: action,
                child: const Text('Генерировать'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
