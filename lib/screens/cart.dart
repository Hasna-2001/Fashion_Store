// lib/screens/cart.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../mr_theme.dart';
import '../services/firestore_service.dart';
import 'checkout.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Local selection map: docId → isSelected
  final Map<String, bool> _selected = {};

  double _subtotal(List<QueryDocumentSnapshot> docs) {
    double total = 0;
    for (final doc in docs) {
      final data = doc.data() as Map<String, dynamic>;
      if (_selected[doc.id] == true) {
        total += (data['price'] as num).toDouble() *
            (data['quantity'] as num).toInt();
      }
    }
    return total;
  }

  int _selectedCount(List<QueryDocumentSnapshot> docs) =>
      docs.where((d) => _selected[d.id] == true).length;

  bool _allSelected(List<QueryDocumentSnapshot> docs) =>
      docs.isNotEmpty && docs.every((d) => _selected[d.id] == true);

  void _toggleAll(List<QueryDocumentSnapshot> docs, bool val) {
    setState(() {
      for (final doc in docs) {
        _selected[doc.id] = val;
      }
    });
    for (final doc in docs) {
      FirestoreService.updateCartSelected(doc.id, val);
    }
  }

  void _toggleItem(String docId, bool val) {
    setState(() => _selected[docId] = val);
    FirestoreService.updateCartSelected(docId, val);
  }

  List<Map<String, dynamic>> _selectedItems(List<QueryDocumentSnapshot> docs) {
    return docs
        .where((d) => _selected[d.id] == true)
        .map((d) => {...(d.data() as Map<String, dynamic>), 'docId': d.id})
        .toList();
  }

  Future<void> _deleteSelected(List<QueryDocumentSnapshot> docs) async {
    final toDelete =
        docs.where((d) => _selected[d.id] == true).map((d) => d.id).toList();
    for (final id in toDelete) {
      await FirestoreService.removeFromCart(id);
      _selected.remove(id);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MR.bg,
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirestoreService.cartStream(),
          builder: (context, snapshot) {
            final docs = snapshot.data?.docs ?? [];

            // Initialise selection state for new docs
            for (final doc in docs) {
              _selected.putIfAbsent(doc.id, () {
                final data = doc.data() as Map<String, dynamic>;
                return data['isSelected'] as bool? ?? false;
              });
            }

            final subtotal = _subtotal(docs);
            final shipping = _selectedCount(docs) == 0 ? 0.0 : 5.0;
            final selCount = _selectedCount(docs);
            final allSel = _allSelected(docs);

            return Column(
              children: [
                // ── Header ─────────────────────────────────────────────
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: const BoxDecoration(
                    color: MR.surface,
                    border: Border(bottom: BorderSide(color: MR.divider)),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.chevron_left,
                            size: 28, color: MR.textMain),
                      ),
                      const SizedBox(width: 8),
                      const Text('My Cart', style: MR.h2),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          height: 34,
                          decoration: BoxDecoration(
                            color: MR.surface2,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: MR.divider),
                          ),
                          child: const Row(
                            children: [
                              SizedBox(width: 14),
                              Text('View my voucher', style: MR.caption),
                              Spacer(),
                              Icon(Icons.chevron_right,
                                  size: 18, color: MR.textSub),
                              SizedBox(width: 6),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap:
                            selCount == 0 ? null : () => _deleteSelected(docs),
                        child: Icon(Icons.delete_outline,
                            color: selCount == 0 ? MR.textSub : MR.rose,
                            size: 22),
                      ),
                    ],
                  ),
                ),

                // ── Items ──────────────────────────────────────────────
                Expanded(
                  child: snapshot.connectionState == ConnectionState.waiting
                      ? const Center(
                          child: CircularProgressIndicator(color: MR.rose))
                      : docs.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 90,
                                    height: 90,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: MR.surface2,
                                    ),
                                    child: const Icon(
                                        Icons.shopping_bag_outlined,
                                        size: 44,
                                        color: MR.textSub),
                                  ),
                                  const SizedBox(height: 20),
                                  const Text('Your cart is empty',
                                      style: MR.h2),
                                  const SizedBox(height: 8),
                                  const Text(
                                      'Add something beautiful to begin.',
                                      style: MR.caption),
                                ],
                              ),
                            )
                          : ListView.separated(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              itemCount: docs.length,
                              separatorBuilder: (_, __) =>
                                  Divider(height: 1, color: MR.divider),
                              itemBuilder: (context, i) {
                                final doc = docs[i];
                                final data = doc.data() as Map<String, dynamic>;
                                final qty = (data['quantity'] as num).toInt();
                                return _CartItemTile(
                                  docId: doc.id,
                                  data: data,
                                  isSelected: _selected[doc.id] ?? false,
                                  onToggle: (val) =>
                                      _toggleItem(doc.id, val ?? false),
                                  onIncrement: () =>
                                      FirestoreService.updateCartQuantity(
                                          doc.id, qty + 1),
                                  onDecrement: () =>
                                      FirestoreService.updateCartQuantity(
                                          doc.id, qty - 1),
                                  onDelete: () =>
                                      FirestoreService.removeFromCart(doc.id),
                                );
                              },
                            ),
                ),

                // ── Bottom bar ─────────────────────────────────────────
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: MR.surface,
                    border: const Border(top: BorderSide(color: MR.divider)),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2E1E10).withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(0, -3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Checkbox(
                        value: allSel,
                        activeColor: MR.rose,
                        onChanged: (val) => _toggleAll(docs, val ?? false),
                      ),
                      const Text('ALL',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: MR.textSub)),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Subtotal : \$${subtotal.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: MR.gold)),
                          Text(
                              'Shipping fee : \$${shipping.toStringAsFixed(2)}',
                              style: MR.caption),
                        ],
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: selCount == 0
                            ? null
                            : () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => CheckoutPage(
                                      selectedItems: _selectedItems(docs),
                                    ),
                                  ),
                                ),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                          decoration: BoxDecoration(
                            gradient: selCount == 0 ? null : MR.roseFade,
                            color: selCount == 0 ? MR.surface2 : null,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Checkout ($selCount)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              color: selCount == 0 ? MR.textSub : Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: MR.surface,
          border: Border(top: BorderSide(color: MR.divider)),
        ),
        child: BottomNavigationBar(
          currentIndex: 2,
          onTap: (i) {
            if (i == 0) Navigator.pop(context);
          },
          selectedItemColor: MR.rose,
          unselectedItemColor: MR.textSub,
          backgroundColor: MR.surface,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.explore_outlined), label: 'Explore'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined), label: 'Bag'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

