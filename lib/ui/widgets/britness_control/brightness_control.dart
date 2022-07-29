import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proweb_qr/domain/providers/qr_provider/qr_provider.dart';
import 'package:proweb_qr/ui/widgets/app_menu_item/app_menu_item.dart';

class BrightnessControl extends StatelessWidget {
  const BrightnessControl({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final qrModel = context.watch<QrProvider>();

    final min = qrModel.minBritness;
    final max = qrModel.maxBritness;

    const thumpRadius = 8.0;

    return AppMenuItem(
      icon: Icons.light_mode,
      title: 'Яркость QR',
      subtitle: SliderTheme(
        data: SliderThemeData(
          trackHeight: 3,
          minThumbSeparation: 0,
          overlayShape: SliderComponentShape.noThumb,
          rangeThumbShape: const RoundRangeSliderThumbShape(
            enabledThumbRadius: thumpRadius,
          ),
        ),
        child: CupertinoSlider(
          activeColor: Colors.white,
          value: qrModel.britness < .2 ? .2 : qrModel.britness,
          min: min,
          max: max,
          onChangeEnd: (v) => qrModel.setBritness(v),
          onChanged: (newValue) {
            qrModel.setBritness(newValue);
          },
        ),
      ),
    );
  }
}
