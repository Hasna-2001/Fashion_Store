// lib/screens/checkout.dart
import 'package:flutter/material.dart';
import '../mr_theme.dart';
import '../services/firestore_service.dart';

class CheckoutPage extends StatefulWidget {
  final List<Map<String, dynamic>> selectedItems;
  const CheckoutPage({super.key, required this.selectedItems});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool _placing = false;
  final _formKey = GlobalKey<FormState>();

  // Delivery detail controllers
  final _nameCtrl    = TextEditingController();
  final _phoneCtrl   = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _cityCtrl    = TextEditingController();
  final _postalCtrl  = TextEditingController();

  double get _subtotal => widget.selectedItems.fold(0.0, (sum, item) {
        final price = (item['price'] as num).toDouble();
        final qty   = (item['quantity'] as num).toInt();
        return sum + price * qty;
      });

  static const double _shipping      = 1.0;
  static const double _seasonalOffer = 10.0;
  double get _total => _subtotal + _shipping - _seasonalOffer;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _cityCtrl.dispose();
    _postalCtrl.dispose();
    super.dispose();
  }

  Future<void> _confirmOrder() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _placing = true);

    final deliveryDetails = {
      'name'       : _nameCtrl.text.trim(),
      'phone'      : _phoneCtrl.text.trim(),
      'address'    : _addressCtrl.text.trim(),
      'city'       : _cityCtrl.text.trim(),
      'postalCode' : _postalCtrl.text.trim(),
    };

    await FirestoreService.placeOrder(
        widget.selectedItems, _total, deliveryDetails);
    await FirestoreService.clearCart();

    if (!mounted) return;
    setState(() => _placing = false);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: MR.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: MR.roseFade,
                ),
                child: const Icon(Icons.check_rounded,
                    color: Colors.white, size: 38),
              ),
              const SizedBox(height: 20),
              const Text('Order Confirmed!', style: MR.h2),
              const SizedBox(height: 10),
              const Text(
                'Thank you for your purchase.\nYour order is being processed.',
                style: MR.caption,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: MR.roseFade,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Back to Home',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MR.bg,
      body: SafeArea(
        child: Column(
          children: [
            // ── AppBar ──────────────────────────────────────────────────
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
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: MR.surface2,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: MR.divider),
                      ),
                      child: const Icon(Icons.chevron_left,
                          size: 22, color: MR.textMain),
                    ),
                  ),
                  const Expanded(
                    child: Center(child: Text('Checkout', style: MR.h2)),
                  ),
                  const SizedBox(width: 36),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Delivery Details ──────────────────────────────
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: MR.surface,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: MR.divider),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.local_shipping_outlined,
                                    size: 18, color: MR.rose),
                                SizedBox(width: 8),
                                Text('Delivery Details',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: MR.textMain)),
                              ],
                            ),
                            const SizedBox(height: 16),
                            _FormField(
                              controller: _nameCtrl,
                              label: 'Full Name',
                              hint: 'Enter your full name',
                              icon: Icons.person_outline,
                              validator: (v) =>
                                  (v == null || v.trim().isEmpty)
                                      ? 'Name is required'
                                      : null,
                            ),
                            const SizedBox(height: 12),
                            _FormField(
                              controller: _phoneCtrl,
                              label: 'Phone Number',
                              hint: 'Enter your phone number',
                              icon: Icons.phone_outlined,
                              keyboardType: TextInputType.phone,
                              validator: (v) =>
                                  (v == null || v.trim().isEmpty)
                                      ? 'Phone is required'
                                      : null,
                            ),
                            const SizedBox(height: 12),
                            _FormField(
                              controller: _addressCtrl,
                              label: 'Street Address',
                              hint: 'Enter your street address',
                              icon: Icons.home_outlined,
                              validator: (v) =>
                                  (v == null || v.trim().isEmpty)
                                      ? 'Address is required'
                                      : null,
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Expanded(
                                  child: _FormField(
                                    controller: _cityCtrl,
                                    label: 'City',
                                    hint: 'City',
                                    icon: Icons.location_city_outlined,
                                    validator: (v) =>
                                        (v == null || v.trim().isEmpty)
                                            ? 'Required'
                                            : null,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _FormField(
                                    controller: _postalCtrl,
                                    label: 'Postal Code',
                                    hint: 'Postal Code',
                                    icon: Icons.markunread_mailbox_outlined,
                                    keyboardType: TextInputType.number,
                                    validator: (v) =>
                                        (v == null || v.trim().isEmpty)
                                            ? 'Required'
                                            : null,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // ── Order Items ───────────────────────────────────
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: MR.surface,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: MR.divider),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.shopping_bag_outlined,
                                    size: 18, color: MR.rose),
                                SizedBox(width: 8),
                                Text('Order Items',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: MR.textMain)),
                              ],
                            ),
                            const SizedBox(height: 12),
                            ...widget.selectedItems.map((item) => Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: _OrderItemRow(
                                    imagePath: item['imagePath'] ??
                                        item['image'] ?? '',
                                    brand: item['brand'] ?? 'HS Fashion',
                                    name: item['name'] ?? '',
                                    offer: item['color'] != null
                                        ? 'Color: ${item['color']}'
                                        : 'Special offer',
                                    quantity:
                                        (item['quantity'] as num).toInt(),
                                    price:
                                        (item['price'] as num).toDouble(),
                                  ),
                                )),
                          ],
                        ),
                      ),

                      const SizedBox(height: 16),

                      // ── Order Summary ─────────────────────────────────
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: MR.surface,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: MR.divider),
                        ),
                        child: Column(
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.receipt_outlined,
                                    size: 18, color: MR.rose),
                                SizedBox(width: 8),
                                Text('Order Summary',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: MR.textMain)),
                              ],
                            ),
                            const SizedBox(height: 16),
                            _SummaryRow(
                                label: 'Subtotal',
                                value: '\$${_subtotal.toStringAsFixed(2)}'),
                            const SizedBox(height: 8),
                            _SummaryRow(
                                label: 'Shipping',
                                value: '\$${_shipping.toStringAsFixed(2)}'),
                            const SizedBox(height: 8),
                            _SummaryRow(
                                label: 'Seasonal offer',
                                value:
                                    '-\$${_seasonalOffer.toStringAsFixed(2)}',
                                isDiscount: true),
                            const SizedBox(height: 14),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                              decoration: BoxDecoration(
                                gradient: MR.surfaceFade,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: MR.divider),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Total',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: MR.textMain)),
                                  Text('\$${_total.toStringAsFixed(2)}',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: MR.gold)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),
                    ],
                  ),
                ),
              ),
            ),

            // ── Confirm button ──────────────────────────────────────────
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              decoration: const BoxDecoration(
                color: MR.surface,
                border: Border(top: BorderSide(color: MR.divider)),
              ),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: MR.roseFade,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ElevatedButton(
                    onPressed: _placing ? null : _confirmOrder,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    child: _placing
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2))
                        : const Text('Confirm the Order',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── _FormField ────────────────────────────────────────────────────────────────
class _FormField extends StatelessWidget {
  final TextEditingController controller;
  final String label, hint;
  final IconData icon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const _FormField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(color: MR.textMain, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: MR.textSub, size: 20),
      ),
    );
  }
}

