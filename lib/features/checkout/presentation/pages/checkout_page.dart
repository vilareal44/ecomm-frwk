import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  static Page page() => const MaterialPage<void>(child: CheckoutPage());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Center(
        child: Text('CheckoutPage'),
      )),
    );
  }
}
