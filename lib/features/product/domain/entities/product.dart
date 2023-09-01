// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;

  final String name;

  final String imageUrl;

  final double price;
  const Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.price,
  });

  @override
  List<Object> get props => [id, name, imageUrl, price];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
    };
  }
}
