// lib/services/recently_viewed_service.dart
//
// Saves recently viewed products to Firestore under:
//   users/{uid}/recentlyViewed/{productId}
//
// - Max 20 items stored (oldest auto-deleted)
// - Calling track() on same product just updates the timestamp (no duplicates)
//
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecentlyViewedService {
  static final _db = FirebaseFirestore.instance;
  static const int _maxItems = 20;

  /// Waits for Firebase Auth session to restore (fixes Flutter Web timing bug)
  static Future<String?> _getUid() async {
    for (int i = 0; i < 20; i++) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) return user.uid;
      await Future.delayed(const Duration(milliseconds: 500));
    }
    return null;
  }

  static CollectionReference? _colForUid(String uid) =>
      _db.collection('users').doc(uid).collection('recentlyViewed');

  static CollectionReference? get _col {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return null;
    return _colForUid(uid);
  }

  /// Call this when a product page is opened.
  static Future<void> track(Map<String, dynamic> product) async {
    final uid = await _getUid();
    if (uid == null) return;
    final col = _colForUid(uid)!;

    final productId = product['id']?.toString() ?? '';
    if (productId.isEmpty) return;

    await col.doc(productId).set({
      'productId': productId,
      'name': product['name'] ?? '',
      'price': product['price'] ?? 0,
      'imageUrl': product['imageUrl'] ?? product['imagePath'] ?? '',
      'category': product['category'] ?? '',
      'viewedAt': FieldValue.serverTimestamp(),
    });

    // Keep only the latest _maxItems — delete oldest if over limit
    final snap = await col.orderBy('viewedAt', descending: true).get();
    if (snap.docs.length > _maxItems) {
      final toDelete = snap.docs.sublist(_maxItems);
      final batch = _db.batch();
      for (final doc in toDelete) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    }
  }

  /// Stream of recently viewed products, newest first.
  /// Uses authStateChanges so it works on Flutter Web where currentUser
  /// is null briefly after page load.
  static Stream<QuerySnapshot> stream() {
    return FirebaseAuth.instance.authStateChanges().asyncExpand((user) {
      if (user == null) return const Stream.empty();
      return _db
          .collection('users')
          .doc(user.uid)
          .collection('recentlyViewed')
          .orderBy('viewedAt', descending: true)
          .snapshots();
    });
  }

  /// Clear all recently viewed.
  static Future<void> clearAll() async {
    final uid = await _getUid();
    if (uid == null) return;
    final col = _colForUid(uid)!;
    final snap = await col.get();
    final batch = _db.batch();
    for (final doc in snap.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}
