import 'dart:math';
import 'package:flutter/material.dart';
import 'package:testtask/models/index.dart';

class ProductView extends StatelessWidget {
  final Product product;

  const ProductView({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var trimmedName = '${product.title.substring(0, min(product.title.length, 15))}...';

    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 170,
          child: Image.network(
            product.url,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            width: MediaQuery.of(context).size.width,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(50),
            ),
            child: Row(
              children: [
                Text(
                  trimmedName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}