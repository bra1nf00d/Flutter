import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtask/screens/index.dart';
import 'package:testtask/services/index.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool bag;

  NavBar({
    Key? key,
    this.bag = false,
    required this.title,
  }) : super(key: key);

  final List<Widget> actions = [];

  @override
  Widget build(BuildContext context) {
    if (bag) {
      actions.add(
        IconButton(
          icon: Consumer<CartStore>(
            builder: (context, store, child) {
              return Badge(
                label: Text(Provider.of<CartStore>(context, listen: true).count ?? "0"),
                child: const Icon(Icons.shopping_bag),
              );
            },
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => const CartScreen()
              ),
            );
          },
        )
      );
    }

    return AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}
