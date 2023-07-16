import 'package:hive/hive.dart';
import 'package:testtask/models/index.dart';
part 'CartItem.g.dart';

@HiveType(typeId: 1)
class CartItem {
  @HiveField(0)
  Product object;
  @HiveField(1)
  int count;

  CartItem(this.object, this.count);
}