// ── _CartItemTile ─────────────────────────────────────────────────────────────
class _CartItemTile extends StatelessWidget {
  final String docId;
  final Map<String, dynamic> data;
  final bool isSelected;
  final ValueChanged<bool?> onToggle;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onDelete;

  const _CartItemTile({
    required this.docId,
    required this.data,
    required this.isSelected,
    required this.onToggle,
    required this.onIncrement,
    required this.onDecrement,
    required this.onDelete,
  });

  /// Supports both network URLs (http/https) and local asset paths.
  Widget _buildImage(String? path) {
    if (path == null || path.isEmpty) {
      return const Icon(Icons.shopping_bag_outlined,
          color: MR.textSub, size: 32);
    }
    if (path.startsWith('http')) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        loadingBuilder: (_, child, progress) => progress == null
            ? child
            : const Center(
                child:
                    CircularProgressIndicator(strokeWidth: 2, color: MR.rose)),
        errorBuilder: (_, __, ___) => const Icon(Icons.shopping_bag_outlined,
            color: MR.textSub, size: 32),
      );
    }
    return Image.asset(
      path,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) =>
          const Icon(Icons.shopping_bag_outlined, color: MR.textSub, size: 32),
    );
  }

  @override
  Widget build(BuildContext context) {
    final price = (data['price'] as num).toDouble();
    final qty = (data['quantity'] as num).toInt();
    final imagePath = data['imageUrl'] ?? data['imagePath'] ?? data['image'];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: isSelected,
            activeColor: MR.rose,
            onChanged: onToggle,
          ),

          // Product image
          Container(
            width: 82,
            height: 82,
            decoration: BoxDecoration(
              color: MR.surface2,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: MR.divider),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: _buildImage(imagePath),
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(data['name'] ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: MR.textMain)),
                    ),
                    GestureDetector(
                      onTap: onDelete,
                      child:
                          const Icon(Icons.close, size: 16, color: MR.textSub),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                if (data['color'] != null &&
                    (data['color'] as String).isNotEmpty)
                  Text(data['color'] as String,
                      style: const TextStyle(fontSize: 11, color: MR.rose)),
                const SizedBox(height: 2),
                if (data['description'] != null)
                  Text(data['description'] as String,
                      style: MR.caption,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text('\$${price.toStringAsFixed(2)}', style: MR.price),
                    const Spacer(),
                    // Quantity control
                    Container(
                      decoration: BoxDecoration(
                        color: MR.surface2,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: MR.divider),
                      ),
                      child: Row(
                        children: [
                          _QtyBtn(icon: '−', onTap: onDecrement),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text('$qty',
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: MR.textMain)),
                          ),
                          _QtyBtn(icon: '+', onTap: onIncrement),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QtyBtn extends StatelessWidget {
  final String icon;
  final VoidCallback onTap;
  const _QtyBtn({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 28,
        height: 28,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: MR.surface,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(icon,
            style: const TextStyle(
                fontSize: 16, color: MR.textMain, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
