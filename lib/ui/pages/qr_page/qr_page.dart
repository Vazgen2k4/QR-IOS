import 'dart:async';

import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:proweb_qr/domain/attendance_api/attedance_api.dart';
import 'package:proweb_qr/domain/providers/auth_provider/auth_provider.dart';
import 'package:proweb_qr/domain/providers/qr_provider/qr_provider.dart';
import 'package:proweb_qr/ui/widgets/britness_control/brightness_control.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart';
import 'package:screenshot_callback/screenshot_callback.dart';

class QrPage extends StatefulWidget {
  final double brightness;
  const QrPage({Key? key, required this.brightness}) : super(key: key);
  @override
  _QrPageState createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  bool isPressed = false;
  void screenshotWarling(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text(
            'Вы сделали скриншот',
          ),
          content: const Text(
            'Скриншоты запрещены и информация о том что сделали это отправлена руководству',
          ),
          actions: [
            CupertinoButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Понятно',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void action() async {
    ScreenshotCallback screenshotCallback = ScreenshotCallback();
    screenshotCallback.addListener(() {
      AttedanceApi.youAreGondon();
      screenshotWarling(context);
    });

    showDialog(
      context: context,
      barrierColor: Colors.black,
      builder: (BuildContext context) {
        final qrModel = context.read<QrProvider>();

        return FGBGNotifier(
          onEvent: (value) {
            if (value == FGBGType.foreground) {
            } else if (value == FGBGType.background) {
              Navigator.pop(context);
            }
          },
          child: FutureBuilder<DateAuth>(
            future: qrModel.genQRProweb(),
            builder: (context, snapshot) {
              GestureDetector btn = GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: const Icon(
                    Icons.replay_outlined,
                    color: Color(0xff000000),
                  ),
                ),
                onTap: (() async {
                  Navigator.pop(context);
                  action();
                }),
              );
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Opacity(
                      opacity: .75,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [const AnimateTimer(), btn],
                      ),
                    ),
                    QRImageWidget(
                      data: snapshot.data,
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: CupertinoActivityIndicator(
                    color: Color(0xffffffff),
                  ),
                );
              }
            },
          ),
        );
      },
    ).then(
      (value) => screenshotCallback.dispose(),
    );
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

class QRImageWidget extends StatefulWidget {
  const QRImageWidget({
    Key? key,
    required this.data,
  }) : super(key: key);

  final DateAuth? data;

  @override
  State<QRImageWidget> createState() => _QRImageWidgetState();
}

class _QRImageWidgetState extends State<QRImageWidget> {
  bool _banScreenShot = false;
  late StreamSubscription<InternetConnectionStatus> internetListenner;

  @override
  void initState() {
    super.initState();
    internetListenner = InternetConnectionChecker().onStatusChange.listen(
      (status) async {
        setState(() {
          _banScreenShot = status == InternetConnectionStatus.disconnected;
          print(_banScreenShot);
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    internetListenner.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final qrModel = context.watch<QrProvider>();
    double qrBritness = _banScreenShot ? .0 : qrModel.britness;

    return Column(
      children: [
        GestureDetector(
          onTap: (() => Navigator.pop(context)),
          child: FGBGNotifier(
            onEvent: (status) {
              setState(() {
                _banScreenShot = status == FGBGType.background;
                qrBritness = _banScreenShot ? .0 : qrModel.britness;
                print(qrBritness);
              });
            },
            child: Opacity(
              opacity: qrBritness,
              child: Center(
                child: QrImage(
                  backgroundColor: Colors.white,
                  data: widget.data?.json ?? 'nonononon',
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        const Opacity(opacity: .75, child: BrightnessControl()),
      ],
    );
  }
}

class AnimateTimer extends StatefulWidget {
  const AnimateTimer({Key? key}) : super(key: key);

  @override
  State<AnimateTimer> createState() => _AnimateTimerState();
}

class _AnimateTimerState extends State<AnimateTimer> {
  int seconds = 30;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (seconds == 1) {
            timer.cancel();
            Navigator.pop(context);
          } else {
            seconds--;
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 35,
      lineWidth: 1,
      percent: seconds / 30,
      progressColor: const Color(0xffffffff),
      backgroundColor: const Color(0xffffffff).withOpacity(.3),
      animation: true,
      animateFromLastPercent: true,
      center: AnimatedDigitWidget(
        duration: const Duration(milliseconds: 200),
        value: seconds,
        textStyle: const TextStyle(color: Color(0xffffffff), fontSize: 25),
      ),
    );
  }
}
