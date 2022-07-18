import 'package:flutter/material.dart';
import 'package:proweb_qr/ui/widgets/app_menu_item/app_menu_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BrightnessControl extends StatefulWidget {
  const BrightnessControl({Key? key}) : super(key: key);

  @override
  BrightnessControlState createState() => BrightnessControlState();
}

class BrightnessControlState extends State<BrightnessControl> {
  double value = 0;
  late double deviceBritness;

  final double thumpRadius = 8;

  Future<void> setSettings() async {
    final pref = await SharedPreferences.getInstance();
    setState(() {
      value = pref.getDouble('brightness') ?? 0.0;
    });
  }

  void onChangedEnd(double curentValue) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setDouble('brightness', curentValue);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setSettings();
  }

  @override
  Widget build(BuildContext context) {
    const double min = 0.0;
    const double max = 1.0;
    return AppMenuItem(
      icon: Icons.light_mode,
      title: 'Яркость QR',
      subtitle: SliderTheme(
        data: SliderThemeData(
          trackHeight: 3,
          minThumbSeparation: 0,
          overlayShape: SliderComponentShape.noThumb,
          rangeThumbShape: RoundRangeSliderThumbShape(
            enabledThumbRadius: thumpRadius,
          ),
        ),
        child: Slider(
          inactiveColor: const Color(0xff535353),
          activeColor: Colors.white,
          value: value,
          min: min,
          max: max,
          onChangeEnd: onChangedEnd,
          onChanged: (newValue) {
            setState(() {
              value = newValue;
            });
          },
        ),
      ),
    );
  }
}
