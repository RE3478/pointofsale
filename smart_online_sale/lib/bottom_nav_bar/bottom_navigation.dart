import 'package:flutter/material.dart';
import 'package:smart_online_sale/admin_works_pages/update_product.dart';
import 'package:smart_online_sale/screens_pages/categories_screen.dart';
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
    CategoriesScreen(),
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
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Shop-Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            label: 'Favourite',
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
