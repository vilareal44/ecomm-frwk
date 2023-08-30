import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  static Page page() => const MaterialPage<void>(child: SearchPage());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Center(
        child: Text('SearchPage'),
      )),
    );
  }
}