// ── _OrderItemRow ─────────────────────────────────────────────────────────────
class _OrderItemRow extends StatelessWidget {
  final String imagePath, brand, name, offer;
  final int quantity;
  final double price;
  const _OrderItemRow({
    required this.imagePath,
    required this.brand,
    required this.name,
    required this.offer,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: MR.surface2,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: MR.divider),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: imagePath.startsWith('http')
                ? Image.network(imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(
                        Icons.shopping_bag_outlined,
                        color: MR.textSub))
                : Image.asset(imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(
                        Icons.shopping_bag_outlined,
                        color: MR.textSub)),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(brand,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: MR.textMain)),
              Text(name,
                  style:
                      const TextStyle(fontSize: 12, color: MR.textSub)),
              Text(offer,
                  style: const TextStyle(fontSize: 11, color: MR.rose)),
              Text('Qty : ${quantity.toString().padLeft(2, '0')}',
                  style: MR.caption),
            ],
          ),
        ),
        Text('\$${price.toStringAsFixed(2)}', style: MR.price),
      ],
    );
  }
}

// ── _SummaryRow ───────────────────────────────────────────────────────────────
class _SummaryRow extends StatelessWidget {
  final String label, value;
  final bool isDiscount;
  const _SummaryRow(
      {required this.label, required this.value, this.isDiscount = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 13, color: MR.textSub)),
        Text(value,
            style: TextStyle(
                fontSize: 13,
                color:
                    isDiscount ? const Color(0xFF3A8A5C) : MR.textMain,
                fontWeight: FontWeight.w500)),
      ],
    );
  }
}