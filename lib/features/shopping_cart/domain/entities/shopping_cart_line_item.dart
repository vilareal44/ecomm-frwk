// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:ecomm/features/product/domain/entities/entities.dart';

class ShoppingCartLineItem extends Equatable {
  const ShoppingCartLineItem({
    required this.product,
    required this.quantity,
  });

  final Product product;
  final int quantity;

  double get totalPrice => product.price * quantity;

  @override
  List<Object> get props => [product, quantity];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product.toMap(),
      'quantity': quantity,
    };
  }
}
