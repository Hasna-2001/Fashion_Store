// lib/screens/wishlist.dart
import 'package:flutter/material.dart';
import '../mr_theme.dart';
import '../models/wishlist_manager.dart';
import 'product_details.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});
  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final _wl = WishlistManager();

  @override
  void initState() {
    super.initState();
    _wl.addListener(_refresh);
  }

  @override
  void dispose() {
    _wl.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() => setState(() {});

  Widget _buildImage(String path) {
    if (path.isEmpty) return _placeholder();
    // Network URL
    if (path.startsWith('http')) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _placeholder(),
      );
    }
    // Local asset
    return Image.asset(
      path,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => _placeholder(),
    );
  }

  Widget _placeholder() => Container(
        color: MR.surface2,
        child: const Center(
          child: Icon(Icons.shopping_bag_outlined, size: 28, color: MR.textSub),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final items = _wl.items;

    return Scaffold(
      backgroundColor: MR.bg,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ──────────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                  const Expanded(
                    child: Center(
                      child: Text('My Wishlist', style: MR.h2),
                    ),
                  ),
                  if (items.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            backgroundColor: MR.surface,
                            title: const Text('Clear Wishlist',
                                style: TextStyle(color: MR.textMain)),
                            content: const Text(
                                'Remove all items from your wishlist?',
                                style: TextStyle(color: MR.textSub)),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel',
                                    style: TextStyle(color: MR.textSub)),
                              ),
                              TextButton(
                                onPressed: () {
                                  _wl.clear();
                                  Navigator.pop(context);
                                },
                                child: const Text('Clear',
                                    style: TextStyle(color: MR.rose)),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text('Clear all',
                          style: TextStyle(
                              fontSize: 13,
                              color: MR.rose,
                              fontWeight: FontWeight.w600)),
                    )
                  else
                    const SizedBox(width: 60),
                ],
              ),
            ),

            // ── Body ────────────────────────────────────────────────────
            Expanded(
              child: items.isEmpty
                  ? _emptyState()
                  : GridView.builder(
                      padding: const EdgeInsets.all(14),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.68,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: items.length,
                      itemBuilder: (_, i) => _buildCard(items[i]),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration:
                const BoxDecoration(color: MR.surface2, shape: BoxShape.circle),
            child:
                const Icon(Icons.favorite_border, size: 36, color: MR.textSub),
          ),
          const SizedBox(height: 16),
          const Text('Your wishlist is empty',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: MR.textMain)),
          const SizedBox(height: 6),
          const Text('Tap the ♡ on any product to save it here',
              style: TextStyle(fontSize: 13, color: MR.textSub),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildCard(WishlistItem item) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ProductDetailsPage(product: {
            'id': item.id,
            'name': item.name,
            'price': item.price,
            'imagePath': item.imagePath,
            'category': item.category,
            'description': '',
            'sizes': <String>[],
            'colors': <String>[],
          }),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: MR.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: MR.divider),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2E1E10).withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(14)),
                    child: SizedBox.expand(child: _buildImage(item.imagePath)),
                  ),
                  // Remove from wishlist button
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () => _wl.remove(item.id),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: MR.rose,
                        ),
                        child: const Icon(Icons.favorite,
                            size: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: MR.textMain),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Text('\$${item.price.toStringAsFixed(2)}', style: MR.price),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
