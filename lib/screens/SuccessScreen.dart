import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtask/screens/index.dart';
import 'package:testtask/services/index.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  Future clearCart() async {
    await Provider.of<CartStore>(context, listen: false).removeAll();
  }

  void navigateToCatalogScreen() {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => const CatalogScreen()
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    clearCart();

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.only(bottom: 16),
              child: Image.network(
                "https://pixlok.com/wp-content/uploads/2022/01/Tick-Icon-SVG-psokcd.png",
                fit: BoxFit.cover,
              ),
            ),
            const Text(
              "Thank you!",
              style: TextStyle(
                fontSize: 28,
              ),
            ),
            const Text(
              "Your order has been placed",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
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
                onPressed: navigateToCatalogScreen,
                child: const Text(
                  'Return',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}