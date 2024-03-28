import 'package:app/homescreen/profile.dart';
import 'package:app/homescreen/sent.dart';
import 'package:bottom_nav/bottom_nav.dart';
import 'package:flutter/material.dart';

import 'homescreen/dashboard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTab = 0;
  final screen = [
    const Dashboard(),
    const SentScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[currentTab],
      bottomNavigationBar: BottomNav(
        index: currentTab,
        backgroundColor: Colors.white,
        showElevation: true,
        navBarHeight: 70.0,
        radius: 30.0,
        onTap: (i) {
          setState(() {
            currentTab = i;
          });
        },
        items: [
          BottomNavItem(
              icon: Icons.home, label: "Home", selectedColor: Colors.green),
          BottomNavItem(
              icon: Icons.send, label: "Sent", selectedColor: Colors.green),
          BottomNavItem(
              icon: Icons.person,
              label: "Profile",
              selectedColor: Colors.green),
        ],
      ),
    );
  }
}
