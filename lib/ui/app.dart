import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:proweb_qr/domain/providers/auth_provider/auth_provider.dart';
import 'package:proweb_qr/domain/providers/couter_provider/counter_provider.dart';
import 'package:proweb_qr/ui/app_navigator/app_navigator.dart';
import 'package:proweb_qr/ui/pages/auth_page/auth_page.dart';
import 'pages/home_page/home_page.dart';
import 'package:proweb_qr/generated/l10n.dart';

class ProwebQR extends StatelessWidget {
  const ProwebQR({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => AuthProvider(),
        ),
        ChangeNotifierProvider<CounterProvider>(
          create: (_) => CounterProvider(),
        ),
      ],
      child: const _ProwebQRContent(),
    );
  }
}

class _ProwebQRContent extends StatelessWidget {
  const _ProwebQRContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: const CupertinoThemeData(
        scaffoldBackgroundColor: Color(0xff323232),
        primaryColor: Color(0xffffffff),
        barBackgroundColor: Color(0xff535353),
        primaryContrastingColor: Color(0xff323232),
      ),
      title: 'ProwebQR',
      routes: {
        '/': (_) => const AuthPage(),
        '/home': (_) => const HomePage(),
      },
      initialRoute: '/',
      onGenerateRoute: AppNavigator.generate,
    );
  }
}
