// lib/services/firestore_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  static final FirebaseFirestore _db = FirebaseFirestore.instance;
  static final CollectionReference _products = _db.collection('products');

  // ── Auth helper — waits for Firebase Auth to restore session ──────────────
  // On Flutter Web, FirebaseAuth.instance.currentUser is NULL for the first
  // few hundred ms after a page load even when the user IS logged in.
  // This async helper waits up to 5 s for the session to restore.
  static Future<String> _getUid() async {
    // currentUser is null briefly on Flutter Web while session restores.
    // Poll every 500ms for up to 10s before giving up.
    for (int i = 0; i < 20; i++) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) return user.uid;
      await Future.delayed(const Duration(milliseconds: 500));
    }
    throw Exception('NOT_SIGNED_IN');
  }

  static DocumentReference? get _profileDoc {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return null;
    return _db.collection('users').doc(uid);
  }

  // ── Products — streams ────────────────────────────────────────────────────

  static Stream<QuerySnapshot> productsStream() =>
      _products.orderBy('createdAt', descending: true).snapshots();

  static Stream<QuerySnapshot> productsByCategoryStream(String? category) {
    if (category == null || category == 'All') return productsStream();
    return _products
        .where('category', isEqualTo: category)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  static Stream<QuerySnapshot> featuredProductsStream() => _products
      .where('isFeatured', isEqualTo: true)
      .orderBy('createdAt', descending: true)
      .snapshots();

  // ── Products — one-time ───────────────────────────────────────────────────

  static Future<DocumentSnapshot> getProductById(String id) =>
      _products.doc(id).get();

  static Future<List<Map<String, dynamic>>> getProductsByCategory(
      String category) async {
    final snap = category == 'All'
        ? await _products.orderBy('createdAt', descending: true).get()
        : await _products
            .where('category', isEqualTo: category)
            .orderBy('createdAt', descending: true)
            .get();
    return snap.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return {...data, 'id': doc.id};
    }).toList();
  }

  // ── Products — create / update / delete ───────────────────────────────────

  static Future<DocumentReference> addProduct({
    required String name,
    required String description,
    required num price,
    required String category,
    required String imageUrl,
    List<String> thumbnailUrls = const [],
    Map<String, String> colorImages = const {},
    bool isFeatured = false,
    int stock = 0,
    List<String> sizes = const [],
    List<String> colors = const [],
  }) =>
      _products.add({
        'name': name,
        'description': description,
        'price': price,
        'category': category,
        'imageUrl': imageUrl,
        'thumbnailUrls': thumbnailUrls,
        'colorImages': colorImages,
        'isFeatured': isFeatured,
        'stock': stock,
        'sizes': sizes,
        'colors': colors,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });

  static Future<void> updateProduct(String id, Map<String, dynamic> fields) =>
      _products.doc(id).update({
        ...fields,
        'updatedAt': FieldValue.serverTimestamp(),
      });

  static Future<void> updateProductImages(
    String id, {
    String? imageUrl,
    List<String>? thumbnailUrls,
    Map<String, String>? colorImages,
  }) =>
      _products.doc(id).update({
        if (imageUrl != null) 'imageUrl': imageUrl,
        if (thumbnailUrls != null) 'thumbnailUrls': thumbnailUrls,
        if (colorImages != null) 'colorImages': colorImages,
        'updatedAt': FieldValue.serverTimestamp(),
      });

  static Future<void> toggleFeatured(String id, bool isFeatured) =>
      _products.doc(id).update({
        'isFeatured': isFeatured,
        'updatedAt': FieldValue.serverTimestamp(),
      });

  static Future<void> deleteProduct(String id) => _products.doc(id).delete();

  // ── Categories ────────────────────────────────────────────────────────────

  static Future<List<String>> getAvailableCategories() async {
    final snap = await _products.get();
    final categories = snap.docs
        .map((doc) =>
            (doc.data() as Map<String, dynamic>)['category'] as String? ?? '')
        .where((c) => c.isNotEmpty)
        .toSet()
        .toList()
      ..sort();
    return ['All', ...categories];
  }

  // ── Search ────────────────────────────────────────────────────────────────

  static List<Map<String, dynamic>> filterProducts({
    required List<Map<String, dynamic>> products,
    required String query,
    required String selectedCategory,
  }) {
    var result = products;
    if (selectedCategory != 'All') {
      result = result
          .where((p) =>
              (p['category'] as String? ?? '').toLowerCase() ==
              selectedCategory.toLowerCase())
          .toList();
    }
    if (query.isNotEmpty) {
      result = result
          .where((p) => (p['name'] as String? ?? '')
              .toLowerCase()
              .contains(query.toLowerCase()))
          .toList();
    }
    return result;
  }

  // ── Cart ──────────────────────────────────────────────────────────────────

  /// Live stream of cart items. Returns empty stream if not signed in.
  static Stream<QuerySnapshot> cartStream() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return const Stream.empty();
    return _db
        .collection('users')
        .doc(uid)
        .collection('cart')
        .orderBy('addedAt', descending: true)
        .snapshots();
  }

  /// Add item to cart — waits for auth session to restore on web before writing.
  static Future<DocumentReference> addToCart(Map<String, dynamic> item) async {
    final uid = await _getUid();
    return _db.collection('users').doc(uid).collection('cart').add({
      ...item,
      'quantity': (item['quantity'] as int?) ?? 1,
      'isSelected': (item['isSelected'] as bool?) ?? true,
      'addedAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> updateCartQuantity(String docId, int qty) async {
    final uid = await _getUid();
    final ref = _db.collection('users').doc(uid).collection('cart').doc(docId);
    if (qty <= 0) {
      await ref.delete();
    } else {
      await ref.update({'quantity': qty});
    }
  }

  static Future<void> updateCartSelected(String docId, bool isSelected) async {
    final uid = await _getUid();
    await _db
        .collection('users')
        .doc(uid)
        .collection('cart')
        .doc(docId)
        .update({'isSelected': isSelected});
  }

  static Future<void> removeFromCart(String docId) async {
    final uid = await _getUid();
    await _db
        .collection('users')
        .doc(uid)
        .collection('cart')
        .doc(docId)
        .delete();
  }

  static Future<void> clearCart() async {
    final uid = await _getUid();
    final col = _db.collection('users').doc(uid).collection('cart');
    final snap = await col.get();
    final batch = _db.batch();
    for (final doc in snap.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }

  // ── Orders ────────────────────────────────────────────────────────────────

  static Stream<QuerySnapshot> ordersStream() {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return const Stream.empty();
    return _db
        .collection('users')
        .doc(uid)
        .collection('orders')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  static Future<DocumentReference> placeOrder(
    List<Map<String, dynamic>> selectedItems,
    double total,
    Map<String, dynamic> deliveryDetails,
  ) async {
    final uid = await _getUid();
    return _db.collection('users').doc(uid).collection('orders').add({
      'items': selectedItems,
      'total': total,
      'deliveryDetails': deliveryDetails,
      'status': 'Processing',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  static Future<void> updateOrderStatus(String orderId, String status) async {
    final uid = await _getUid();
    await _db
        .collection('users')
        .doc(uid)
        .collection('orders')
        .doc(orderId)
        .update({'status': status});
  }

  // ── User Profile ──────────────────────────────────────────────────────────

  static Future<Map<String, dynamic>?> getProfile() async {
    final doc = _profileDoc;
    if (doc == null) return null;
    final snap = await doc.get();
    if (!snap.exists) return null;
    return snap.data() as Map<String, dynamic>?;
  }

  static Future<void> saveProfile(Map<String, dynamic> data) async {
    final doc = _profileDoc;
    if (doc == null) return;
    await doc.set({
      ...data,
      'uid': FirebaseAuth.instance.currentUser?.uid ?? '',
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}
