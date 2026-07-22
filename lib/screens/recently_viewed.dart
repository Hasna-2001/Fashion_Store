// lib/screens/recently_viewed.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../mr_theme.dart';
import '../services/recently_viewed_service.dart';
import 'product_details.dart';

class RecentlyViewedPage extends StatelessWidget {
  const RecentlyViewedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MR.bg,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ───────────────────────────────────────────────────
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
                      child: Text('Recently Viewed', style: MR.h2),
                    ),
                  ),
                  // Clear all button
                  GestureDetector(
                    onTap: () => _confirmClear(context),
                    child: const Text('Clear',
                        style: TextStyle(
                            fontSize: 13,
                            color: MR.rose,
                            fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),

            // ── List ─────────────────────────────────────────────────────
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: RecentlyViewedService.stream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(color: MR.rose));
                  }

                  final docs = snapshot.data?.docs ?? [];

                  if (docs.isEmpty) {
                    return Center(
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
                            child: const Icon(Icons.history,
                                size: 44, color: MR.textSub),
                          ),
                          const SizedBox(height: 20),
                          const Text('Nothing here yet', style: MR.h2),
                          const SizedBox(height: 8),
                          const Text(
                            'Products you view will appear here.',
                            style: MR.caption,
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: docs.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, i) {
                      final data = docs[i].data() as Map<String, dynamic>;
                      final imageUrl = data['imageUrl'] as String? ?? '';
                      final name = data['name'] as String? ?? '';
                      final price = (data['price'] as num?)?.toDouble() ?? 0.0;
                      final category = data['category'] as String? ?? '';
                      final ts = data['viewedAt'] as Timestamp?;
                      final timeAgo =
                          ts != null ? _timeAgo(ts.toDate()) : 'Recently';

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductDetailsPage(
                                product: {
                                  ...data,
                                  'id': data['productId'],
                                  'imageUrl': imageUrl,
                                  'imagePath': imageUrl,
                                },
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: MR.surface,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: MR.divider),
                          ),
                          child: Row(
                            children: [
                              // ── Product image ─────────────────────────
                              ClipRRect(
                                borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(14)),
                                child: SizedBox(
                                  width: 90,
                                  height: 90,
                                  child: _buildImage(imageUrl),
                                ),
                              ),
                              const SizedBox(width: 14),
                              // ── Info ──────────────────────────────────
                              Expanded(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (category.isNotEmpty)
                                        Text(category,
                                            style: const TextStyle(
                                                fontSize: 10,
                                                color: MR.rose,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: 0.5)),
                                      const SizedBox(height: 2),
                                      Text(name,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: MR.textMain),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis),
                                      const SizedBox(height: 6),
                                      Text('\$${price.toStringAsFixed(2)}',
                                          style: MR.price),
                                    ],
                                  ),
                                ),
                              ),
                              // ── Time + arrow ──────────────────────────
                              Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(timeAgo,
                                        style: const TextStyle(
                                            fontSize: 10, color: MR.textSub)),
                                    const SizedBox(height: 8),
                                    const Icon(Icons.chevron_right,
                                        size: 18, color: MR.textSub),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String url) {
    if (url.isEmpty) {
      return Container(
        color: MR.surface2,
        child: const Icon(Icons.shopping_bag_outlined,
            color: MR.textSub, size: 28),
      );
    }
    if (url.startsWith('http')) {
      return Image.network(url,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
              color: MR.surface2,
              child: const Icon(Icons.shopping_bag_outlined,
                  color: MR.textSub, size: 28)));
    }
    return Image.asset(url,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
            color: MR.surface2,
            child: const Icon(Icons.shopping_bag_outlined,
                color: MR.textSub, size: 28)));
  }

  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${dt.day}/${dt.month}/${dt.year}';
  }

  void _confirmClear(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: MR.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Clear History?',
            style: TextStyle(color: MR.textMain, fontWeight: FontWeight.bold)),
        content: const Text(
          'This will remove all recently viewed products.',
          style: TextStyle(color: MR.textSub, fontSize: 13),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: MR.textSub)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await RecentlyViewedService.clearAll();
            },
            child: const Text('Clear All',
                style: TextStyle(color: MR.rose, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
