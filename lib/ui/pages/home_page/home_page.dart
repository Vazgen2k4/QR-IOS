import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proweb_qr/domain/providers/auth_provider/auth_provider.dart';
import 'package:proweb_qr/domain/providers/couter_provider/counter_provider.dart';
import 'package:proweb_qr/ui/pages/history_page/history_page.dart';
import 'package:proweb_qr/ui/pages/qr_page/qr_page.dart';
import 'package:proweb_qr/ui/pages/workers_page/workers_page.dart';
import 'package:proweb_qr/ui/widgets/app_menu/app_menu.dart';

class HomePage extends StatefulWidget {
  final double brithess;
  const HomePage({Key? key, this.brithess = 1}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int _curentIndex;
  double brightness = 1;

  @override
  void initState() {
    _curentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final hasWatch = context.read<AuthProvider>().hasWatch;

    PageController _pageController = PageController();
    List<Widget> _screens = [
      QrPage(brightness: brightness),
      const HistoryPage(),
      if (hasWatch) const WorkersPage(),
      const AppMenu(),
    ];

    void _onPageChanged(int i) {
      context.read<CounterProvider>().setData(choceListReset: true);

      setState(() {
        _curentIndex = i;
      });
    }

    void _itemTapped(int selectedIndex) {
      _pageController.jumpToPage(selectedIndex);
    }

    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: Colors.white,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.qr_code_2,
            ),
            label: 'QR Code',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'История',
          ),
          if (hasWatch)
            const BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: 'Сотрудники',
            ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: 'Информация',
          ),
        ],
      ),
      tabBuilder: (ctx, int) {
        return _screens[int];
      },

      // drawer: const AppMenu(),
      // body: PageView(
      //   controller: _pageController,
      //   children: _screens,
      //   onPageChanged: _onPageChanged,
      //   physics: const NeverScrollableScrollPhysics(),
      // ),
      // bottomNavigationBar: NavigationBarTheme(
      //   data: NavigationBarThemeData(
      //     backgroundColor: const Color(0xff535353),
      //     indicatorColor: const Color(0xff363141),
      //     labelTextStyle: MaterialStateProperty.all(
      //       const TextStyle(color: Colors.white),
      //     ),
      //     iconTheme: MaterialStateProperty.all(
      //       const IconThemeData(color: Colors.white),
      //     ),
      //   ),
      //   child: NavigationBar(
      //     onDestinationSelected: _itemTapped,
      //     selectedIndex: _curentIndex,
      //     destinations: [
      //       const NavigationDestination(
      //         icon: Icon(Icons.qr_code_2),
      //         label: 'QR Code',
      //       ),
      //       const NavigationDestination(
      //         icon: Icon(Icons.list),
      //         label: 'История',
      //       ),

      //     ],
      //   ),
    );
  }
}
