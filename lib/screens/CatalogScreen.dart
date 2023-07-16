import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:testtask/models/index.dart';
import 'package:testtask/screens/index.dart';
import 'package:testtask/services/index.dart';
import 'package:testtask/widgets/index.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final MAX_LIMIT = 60;
  var _start = 0;
  var _limit = 10;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (MAX_LIMIT > _limit && _scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _start += 10;
        _limit += 10;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future fetchProducts() async {
    var limit = MAX_LIMIT > _limit ? _limit : MAX_LIMIT;
    var data = await APIClient.shared.get(url: '/photos', parameters: {
      "_start": _start,
      "_limit": limit,
    });

    if (data == null) {
      return <Product>[];
    }
    return data.map<Product>((product) => Product.fromJson(product)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(
          title: Provider.of<Auth>(context).user?.displayName ?? 'Flutter',
          bag: true,
      ),
      drawer: const SideBar(),
      body: Center(
        child: FutureBuilder(
          future: fetchProducts(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<Product> products = snapshot.data;

              return ListView.builder(
                controller: _scrollController,
                itemCount: MAX_LIMIT > _limit ? products.length + 1 : products.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == products.length) {
                    return const ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          CircularProgressIndicator(),
                        ],
                      ),
                    );
                  }
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    child: InkWell(
                      child: ProductView(product: products[index]),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => ProductDetailsScreen(product: products[index])
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}