import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:proweb_qr/domain/providers/auth_provider/auth_provider.dart';
import 'package:proweb_qr/ui/pages/auth_page/auth_controllers.dart';
import 'package:proweb_qr/ui/theme/app_colors.dart';

class AuthCodeInput extends StatelessWidget {
  const AuthCodeInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double _width = 40;
    const double _height = 47;
    const int _count = 5;

    return Form(
      child: Center(
        child: SizedBox(
          width: 260,
          height: _height,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            scrollDirection: Axis.horizontal,
            itemCount: _count,
            itemBuilder: (context, i) {
              final model = context.read<AuthProvider>();

              return SizedBox(
                width: _width,
                height: _height,
                child: CupertinoTextFormFieldRow(
                  onSaved: (newValue) {},
                  style: const TextStyle(color: AppColors.whiteColor),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(1),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  textAlign: TextAlign.center,
                  textAlignVertical: TextAlignVertical.center,
                  onChanged: (value) {
                    if (value.length == 1) {
                      FocusScope.of(context).nextFocus();
                      AuthControllers.codeController.text += value.trim();
                      if (i == _count - 1) {
                        model.logIn(
                          AuthControllers.codeController.value.text.trim(),
                        );
                      }
                    }
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
