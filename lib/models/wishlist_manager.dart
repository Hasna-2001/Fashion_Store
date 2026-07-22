// lib/models/wishlist_manager.dart
//
// Global singleton that persists the wishlist for the app session.
// Wire product-card heart buttons to this so WishlistPage can read it.

import 'package:flutter/foundation.dart';

class WishlistItem {
  final String id;
  final String name;
  final double price;
  final String imagePath; // local asset path  OR  network URL
  final String category;

  const WishlistItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.category,
  });
}

class WishlistManager extends ChangeNotifier {
  // ── Singleton ────────────────────────────────────────────────────────────
  static final WishlistManager _instance = WishlistManager._internal();
  factory WishlistManager() => _instance;
  WishlistManager._internal();

  final Map<String, WishlistItem> _items = {};

  // ── Public API ───────────────────────────────────────────────────────────

  List<WishlistItem> get items => _items.values.toList();

  int get count => _items.length;

  bool isFaved(String id) => _items.containsKey(id);

  void toggle(WishlistItem item) {
    if (_items.containsKey(item.id)) {
      _items.remove(item.id);
    } else {
      _items[item.id] = item;
    }
    notifyListeners();
  }

  void remove(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
