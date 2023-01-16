import 'package:flutter/material.dart';

class CartItems extends StatefulWidget {
  const CartItems({super.key});

  @override
  State<CartItems> createState() => _CartItemsState();
}

class _CartItemsState extends State<CartItems> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('CartItems')),
    );
  }
}
