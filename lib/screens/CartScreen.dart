import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtask/models/CartItem.dart';
import 'package:testtask/screens/index.dart';
import 'package:testtask/services/index.dart';
import 'package:testtask/widgets/index.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Future loadItems() async {
    List<CartItem>? data = Provider.of<CartStore>(context, listen: false).getAll();

    if (data == null) {
      return <CartItem>[];
    }
    return data;
  }

  Future plusOne(int id) async {
    await Provider.of<CartStore>(context, listen: false).plusOne(id);
    setState(() {});
  }

  Future removeOne(int id) async {
    await Provider.of<CartStore>(context, listen: false).removeOne(id);
    setState(() {});
  }

  void navigateToAccountScreen() {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => const AccountScreen()
        )
    );
  }

  void navigateToSuccessScreen() {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => const SuccessScreen()
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(title: 'Cart'),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: FutureBuilder(
            future: loadItems(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<CartItem> cartItems = snapshot.data;

                if (cartItems.isEmpty) {
                  return const Center(
                    child: Text("Your cart is currently empty"),
                  );
                }

                return Consumer<Auth>(
                  builder: (context, auth, child) {
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: cartItems.length,
                            itemBuilder: (BuildContext context, int index) {
                              var item = cartItems[index];
                              final trimmed = '${item.object.title.substring(0, min(item.object.title.length, 30))}...';

                              return Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 70,
                                        height: 70,
                                        child: Image.network(
                                          item.object.thumbnailUrl,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 100,
                                            padding: const EdgeInsets.only(
                                              left: 10,
                                            ),
                                            child: Text(
                                              "Album: ${item.object.albumId}",
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 135,
                                            padding: const EdgeInsets.only(
                                              left: 10,
                                            ),
                                            child: Text(
                                              trimmed,
                                              maxLines: 2,
                                              style: const TextStyle(
                                                fontSize: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: const CircleBorder(),
                                          primary: Colors.black,
                                        ),
                                        onPressed: () {
                                          plusOne(item.object.id);
                                        },
                                        child: const Text(
                                          "+",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "${item.count}",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: const CircleBorder(),
                                          primary: Colors.black,
                                        ),
                                        onPressed: () {
                                          removeOne(item.object.id);
                                        },
                                        child: const Text(
                                          "-",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.black),
                                shape: MaterialStateProperty.all(
                                  const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                  ),
                                ),
                                minimumSize: MaterialStateProperty.all(
                                  const Size(150, 60),
                                ),
                              ),
                              onPressed: auth.user == null ? navigateToAccountScreen : navigateToSuccessScreen,
                              child: Text(
                                auth.user == null ? 'Sign in to Google account' : 'Make an offer',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }

              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}