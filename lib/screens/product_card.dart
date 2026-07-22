// lib/widgets/product_card.dart
import 'package:flutter/material.dart';
import '../mr_theme.dart';

class ProductCard extends StatefulWidget {
  final String name;
  final String price;
  final String imageUrl;
  final VoidCallback? onTap;

  const ProductCard(
    this.name,
    this.price,
    this.imageUrl, {
    super.key,
    this.onTap,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _fav = false;

  Widget _buildImage() {
    if (widget.imageUrl.isNotEmpty) {
      return Image.network(
        widget.imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Container(
            color: MR.surface2,
            child: const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child:
                    CircularProgressIndicator(color: MR.rose, strokeWidth: 2),
              ),
            ),
          );
        },
        errorBuilder: (_, __, ___) => _placeholder(),
      );
    }
    return _placeholder();
  }

  Widget _placeholder() => Container(
        color: MR.surface2,
        child: const Center(
          child: Icon(Icons.shopping_bag_outlined, size: 40, color: MR.textSub),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: MR.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: MR.divider),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2E1E10).withOpacity(0.08),
              blurRadius: 10,
              offset: const Offset(0, 4),
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
                    child: SizedBox.expand(child: _buildImage()),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () => setState(() => _fav = !_fav),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _fav ? MR.rose : MR.surface.withOpacity(0.85),
                          border:
                              Border.all(color: _fav ? MR.rose : MR.divider),
                        ),
                        child: Icon(
                          _fav ? Icons.favorite : Icons.favorite_border,
                          size: 16,
                          color: _fav ? Colors.white : MR.textSub,
                        ),
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
                    widget.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: MR.textMain),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.price, style: MR.price),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: MR.roseFade,
                        ),
                        child: const Icon(Icons.add,
                            size: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
