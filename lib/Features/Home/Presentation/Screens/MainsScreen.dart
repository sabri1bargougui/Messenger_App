import 'package:flutter/material.dart';
import 'package:messenger_app/Features/Chat/Presentation/Screens/chats_page.dart';
import 'package:messenger_app/Features/Home/Presentation/Widgets/HomeWidget.dart';
import 'package:messenger_app/Features/Profile/Presentation/Screens/profile_3.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static List<Widget> _options = <Widget>[
    HomeScreen(),
    ProfileScreen(),
    ChatsPage(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _options.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.blueAccent),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
                backgroundColor: Colors.orange),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble),
              label: 'Chat',
              backgroundColor: Colors.lightBlue,
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          iconSize: 25,
          onTap: _onItemTap,
          elevation: 5),
    );
  }
}
