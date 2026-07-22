// lib/screens/orders.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../mr_theme.dart';
import '../services/firestore_service.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  String _statusKey(String status) {
    switch (status.toLowerCase()) {
      case 'processing':
        return 'processing';
      case 'shipped':
        return 'shipped';
      case 'delivered':
        return 'delivered';
      default:
        return 'other';
    }
  }

  Color _chipColor(String key) {
    switch (key) {
      case 'processing':
        return const Color(0xFFD4AF7A); // gold
      case 'shipped':
        return const Color(0xFF5BA3D9); // blue
      case 'delivered':
        return const Color(0xFF4CAF8A); // green
      default:
        return MR.textSub;
    }
  }

  /// Loads image from URL or asset path gracefully.
  Widget _buildItemImage(String? path) {
    if (path == null || path.isEmpty) {
      return const Icon(Icons.shopping_bag_outlined,
          color: MR.textSub, size: 22);
    }
    if (path.startsWith('http')) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Icon(Icons.shopping_bag_outlined,
            color: MR.textSub, size: 22),
      );
    }
    return Image.asset(
      path,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) =>
          const Icon(Icons.shopping_bag_outlined, color: MR.textSub, size: 22),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MR.bg,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ─────────────────────────────────────────────────
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
                      child: Text('My Orders', style: MR.h2),
                    ),
                  ),
                  const SizedBox(width: 28),
                ],
              ),
            ),

            // ── Orders list ─────────────────────────────────────────────
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirestoreService.ordersStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                        child: CircularProgressIndicator(color: MR.rose));
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error loading orders',
                          style: TextStyle(color: MR.textSub)),
                    );
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
                            child: const Icon(Icons.receipt_long_outlined,
                                size: 44, color: MR.textSub),
                          ),
                          const SizedBox(height: 20),
                          const Text('No orders yet', style: MR.h2),
                          const SizedBox(height: 8),
                          const Text('Your purchase history will appear here.',
                              style: MR.caption),
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
                      final items = (data['items'] as List<dynamic>?) ?? [];
                      final total = (data['total'] as num?)?.toDouble() ?? 0.0;
                      final status = data['status'] as String? ?? 'Processing';
                      final ts = data['createdAt'] as Timestamp?;
                      final date =
                          ts != null ? _formatDate(ts.toDate()) : 'Just now';
                      final delivery =
                          data['deliveryDetails'] as Map<String, dynamic>?;

                      final colorKey = _statusKey(status);

                      return _OrderCard(
                        orderId: docs[i].id,
                        date: date,
                        status: status,
                        chipColor: _chipColor(colorKey),
                        items: items,
                        total: total,
                        delivery: delivery,
                        buildItemImage: _buildItemImage,
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

  String _formatDate(DateTime dt) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${months[dt.month - 1]} ${dt.day}, ${dt.year}';
  }
}

// ── _OrderCard ────────────────────────────────────────────────────────────────
class _OrderCard extends StatefulWidget {
  final String orderId;
  final String date;
  final String status;
  final Color chipColor;
  final List<dynamic> items;
  final double total;
  final Map<String, dynamic>? delivery;
  final Widget Function(String?) buildItemImage;

  const _OrderCard({
    required this.orderId,
    required this.date,
    required this.status,
    required this.chipColor,
    required this.items,
    required this.total,
    required this.delivery,
    required this.buildItemImage,
  });

  @override
  State<_OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<_OrderCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MR.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: MR.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Order header ──────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Order #${widget.orderId.substring(0, 8).toUpperCase()}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: MR.textMain)),
                    const SizedBox(height: 4),
                    Text(widget.date, style: MR.caption),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: widget.chipColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(color: widget.chipColor.withOpacity(0.6)),
                  ),
                  child: Text(widget.status,
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: widget.chipColor)),
                ),
              ],
            ),
          ),

          const Divider(height: 1, color: MR.divider),

          // ── Items preview ─────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              children: widget.items.take(2).map((it) {
                final item = it as Map<String, dynamic>;
                final imagePath =
                    item['imageUrl'] ?? item['imagePath'] ?? item['image'];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: MR.surface2,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: MR.divider),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: widget.buildItemImage(imagePath),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item['name'] ?? '',
                                style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: MR.textMain),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                            Text('Qty: ${item['quantity'] ?? 1}',
                                style: MR.caption),
                          ],
                        ),
                      ),
                      Text(
                          '\$${((item['price'] as num?)?.toDouble() ?? 0).toStringAsFixed(2)}',
                          style: MR.price),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          if (widget.items.length > 2)
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 10),
              child: Text('+${widget.items.length - 2} more item(s)',
                  style: const TextStyle(fontSize: 11, color: MR.rose)),
            ),

          // ── Expandable delivery details ────────────────────────────────
          if (widget.delivery != null) ...[
            const Divider(height: 1, color: MR.divider),
            GestureDetector(
              onTap: () => setState(() => _expanded = !_expanded),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: Row(
                  children: [
                    const Icon(Icons.local_shipping_outlined,
                        size: 14, color: MR.textSub),
                    const SizedBox(width: 6),
                    const Text('Delivery Details',
                        style: TextStyle(
                            fontSize: 12,
                            color: MR.textSub,
                            fontWeight: FontWeight.w500)),
                    const Spacer(),
                    Icon(
                        _expanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 16,
                        color: MR.textSub),
                  ],
                ),
              ),
            ),
            if (_expanded)
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: MR.surface2,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: MR.divider),
                  ),
                  child: Column(
                    children: [
                      _DeliveryRow(
                          icon: Icons.person_outline,
                          label: 'Name',
                          value: widget.delivery!['name'] ?? '—'),
                      _DeliveryRow(
                          icon: Icons.phone_outlined,
                          label: 'Phone',
                          value: widget.delivery!['phone'] ?? '—'),
                      _DeliveryRow(
                          icon: Icons.home_outlined,
                          label: 'Address',
                          value: widget.delivery!['address'] ?? '—'),
                      _DeliveryRow(
                          icon: Icons.location_city_outlined,
                          label: 'City',
                          value: widget.delivery!['city'] ?? '—'),
                      _DeliveryRow(
                          icon: Icons.markunread_mailbox_outlined,
                          label: 'Postal',
                          value: widget.delivery!['postalCode'] ?? '—',
                          isLast: true),
                    ],
                  ),
                ),
              ),
          ],

          // ── Total footer ───────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: const BoxDecoration(
              color: MR.surface2,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(14)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Order Total',
                    style: TextStyle(fontSize: 12, color: MR.textSub)),
                Text('\$${widget.total.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: MR.gold)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── _DeliveryRow ──────────────────────────────────────────────────────────────
class _DeliveryRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final bool isLast;

  const _DeliveryRow({
    required this.icon,
    required this.label,
    required this.value,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 8),
      child: Row(
        children: [
          Icon(icon, size: 14, color: MR.rose),
          const SizedBox(width: 8),
          Text('$label: ',
              style: const TextStyle(
                  fontSize: 12,
                  color: MR.textSub,
                  fontWeight: FontWeight.w500)),
          Expanded(
            child: Text(value,
                style: const TextStyle(fontSize: 12, color: MR.textMain),
                overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
