import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:blockchainproject/screens/home_screen.dart';
import 'package:blockchainproject/screens/maintenance_screen.dart';
import 'package:blockchainproject/screens/maintenance_display_screen.dart';
import 'package:blockchainproject/Firebase/auth_services.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  int currentIndex = 0;
  late PageController pageController;
  late AnimationController _controller;
  late AnimationController _controller2;
  late Animation<double> _animation;
  late Animation<double> _animation2;

  @override
  void initState() {
    super.initState();

    pageController = PageController(initialPage: currentIndex);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _animation2 = Tween<double>(begin: 0, end: -50).animate(CurvedAnimation(
      parent: _controller2,
      curve: Curves.fastLinearToSlowEaseIn,
    ));

    _controller.forward();
    _controller2.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myAuth = Provider.of<AuthService>(context);
    return Scaffold(
      bottomNavigationBar: bottomNavigationBar(),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          const HomeScreen(),
          _getScreenForDevice(),
        ],
      ),
    );
  }

  Widget appBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: AppBar(
        backgroundColor: const Color.fromARGB(255, 46, 45, 45),
        elevation: 0,
        title: Text(
          'VEHI CRYPTO',
          style: TextStyle(fontSize: MediaQuery.of(context).size.width / 17),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_rounded, color: Colors.white),
            onPressed: () {
              HapticFeedback.lightImpact();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _getScreenForDevice() {
    return AuthService().userRole == "service"
        ? MaintenanceScreen()
        : MaintenanceDisplayScreen();
  }

  Widget bottomNavigationBar() {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        backgroundColor: Colors.blueAccent,
        indicatorColor: const Color.fromARGB(255, 2, 69, 185),
        labelTextStyle: MaterialStateProperty.all(
          TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        iconTheme: MaterialStateProperty.all(
          IconThemeData(
            color: Colors.white,
          ),
        ),
      ),
      child: NavigationBar(
        height: 70,
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
            pageController.jumpToPage(currentIndex);
            HapticFeedback.lightImpact();
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
            selectedIcon: Icon(Icons.home),
          ),
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: 'Maintenance',
            selectedIcon: Icon(Icons.dashboard),
          ),
        ],
      ),
    );
  }
}
