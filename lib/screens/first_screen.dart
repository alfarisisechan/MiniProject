import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:mini_project/screens/about_screen.dart';
import 'package:mini_project/screens/activity_screen.dart';
import 'package:mini_project/screens/gallery_screen.dart';
import 'package:mini_project/screens/home_screen.dart';
import 'package:mini_project/screens/profile_screen.dart';
import 'package:mini_project/screens/signin_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  bool isLoggedIn = false;

  @override
  int _selectedIndex = 0;
  final List<Widget> _childern = [
    HomeScreen(),
    GalleryScreen(),
    AboutScreen(),
    ActivityScreen(),
    ProfileScreen()
  ];
  void onTappedBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        isLoggedIn = false;
      } else {
        setState(() {
          isLoggedIn = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoggedIn
        ? new Scaffold(
            body: _childern[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: onTappedBar,
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.orangeAccent,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                  backgroundColor: Colors.blueAccent,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.wallpaper),
                  label: 'Gallery',
                  backgroundColor: Colors.blueAccent,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.workspace_premium),
                  label: 'About Us',
                  backgroundColor: Colors.blueAccent,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_box),
                  label: 'My Activity',
                  backgroundColor: Colors.blueAccent,
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_sharp),
                  label: 'Profile',
                  backgroundColor: Colors.blueAccent,
                ),
              ],
            ),
          )
        : SignInScreen();
  }
}
