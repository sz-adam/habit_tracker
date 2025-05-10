import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/screens/add_habit.dart';
import 'package:habit_tracker/screens/home_screen.dart';
import 'package:habit_tracker/screens/settings_screen.dart';


class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  List<Widget> _screens = [
    HomeScreen(),
    AddHabit(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        height: 60.0,
        color: Colors.blueAccent,
        buttonBackgroundColor: Colors.orange,
        backgroundColor: Colors.white,
        items: <Widget>[
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.add, size: 40, color: Colors.white,),
          Icon(Icons.settings, size: 30, color: Colors.white),
        ],
        onTap: _onItemTapped,
        animationDuration: Duration(milliseconds: 300),
        animationCurve:Curves.linear ,
      ),
    );
  }
}
