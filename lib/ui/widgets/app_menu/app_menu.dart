import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:proweb_qr/domain/providers/auth_provider/auth_provider.dart';
import 'package:proweb_qr/domain/providers/auth_provider/auth_user_data.dart';
import 'package:proweb_qr/ui/widgets/app_menu/app_menu_body.dart';

class AppMenu extends StatelessWidget {
  const AppMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(
          'Информация',
          style: TextStyle(
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            if (AuthUserData.data.id != 137)
              const AppMenuBody()
            else
              const SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Данное приложение создано для просмотра отметок на приход/уход сотрудника учебного центра PROWEB. \n\nПри помощи данного приложения Вы можете просматривать историю прихода/ухода на работу, так же считать кол-во отработанных часов.\n\nВы отмечаетесь при помощи сканера отпечатка пальца на входе в учебном центре PROWEB. При отметки Вы автоматически попадаете в систему и данные в Вашей истории обновляються\n\nДанная приложение созданно для прозрачности системы отметок и каждый сотрудник может её использовать для контроля своего рабочего времени и в слючае не состыковок показать данные своему руководителю отдела для урегулирование ситуации\n\nХорошего продуктивного рабочего времени\n\nС увожением, учебный центр  PROWEB!',
                    style: TextStyle(
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            const ExitButton(),
          ],
        ),
      ),
    );
  }
}

class ExitButton extends StatelessWidget {
  const ExitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<AuthProvider>();

    return CupertinoButton.filled(
      child: const Text('Выход'),
      onPressed: () async {
        await model.logOut();
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/',
          (route) => false,
        );
      },
    );
  }
}
