import 'package:assignment/ui/engineer_page.dart';
import 'package:assignment/ui/setting_page.dart';
import 'package:flutter/material.dart';

import '../ui/home_page.dart';

class ThemeBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  const ThemeBottomNavigationBar({
    super.key,
    required this.currentIndex,
  });

  @override
  State<ThemeBottomNavigationBar> createState() => _ThemeBottomNavigationBarState();
}

class _ThemeBottomNavigationBarState extends State<ThemeBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: widget.currentIndex,
      onTap: (int index) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => (index == 0 ? const EngineerPage() : (index == 1 ? const HomePage() : const SettingPage())),
          ),
        );
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
          ),
          label: 'Account Activation',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
          ),
          label: 'Settings',
        ),
      ],
    );
  }
}
