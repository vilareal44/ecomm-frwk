// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:ecomm/features/shopping_cart/domain/entities/shopping_cart_line_item.dart';

class ShoppingCart extends Equatable {
  final List<ShoppingCartLineItem> lineItems;

  const ShoppingCart({
    this.lineItems = const [],
  });

  double get total {
    double sumTotal = 0;
    for (var i = 0; i < lineItems.length; i++) {
      sumTotal += lineItems[i].totalPrice;
    }
    return sumTotal;
  }

  @override
  List<Object> get props => [lineItems];
}
