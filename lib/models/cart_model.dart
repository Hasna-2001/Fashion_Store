// lib/models/cart_model.dart

class CartItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imagePath;
  final String color;
  int quantity;
  bool isSelected;

  CartItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.color,
    this.quantity = 1,
    this.isSelected = true,
  });
}

class CartManager {
  static final CartManager _instance = CartManager._internal();
  factory CartManager() => _instance;
  CartManager._internal();

  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get totalCount => _items.fold(0, (sum, item) => sum + item.quantity);

  void addItem(CartItem item) {
    final existing =
        _items.where((i) => i.id == item.id && i.color == item.color);
    if (existing.isNotEmpty) {
      existing.first.quantity++;
    } else {
      _items.add(item);
    }
  }

  void removeItem(String id, String color) {
    _items.removeWhere((i) => i.id == id && i.color == color);
  }

  void incrementQuantity(String id, String color) {
    final item = _items.firstWhere((i) => i.id == id && i.color == color);
    item.quantity++;
  }

  void decrementQuantity(String id, String color) {
    final item = _items.firstWhere((i) => i.id == id && i.color == color);
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      removeItem(id, color);
    }
  }

  double get subtotal {
    return _items
        .where((i) => i.isSelected)
        .fold(0, (sum, i) => sum + i.price * i.quantity);
  }

  List<CartItem> get selectedItems =>
      _items.where((i) => i.isSelected).toList();

  void clear() => _items.clear();
}
