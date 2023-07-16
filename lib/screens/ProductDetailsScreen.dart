import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtask/models/index.dart';
import 'package:testtask/services/index.dart';
import 'package:testtask/widgets/index.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  Future storeProduct() async {
    await Provider.of<CartStore>(context, listen: false)
        .store(widget.product.id, widget.product);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: NavBar(title: widget.product.title, bag: true),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 170,
                child: Image.network(
                  widget.product.url,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                right: 15,
                bottom: -25,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Text(
                    "Album: ${widget.product.albumId}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(
              top: 36,
              left: 20,
              right: 20,
            ),
            width: MediaQuery.of(context).size.width,
            child: Text(
              widget.product.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: screenSize.width,
                height: 56,
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                  ),
                  onPressed: storeProduct,
                  child: const Text(
                    'Add to cart',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}