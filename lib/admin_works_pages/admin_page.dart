import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:smart_online_sale/admin_works_pages/add_product.dart';
import 'package:smart_online_sale/admin_works_pages/cart_items.dart';
import 'package:smart_online_sale/admin_works_pages/dashboard.dart';
import 'package:smart_online_sale/admin_works_pages/delete_product.dart';
import 'package:smart_online_sale/admin_works_pages/update_product.dart';
import 'package:smart_online_sale/utils/routes_redirection.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  Widget selectedScreen = const Dashboard();
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF7643),
        title: const Text(
          'Admin',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      sideBar: SideBar(
        activeBackgroundColor: Colors.deepOrange.shade200,
        backgroundColor: Colors.white,
        items: const [
          AdminMenuItem(
              title: 'Dashboard',
              route: RouteGenerator.dashboard,
              icon: Icons.dashboard),
          AdminMenuItem(
              title: 'Add Products',
              route: RouteGenerator.addProduct,
              icon: Icons.add),
          AdminMenuItem(
              title: 'Update Products',
              route: RouteGenerator.updateProduct,
              icon: Icons.update),
          AdminMenuItem(
              title: 'Delete Products',
              route: RouteGenerator.deleteProduct,
              icon: Icons.delete),
          AdminMenuItem(
              title: 'Cart Items',
              route: RouteGenerator.cartItems,
              icon: Icons.shop),
        ],
        selectedRoute: RouteGenerator.dashboard,
        onSelected: (item) {
          if (item.route == RouteGenerator.dashboard) {
            setState(() {
              selectedScreen = const Dashboard();
            });
          } else if (item.route == RouteGenerator.addProduct) {
            setState(() {
              selectedScreen = const AddProduct();
            });
          } else if (item.route == RouteGenerator.updateProduct) {
            setState(() {
              selectedScreen = const UpdateProduct();
            });
          } else if (item.route == RouteGenerator.deleteProduct) {
            setState(() {
              selectedScreen = const DeleteProduct();
            });
          } else if (item.route == RouteGenerator.cartItems) {
            setState(() {
              selectedScreen = const CartItems();
            });
          }
        },
      ),
      body: selectedScreen,
    );
  }
}
