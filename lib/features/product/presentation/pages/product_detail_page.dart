import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.productId});

  final String productId;

  static Page page({required String productId}) =>
      MaterialPage<void>(child: ProductDetailPage(productId: productId));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Text('ProductDetailPage: $productId'),
      )),
    );
  }
}
