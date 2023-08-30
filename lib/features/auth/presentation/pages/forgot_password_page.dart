import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  static Page page() => const MaterialPage<void>(child: ForgotPasswordPage());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Center(
        child: Text('ForgotPasswordPage'),
      )),
    );
  }
}
