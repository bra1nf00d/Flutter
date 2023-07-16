import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:testtask/models/index.dart';
import 'package:testtask/screens/index.dart';
import 'package:testtask/services/index.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CartItemAdapter());
  Hive.registerAdapter(ProductAdapter());
  await Hive.openBox('store');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<CartStore>(
          create: (context) => CartStore(),
        ),
        ChangeNotifierProvider<Auth>(
          create: (context) => Auth(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CatalogScreen(),
    );
  }
}


