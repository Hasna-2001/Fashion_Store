// lib/screens/product_details.dart

import 'package:flutter/material.dart';
import '../mr_theme.dart';
import '../services/firestore_service.dart';
import '../services/recently_viewed_service.dart';
import 'checkout.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, dynamic> product;
  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int _selectedImageIndex = 0;
  String? _selectedColor;
  String? _selectedSize;
  bool _isFavorited = false;
  bool _addingToCart = false;

  // ── Data helpers ─────────────────────────────────────────────────────────

  List<String> get _colors =>
      (widget.product['colors'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
      [];

  List<String> get _sizes =>
      (widget.product['sizes'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .toList() ??
      [];

  /// colorImages: { 'ColorName': 'assets/path/image.jpg' }
  Map<String, String> get _colorImages {
    final raw = widget.product['colorImages'];
    if (raw == null) return {};
    if (raw is Map) {
      return raw.map((k, v) => MapEntry(k.toString(), v.toString()));
    }
    return {};
  }

  // Primary asset path for the product (key: 'imagePath')
  String get _mainImagePath => (widget.product['imagePath'] as String?) ?? '';

  // Extra thumbnail asset paths (key: 'thumbnailPaths')
  List<String> get _extraThumbs =>
      (widget.product['thumbnailPaths'] as List<dynamic>?)
          ?.map((e) => e.toString())
          .where((s) => s.isNotEmpty)
          .toList() ??
      [];

  /// All gallery images (main + thumbnails).
  List<String> get _allImages {
    final all = <String>[];
    if (_mainImagePath.isNotEmpty) all.add(_mainImagePath);
    all.addAll(_extraThumbs);
    return all.isEmpty ? [''] : all;
  }

  /// The image currently shown in the hero slot.
  /// When a colour is selected and it has a mapped asset path, that takes priority.
  String get _activeImagePath {
    if (_selectedColor != null && _colorImages.containsKey(_selectedColor)) {
      return _colorImages[_selectedColor]!;
    }
    final images = _allImages;
    if (_selectedImageIndex >= images.length) return images.first;
    return images[_selectedImageIndex];
  }

  @override
  void initState() {
    super.initState();
    if (_colors.isNotEmpty) _selectedColor = _colors.first;
    if (_sizes.isNotEmpty) _selectedSize = _sizes.first;
    // Track recently viewed — runs after frame so auth session is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final imageUrl = (widget.product['imageUrl'] as String? ?? '').isNotEmpty
          ? widget.product['imageUrl'] as String
          : (widget.product['imagePath'] as String? ?? '');
      RecentlyViewedService.track({...widget.product, 'imageUrl': imageUrl});
    });
  }

  // ── Cart ────────────────────────────────────────────────────────────────

  Future<void> _addToCart() async {
    if (_selectedColor == null && _colors.isNotEmpty) {
      _snack('Please select a colour');
      return;
    }
    if (_selectedSize == null && _sizes.isNotEmpty) {
      _snack('Please select a size');
      return;
    }
    setState(() => _addingToCart = true);
    try {
      // Resolve image: prefer imageUrl (Firestore products), fall back to imagePath (local assets)
      final imageUrl = (widget.product['imageUrl'] as String? ?? '').isNotEmpty
          ? widget.product['imageUrl'] as String
          : _activeImagePath;
      await FirestoreService.addToCart({
        'id': widget.product['id'] ?? 'item',
        'name': widget.product['name'] ?? 'Product',
        'description': widget.product['description'] ?? '',
        'price': (widget.product['price'] as num?)?.toDouble() ?? 0.0,
        'imageUrl':
            imageUrl, // cart.dart reads data['imageUrl'] ?? data['imagePath']
        'imagePath': _activeImagePath,
        'color': _selectedColor ?? '',
        'size': _selectedSize ?? '',
      });
      if (!mounted) return;
      setState(() => _addingToCart = false);
      _snack('${widget.product['name']} added to cart!');
    } catch (e) {
      if (!mounted) return;
      setState(() => _addingToCart = false);
      // Show the real error so we can debug it
      final msg = e.toString();
      if (msg.contains('NOT_SIGNED_IN')) {
        _snack('Please sign in to add items to cart.');
      } else if (msg.contains('permission-denied') ||
          msg.contains('PERMISSION_DENIED')) {
        _snack(
            'Permission denied — check Firestore Security Rules in Firebase Console.');
      } else {
        _snack('Error: $msg');
      }
    }
  }

  void _snack(String msg) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg, style: const TextStyle(color: MR.textMain)),
          duration: const Duration(seconds: 2),
          backgroundColor: MR.surface2,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );

  // ── Asset image widget ─────────────────────────────────────────────────

  Widget _assetImage(String path, {BoxFit fit = BoxFit.cover}) {
    if (path.isEmpty) {
      return Container(
        color: MR.surface2,
        child: const Center(
          child: Icon(Icons.shopping_bag_outlined, size: 60, color: MR.textSub),
        ),
      );
    }
    return Image.asset(
      path,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => Container(
        color: MR.surface2,
        child: const Center(
          child: Icon(Icons.shopping_bag_outlined, size: 60, color: MR.textSub),
        ),
      ),
    );
  }

  // ── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final price = (product['price'] as num?)?.toDouble() ?? 0.0;
    final images = _allImages;

    return Scaffold(
      backgroundColor: MR.bg,
      body: SafeArea(
        child: Column(
          children: [
            // ── Top bar ──────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _iconBtn(Icons.chevron_left, () => Navigator.pop(context)),
                  const Text('Product Details', style: MR.h2),
                  _iconBtn(Icons.share_outlined, () {}),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Main image ──────────────────────────────────────
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          height: 300,
                          decoration: BoxDecoration(
                            color: MR.surface,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: MR.divider),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              child: SizedBox.expand(
                                key: ValueKey(_activeImagePath),
                                child: _assetImage(_activeImagePath,
                                    fit: BoxFit.contain),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 14,
                          right: 28,
                          child: GestureDetector(
                            onTap: () =>
                                setState(() => _isFavorited = !_isFavorited),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 38,
                              height: 38,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _isFavorited ? MR.rose : MR.surface2,
                                border: Border.all(
                                    color: _isFavorited ? MR.rose : MR.divider),
                              ),
                              child: Icon(
                                _isFavorited
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: _isFavorited ? Colors.white : MR.textSub,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // ── Thumbnail strip (shown when >1 images) ──────────
                    if (images.length > 1)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(images.length, (i) {
                              final selected = _selectedImageIndex == i &&
                                  _selectedColor == null;
                              return GestureDetector(
                                onTap: () => setState(() {
                                  _selectedImageIndex = i;
                                  _selectedColor =
                                      null; // clear colour override
                                }),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 180),
                                  margin: const EdgeInsets.only(right: 10),
                                  width: 68,
                                  height: 68,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: selected ? MR.rose : MR.divider,
                                      width: selected ? 2 : 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                    color: MR.surface,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(9),
                                    child: _assetImage(images[i]),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),

                    const SizedBox(height: 18),

                    // ── Name + Price ──────────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(product['name'] ?? 'Product',
                                style: MR.h2),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              gradient: MR.goldFade,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '\$${price.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 8),

                    // ── Rating ────────────────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          ...List.generate(
                              5,
                              (i) => const Icon(Icons.star_rounded,
                                  color: Color(0xFFD4AF7A), size: 16)),
                          const SizedBox(width: 6),
                          const Text('4.8',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: MR.gold)),
                          const SizedBox(width: 4),
                          const Text('(128 reviews)',
                              style:
                                  TextStyle(fontSize: 11, color: MR.textSub)),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // ── Description ───────────────────────────────────────
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        product['description'] ??
                            'A beautifully crafted piece from HS Fashion Store.',
                        style: MR.caption,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Divider(color: MR.divider),
                    ),

                    // ── Size selector ─────────────────────────────────────
                    if (_sizes.isNotEmpty) ...[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(16, 4, 16, 10),
                        child: Text('Select Size',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: MR.textMain)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: _sizes
                                .map((size) => GestureDetector(
                                      onTap: () =>
                                          setState(() => _selectedSize = size),
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 180),
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 14, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: _selectedSize == size
                                              ? MR.rose
                                              : MR.surface2,
                                          border: Border.all(
                                            color: _selectedSize == size
                                                ? MR.rose
                                                : MR.divider,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          size,
                                          style: TextStyle(
                                            color: _selectedSize == size
                                                ? Colors.white
                                                : MR.textSub,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // ── Colour selector ───────────────────────────────────
                    if (_colors.isNotEmpty) ...[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 10),
                        child: Row(
                          children: [
                            const Text('Select Colour',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: MR.textMain)),
                            if (_selectedColor != null) ...[
                              const SizedBox(width: 8),
                              Text(
                                '— $_selectedColor',
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: MR.rose,
                                    fontWeight: FontWeight.w500),
                              ),
                            ]
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: _colors
                                .map((color) => GestureDetector(
                                      onTap: () => setState(() {
                                        _selectedColor = color;
                                        _selectedImageIndex = 0;
                                      }),
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 180),
                                        margin:
                                            const EdgeInsets.only(right: 10),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 10),
                                        decoration: BoxDecoration(
                                          color: _selectedColor == color
                                              ? MR.rose
                                              : MR.surface2,
                                          border: Border.all(
                                            color: _selectedColor == color
                                                ? MR.rose
                                                : MR.divider,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            // Small colour thumbnail (asset image)
                                            if (_colorImages
                                                .containsKey(color)) ...[
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                child: SizedBox(
                                                  width: 22,
                                                  height: 22,
                                                  child: _assetImage(
                                                      _colorImages[color]!),
                                                ),
                                              ),
                                              const SizedBox(width: 6),
                                            ],
                                            Text(
                                              color,
                                              style: TextStyle(
                                                color: _selectedColor == color
                                                    ? Colors.white
                                                    : MR.textSub,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                    ],

                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ),

            // ── Add to Cart + Buy Now ─────────────────────────────────────
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              decoration: const BoxDecoration(
                color: MR.surface,
                border: Border(top: BorderSide(color: MR.divider)),
              ),
              child: Row(
                children: [
                  // Favourite
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: MR.surface2,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: MR.divider),
                    ),
                    child: GestureDetector(
                      onTap: () => setState(() => _isFavorited = !_isFavorited),
                      child: Icon(
                        _isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorited ? MR.rose : MR.textSub,
                        size: 22,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Add to Cart
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.shopping_bag_outlined,
                            size: 18, color: MR.rose),
                        label: const Text('Add to Cart',
                            style: TextStyle(
                                color: MR.rose,
                                fontWeight: FontWeight.w700,
                                fontSize: 13)),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: MR.rose, width: 1.5),
                          backgroundColor: MR.surface2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: _addingToCart ? null : _addToCart,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Buy Now
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: MR.roseFade,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.bolt_rounded,
                              size: 18, color: Colors.white),
                          label: const Text('Buy Now',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () {
                            if (_selectedColor == null && _colors.isNotEmpty) {
                              _snack('Please select a colour');
                              return;
                            }
                            if (_selectedSize == null && _sizes.isNotEmpty) {
                              _snack('Please select a size');
                              return;
                            }
                            final product = widget.product;
                            final price =
                                (product['price'] as num?)?.toDouble() ?? 0.0;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CheckoutPage(
                                  selectedItems: [
                                    {
                                      'id': product['id'] ?? 'item',
                                      'name': product['name'] ?? 'Product',
                                      'description':
                                          product['description'] ?? '',
                                      'price': price,
                                      'imagePath': _activeImagePath,
                                      'color': _selectedColor ?? '',
                                      'size': _selectedSize ?? '',
                                      'quantity': 1,
                                    }
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconBtn(IconData icon, VoidCallback onTap) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: MR.surface2,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: MR.divider),
          ),
          child: Icon(icon, size: 22, color: MR.textMain),
        ),
      );
}
