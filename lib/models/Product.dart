import 'package:hive/hive.dart';
part 'Product.g.dart';

@HiveType(typeId: 0)
class Product {
  @HiveField(0)
  int id;
  @HiveField(1)
  int albumId;
  @HiveField(2)
  String title;
  @HiveField(3)
  String url;
  @HiveField(4)
  String thumbnailUrl;

  Product({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
  });

  factory Product.fromJson(json) {
    return Product(albumId: json['albumId'], id: json['id'], title: json['title'], url: json['url'], thumbnailUrl: json['thumbnailUrl']);
  }
}