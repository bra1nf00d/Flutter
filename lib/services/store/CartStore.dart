import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:testtask/models/index.dart';

class CartStore extends ChangeNotifier {
  var currentCount = 0;
  final _box = Hive.box('store');

  get count {
    return "$currentCount";
  }

  CartStore() {
    calcCount();
  }

  Future<void> store(int id, Product value) async {
    try {
      CartItem data;
      CartItem? stored = _box.get(id);

      if (stored == null) {
        data = CartItem(value, 1);
      } else {
        var count = stored.count + 1;

        data = CartItem(value, count);
      }

      await _box.put(id, data);
      calcCount();
    } catch (e) {
      print("Hive Error $e");
    }
  }

  Future<void> plusOne(int id) async {
    try {
      CartItem data;
      CartItem? stored = _box.get(id);

      if (stored != null) {
        var count = stored.count + 1;

        data = CartItem(stored.object, count);
        await _box.put(id, data);
        calcCount();
      }
    } catch (e) {
      print("Hive Error $e");
    }
  }

  Future<void> removeOne(int id) async {
    try {
      CartItem data;
      CartItem? stored = _box.get(id);

      if (stored != null) {
        if (stored.count <= 1) {
          await _box.delete(id);
        } else {
          var count = stored.count - 1;

          data = CartItem(stored.object, count);
          await _box.put(id, data);
        }
      }

      calcCount();
    } catch (e) {
      print("Hive Error $e");
    }
  }

  Future<CartItem?> getOne(int id) async {
    try {
      return await _box.get(id);
    } catch (e) {
      print("Hive Error $e");
      return null;
    }
  }

  List<CartItem>? getAll() {
    try {
      final data = _box.toMap().values;

      if (data.isEmpty) {
        return null;
      }

      return data.toList().cast<CartItem>();
    } catch (e) {
      print("Hive Error $e");
      return null;
    }
  }

  Future<void> removeAll() async {
    try {
      await _box.clear();
      calcCount();
    } catch (e) {
      print("Hive Error $e");
    }
  }

  void calcCount() {
    try {
      var itemsCount = 0;
      final data = _box.toMap().values;

      if (data.isEmpty) {
        currentCount = 0;
        notifyListeners();
        return;
      }

      data.toList().cast<CartItem>().forEach((e) => itemsCount += e.count);
      currentCount = itemsCount;
      notifyListeners();
    } catch(e) {
      print("Hive Error $e");
      return;
    }
  }
}