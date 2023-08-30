import 'package:flutter/material.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({super.key});

  static Page page() => const MaterialPage<void>(child: ShoppingCartPage());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Center(
        child: Text('ShoppingCartPage'),
      )),
    );
  }
}
