// lib/screens/profile.dart
import 'package:flutter/material.dart';
import '../mr_theme.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import '../models/wishlist_manager.dart';
import 'login.dart';
import 'orders.dart';
import 'wishlist.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? _profile;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final data = await FirestoreService.getProfile();
    if (mounted) {
      setState(() {
        _profile = data;
        _loading = false;
      });
    }
  }

  String get _displayName =>
      _profile?['name'] as String? ??
      AuthService.currentUser?.displayName ??
      'Fashion Lover';

  String get _displayEmail =>
      _profile?['email'] as String? ?? AuthService.currentUser?.email ?? '';

  String get _displayPhone => _profile?['phone'] as String? ?? '';

  String get _displayAddress => _profile?['address'] as String? ?? '';

  Future<void> _logout() async {
    await AuthService.logout();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => LoginScreen()),
      (route) => false,
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
                      child: Text('My Profile', style: MR.h2),
                    ),
                  ),
                  const Icon(Icons.settings_outlined,
                      size: 22, color: MR.textMain),
                ],
              ),
            ),

            // ── Profile card ────────────────────────────────────────────
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: MR.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: MR.divider),
              ),
              child: _loading
                  ? const Center(
                      child: CircularProgressIndicator(color: MR.rose))
                  : Row(
                      children: [
                        Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: MR.roseFade,
                          ),
                          child: const Icon(Icons.person_outline,
                              size: 36, color: Colors.white),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_displayName,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: MR.textMain)),
                              const SizedBox(height: 4),
                              Text(_displayEmail, style: MR.caption),
                              if (_displayPhone.isNotEmpty) ...[
                                const SizedBox(height: 2),
                                Row(children: [
                                  const Icon(Icons.phone_outlined,
                                      size: 12, color: MR.textSub),
                                  const SizedBox(width: 4),
                                  Text(_displayPhone, style: MR.caption),
                                ]),
                              ],
                              if (_displayAddress.isNotEmpty) ...[
                                const SizedBox(height: 2),
                                Row(children: [
                                  const Icon(Icons.location_on_outlined,
                                      size: 12, color: MR.textSub),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(_displayAddress,
                                        style: MR.caption,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                ]),
                              ],
                              const SizedBox(height: 12),
                              GestureDetector(
                                onTap: _showEditProfile,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 7),
                                  decoration: BoxDecoration(
                                    gradient: MR.roseFade,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: const Text('Edit Profile',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),

            // ── Menu ────────────────────────────────────────────────────
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                decoration: BoxDecoration(
                  color: MR.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: MR.divider),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      _MenuItem(
                        icon: Icons.favorite_border,
                        label: 'Wishlist',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const WishlistPage()),
                        ),
                      ),
                      const _Divider(),
                      _MenuItem(
                        icon: Icons.receipt_long_outlined,
                        label: 'My Orders',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const OrdersScreen()),
                        ),
                      ),
                      const _Divider(),
                      _MenuItem(
                        icon: Icons.location_on_outlined,
                        label: 'Shipping Address',
                        subtitle:
                            _displayAddress.isNotEmpty ? _displayAddress : null,
                        onTap: () => _showEditProfile(focusAddress: true),
                      ),
                      const _Divider(),
                      _MenuItem(
                        icon: Icons.language,
                        label: 'Language',
                        onTap: () {},
                      ),
                      const _Divider(),
                      _MenuItem(
                        icon: Icons.history,
                        label: 'Recently Viewed',
                        onTap: () {},
                      ),
                      const _Divider(),
                      _MenuItem(
                        icon: Icons.delete_outline,
                        label: 'Clear Cache',
                        onTap: () {},
                      ),
                      const _Divider(),
                      _MenuItem(
                        icon: Icons.logout,
                        label: 'Log Out',
                        labelColor: MR.rose,
                        iconColor: MR.rose,
                        onTap: _logout,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text('App Version 2.3',
                  style: TextStyle(
                      fontSize: 11, color: MR.textSub.withOpacity(0.6))),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditProfile({bool focusAddress = false}) {
    final nameCtrl = TextEditingController(text: _displayName);
    final phoneCtrl = TextEditingController(text: _displayPhone);
    final addressCtrl = TextEditingController(text: _displayAddress);

    showModalBottomSheet(
      context: context,
      backgroundColor: MR.surface,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.fromLTRB(
            20, 20, 20, MediaQuery.of(context).viewInsets.bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: MR.divider,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const Text('Edit Profile', style: MR.h2),
            const SizedBox(height: 20),
            _EditField(
              controller: nameCtrl,
              label: 'Full Name',
              hint: 'Enter your full name',
              icon: Icons.person_outline,
            ),
            const SizedBox(height: 12),
            _EditField(
              controller: phoneCtrl,
              label: 'Phone Number',
              hint: 'e.g. +94 77 123 4567',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),
            _EditField(
              controller: addressCtrl,
              label: 'Shipping Address',
              hint: 'Street, City, Country',
              icon: Icons.home_outlined,
              autofocus: focusAddress,
              maxLines: 2,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: MR.roseFade,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    await FirestoreService.saveProfile({
                      'name': nameCtrl.text.trim(),
                      'email': _displayEmail,
                      'phone': phoneCtrl.text.trim(),
                      'address': addressCtrl.text.trim(),
                    });
                    if (!mounted) return;
                    Navigator.pop(ctx);
                    _loadProfile();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Save Changes',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── _EditField ────────────────────────────────────────────────────────────────
class _EditField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType keyboardType;
  final bool autofocus;
  final int maxLines;

  const _EditField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.autofocus = false,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      autofocus: autofocus,
      maxLines: maxLines,
      style: const TextStyle(color: MR.textMain, fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        labelStyle: const TextStyle(color: MR.textSub),
        prefixIcon: Icon(icon, color: MR.textSub, size: 20),
      ),
    );
  }
}

// ── _MenuItem ─────────────────────────────────────────────────────────────────
class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? subtitle;
  final VoidCallback onTap;
  final Color labelColor;
  final Color iconColor;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.subtitle,
    this.labelColor = MR.textMain,
    this.iconColor = MR.textSub,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label,
                      style: TextStyle(fontSize: 14, color: labelColor)),
                  if (subtitle != null && subtitle!.isNotEmpty)
                    Text(subtitle!,
                        style: MR.caption,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Icon(Icons.chevron_right,
                color: MR.textSub.withOpacity(0.5), size: 20),
          ],
        ),
      ),
    );
  }
}

// ── _Divider ──────────────────────────────────────────────────────────────────
class _Divider extends StatelessWidget {
  const _Divider();
  @override
  Widget build(BuildContext context) =>
      const Divider(height: 1, color: MR.divider, indent: 52);
}