import 'package:flutter/material.dart';
import 'package:smart_online_sale/admin_works_pages/admin_page.dart';
import 'package:smart_online_sale/admin_works_pages/dashboard.dart';
import 'package:smart_online_sale/bottom_nav_bar/bottom_navigation.dart';
import 'package:smart_online_sale/screens_pages/customer_page.dart';
import 'package:smart_online_sale/screens_pages/home_screen_page.dart';
import 'package:smart_online_sale/screens_pages/login_page.dart';
import 'package:smart_online_sale/screens_pages/manager_page.dart';
import 'package:smart_online_sale/screens_pages/signup_page.dart';
import 'package:smart_online_sale/screens_pages/staff_page.dart';
import 'package:smart_online_sale/screens_pages/user_profile_page.dart';
import 'package:smart_online_sale/splash_screen/splash_screen.dart';

import '../admin_works_pages/add_product.dart';
import '../admin_works_pages/cart_items.dart';
import '../admin_works_pages/delete_product.dart';
import '../admin_works_pages/update_product.dart';

class RouteGenerator {
  static const String splash = 'splash';
  static const String login = 'login';
  static const String signup = 'signup';
  static const String usersProfile = 'usersProfile';
  static const String home = 'home';
  static const String admin = 'admin';
  static const String dashboard = "dashboard";
  static const String addProduct = "addProduct";
  static const String updateProduct = "updateProduct";
  static const String deleteProduct = "deleteProduct";
  static const String cartItems = "cartItems";
  static const String manager = 'manager';
  static const String staff = 'staff';
  static const String customer = 'customer';
  static const String bottomNaviForStore = 'bottomNaviForStore';
  RouteGenerator._();
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case usersProfile:
        return MaterialPageRoute(builder: (_) => const UserProfilePage());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreenPage());
      case admin:
        return MaterialPageRoute(builder: (_) => const AdminPage());
      case dashboard:
        return MaterialPageRoute(builder: (_) => const Dashboard());
      case addProduct:
        return MaterialPageRoute(builder: (_) => const AddProduct());
      case updateProduct:
        return MaterialPageRoute(builder: (_) => const UpdateProduct());
      case deleteProduct:
        return MaterialPageRoute(builder: (_) => const DeleteProduct());
      case cartItems:
        return MaterialPageRoute(builder: (_) => const CartItems());
      case manager:
        return MaterialPageRoute(builder: (_) => const ManagerPage());
      case staff:
        return MaterialPageRoute(builder: (_) => const StaffPage());
      case customer:
        return MaterialPageRoute(builder: (_) => const CustomerPage());
      case bottomNaviForStore:
        return MaterialPageRoute(builder: (_) => const BottomNaviForStore());

      default:
        throw 'Route not found';
    }
  }
}
