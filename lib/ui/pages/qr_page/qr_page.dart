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
  late final double _brightness;

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
              final _br = snapshot.data?.britness ?? 0.3;
              const _brKef = .15;
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
  void initState() {
    _brightness = widget.brightness;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'QR Code',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            height: 1.18,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'Generate',
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 0,
        backgroundColor: const Color(0xff535353),
        onPressed: action,
        label: const Text('Генерировать'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Для создания QR кода нажмите на кнопку "Генерировать"\n\nГенерация QR-кода нужна для того, чтобы вы могли отметиться на приход/уход в PROWEB\n\nВаши данные храняться на сервере PROWEB для проведения статистики и подсчет отработанных часов. Ваши данные могут видеть только Вы и Ваш руководитель',
            textAlign: TextAlign.justify,
            style: TextStyle(
              fontSize: 20,
              height: 1.15,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
