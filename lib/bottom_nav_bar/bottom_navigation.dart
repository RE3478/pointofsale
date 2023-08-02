import 'package:flutter/material.dart';
import 'package:smart_online_sale/admin_works_pages/admin_page.dart';
import 'package:smart_online_sale/admin_works_pages/update_product.dart';
import 'package:smart_online_sale/screens_pages/home_screen_page.dart';
import 'package:smart_online_sale/screens_pages/login_page.dart';
import 'package:smart_online_sale/screens_pages/user_profile_page.dart';

class BottomNaviForStore extends StatefulWidget {
  const BottomNaviForStore({super.key});

  @override
  State<BottomNaviForStore> createState() => _BottomNaviForStoreState();
}

class _BottomNaviForStoreState extends State<BottomNaviForStore> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreenPage(),
    AdminPage(),
    UpdateProduct(),
    LoginPage(),
    UserProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BottomNavigationBar Sample'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.black,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view),
              label: 'Appointments',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Motifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.deepOrange,
          onTap: _onItemTapped,
        ),
    );
  }
}
