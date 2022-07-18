import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proweb_qr/domain/providers/auth_provider/auth_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart';
import 'package:screen_brightness/screen_brightness.dart';

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
      builder: (BuildContext context) {
        final model = context.read<AuthProvider>();

        return FutureBuilder(
          future: model.genQRProweb(),
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Center(
                child: QrImage(
                  backgroundColor: Colors.white,
                  data: snapshot.data ?? '',
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      },
    ).then((value) async =>
        await ScreenBrightness().setScreenBrightness(_brightness));

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
    const arrowWidth = 50.0;
    const arrowPercent = 16;

    final arrowTop = (MediaQuery.of(context).size.height / 100) * arrowWidth;
    final arrowLeft = MediaQuery.of(context).size.width / 2 - arrowWidth / 2;
    final arrowHeight = MediaQuery.of(context).size.height / 100 * arrowPercent;

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
      body: Stack(
        children: [
          const Center(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: Text(
                'Для создания QR кода нажмите на кнопку',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  height: 1.15,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: arrowTop,
            left: arrowLeft,
            child: Image(
              width: arrowWidth,
              height: arrowHeight,
              image: const AssetImage(
                'assets/images/arrow.png',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
