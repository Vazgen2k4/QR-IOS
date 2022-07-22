import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:proweb_qr/domain/providers/auth_provider/auth_provider.dart';
import 'package:proweb_qr/domain/providers/auth_provider/auth_user_data.dart';
import 'package:proweb_qr/resources/resources.dart';
import 'package:proweb_qr/ui/pages/auth_page/auth_code_input.dart';
import 'package:proweb_qr/ui/pages/auth_page/auth_controllers.dart';
import 'package:proweb_qr/ui/pages/auth_page/auth_page_form.dart';
import 'package:proweb_qr/ui/theme/app_colors.dart';
import 'package:proweb_qr/ui/widgets/custom_input_widget.dart';
import 'package:proweb_qr/ui/widgets/size_limit_container.dart';
import 'auth_date_button.dart';

class AuthPageContent extends StatelessWidget {
  const AuthPageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<AuthProvider>();

    final List<CustomInputWidget> _children = [
      CustomInputWidget(
        controller: AuthControllers.nameController,
        hintText: 'Имя',
        hasError: model.hasError,
      ),
      CustomInputWidget(
        controller: AuthControllers.lastNameController,
        hintText: 'Фамилия',
        hasError: model.hasError,
      ),
    ];

    List<Widget> _authContentItems = [
      const SizedBox(height: 20),
      AuthPageForm(children: _children),
      const SizedBox(height: 20),
      CustomInputWidget(
        hintText: 'Должность',
        controller: AuthControllers.positionController,
        hasError: model.hasError,
      ),
      const SizedBox(height: 20),
      const AuthDateButton(),
      const SizedBox(height: 20),
    ];

    if (model.codeInputActive) {
      _authContentItems = [
        const SizedBox(height: 20),
        SvgPicture.asset(AppIcons.telegramm),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: AutoSizeText(
            'В телеграм бот Посещаемости был отправлен код подтверждения, введите его ниже',
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              height: 1.145,
              color: AppColors.whiteColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const AuthCodeInput(),
      ];
    }

    return CupertinoPageScaffold(
          child: SizeLimitContainer(
            child: Center(
              child: _AuthPageContent(authContentItems: _authContentItems)
                  
            ),
          ),
        );
  }
}


class _AuthPageContent extends StatelessWidget {
  const _AuthPageContent({
    Key? key,
    required List<Widget> authContentItems,
  })  : _authContentItems = authContentItems,
        super(key: key);

  final List<Widget> _authContentItems;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AuthProvider>();

    return ListView(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      children: [
        SvgPicture.asset(AppIcons.logo),
        ..._authContentItems,
        if (!model.codeInputActive) const AuthNextButton(),
      ],
    );
  }
}

class AuthNextButton extends StatelessWidget {
  const AuthNextButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<AuthProvider>();
    const String _buttonTxt = 'Получить код';

    return CupertinoButton.filled(
      child: const SizedBox(
        width: double.infinity,
        child: Text(
          _buttonTxt,
          textAlign: TextAlign.center,
        ),
      ),
      onPressed: () {
        model.getTgCode(
          name: AuthControllers.nameController.value.text,
          lastName: AuthControllers.lastNameController.value.text,
          born: AuthControllers.bornController.value.text,
          position: AuthControllers.positionController.value.text,
        );
        AuthUserData.setParameters(
          AuthUserDataParameters(
            AuthControllers.nameController.value.text,
            AuthControllers.lastNameController.value.text,
            AuthControllers.positionController.value.text,
            137,
          ),
        );
      },
    );
  }
}
