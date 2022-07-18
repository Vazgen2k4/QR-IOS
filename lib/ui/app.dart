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


class ProwebQR extends StatefulWidget {
  const ProwebQR({Key? key}) : super(key: key);

  @override
  State<ProwebQR> createState() => _ProwebQRState();
}

class _ProwebQRState extends State<ProwebQR> {
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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        localizationsDelegates: const[
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: ThemeData(
          drawerTheme: const DrawerThemeData(
            backgroundColor: Color(0xff323232),
          ),
          scaffoldBackgroundColor: const Color(0xff323232),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            backgroundColor: Color(0xff535353),
          ),
          fontFamily: 'Roboto',
        ),
        title: 'ProwebQR',
        routes: {
          '/': (_) => const AuthPage(),
          '/home': (_) => const HomePage(),
        },
        initialRoute: '/',
        onGenerateRoute: AppNavigator.generate,
      ),
    );
  }
}
