import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do/repositories/page_index_tracker.dart';
import 'package:to_do/views/home_page.dart';
import 'package:to_do/views/user_home_page_app_bar.dart';


class UserLogedPage extends StatefulWidget {
  const UserLogedPage({Key? key}) : super(key: key);

  @override
  State<UserLogedPage> createState() => _UserLogedPageState();
}

class _UserLogedPageState extends State<UserLogedPage> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: Profile',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UserAppBar(),
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Implement your onPressed action here
        },
        shape: CircleBorder(),
        backgroundColor: Colors.amber,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Stack(
        children: [
          BottomAppBar(
            color: const Color(0xFF363636),
            shape: const CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.home),
                  onPressed: () => _onItemTapped(0),
                  color: _selectedIndex == 0 ? Colors.amber : Colors.white,
                ),
                IconButton(
                  icon: Icon(Icons.calendar_month),
                  onPressed: () => _onItemTapped(1),
                  color: _selectedIndex == 1 ? Colors.amber : Colors.white,
                ),
                SizedBox(width: 48.0), // SizedBox to leave space for the FAB
                IconButton(
                  icon: Icon(Icons.access_time),
                  onPressed: () => _onItemTapped(2),
                  color: _selectedIndex == 2 ? Colors.amber : Colors.white,
                ),
                IconButton(
                  icon: Icon(Icons.account_circle_rounded),
                  onPressed: () => _onItemTapped(3),
                  color: _selectedIndex == 3 ? Colors.amber : Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
