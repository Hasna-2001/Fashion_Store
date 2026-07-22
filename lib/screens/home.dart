import 'package:flutter/material.dart';
import '../mr_theme.dart';
import 'product_list.dart';
import 'product_details.dart';
import 'cart.dart';
import 'profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // ── Asset image helper ────────────────────────────────────────────────────
  Widget _assetImg(String path, {BoxFit fit = BoxFit.cover}) {
    if (path.isEmpty) return Container(color: MR.surface2);
    return Image.asset(
      path,
      fit: fit,
      errorBuilder: (_, __, ___) => Container(
        color: MR.surface2,
        child: const Center(
            child: Icon(Icons.shopping_bag_outlined, color: MR.textSub)),
      ),
    );
  }

  final List<Map<String, String>> _categories = [
    {
      'label': 'Bridal',
      'image': 'lib/assets/bridal1.webp',
    },
    {
      'label': 'Accessories',
      'image': 'lib/assets/j1.webp',
    },
    {
      'label': 'Casual Sneakers',
      'image': 'lib/assets/sh1.jpg',
    },
    {
      'label': 'Sunglasses',
      'image': 'lib/assets/sun1.jpg',
    },
    {
      'label': 'Silk Scarf',
      'image': 'lib/assets/sc1.jpg',
    },
    {
      'label': 'Hand Bag',
      'image': 'lib/assets/hb1.jpg',
    },
    {
      'label': 'Men Official',
      'image': 'lib/assets/om1.jpg',
    },
    {
      'label': 'Official Wear',
      'image': 'lib/assets/of1.jpg',
    },
    {
      'label': 'Ladies Heels',
      'image': 'lib/assets/h12.jpg',
    },
  ];

  final List<Map<String, String>> _banners = [
    {
      'tag': 'New Arrivals',
      'title': 'Spring\nCollection',
      'sub': 'Up to 40% off',
      'image': 'lib/assets/bridal4.webp',
    },
    {
      'tag': 'Limited Time',
      'title': 'Bridal\nSpecials',
      'sub': 'Exclusive bridal looks',
      'image': 'lib/assets/bridal4.webp',
    },
    {
      'tag': 'Trending',
      'title': "Men's\nCollection",
      'sub': 'Fresh formal styles',
      'image': 'lib/assets/om5.jpg',
    },
  ];

  final List<Map<String, dynamic>> _onSaleProducts = [
    {
      'id': 'sale1',
      'name': '11.11 Bridal Sale',
      'description': 'Limited time offer on bridal gown',
      'price': 120.0,
      'discount': '30% OFF',
      'category': 'Bridal',
      'colors': ['Red', 'Maroon', 'Gold'],
      'sizes': ['XS', 'S', 'M', 'L'],
      'imagePath': 'lib/assets/bridal2.webp',
    },
    {
      'id': 'sale2',
      'name': "Men's Formal Shirt Sale",
      'description': 'Slim-fit formal shirt at flash price.',
      'price': 18.0,
      'discount': '20% OFF',
      'category': 'Men Official',
      'colors': ['Light Blue', 'White', 'Navy'],
      'sizes': ['S', 'M', 'L', 'XL'],
      'imagePath': 'lib/assets/om1.jpg',
    },
    {
      'id': 'sale3',
      'name': 'Flash Deal Sneakers',
      'description': 'Exclusive sneaker discount.',
      'price': 30.0,
      'discount': '40% OFF',
      'category': 'Casual Sneakers',
      'colors': ['White', 'Black', 'Red'],
      'sizes': ['40', '41', '42', '43', '44'],
      'imagePath': 'lib/assets/sh1.jpg'
    },
    {
      'id': 'sale4',
      'name': 'Embroidered Rose Silk Scarf',
      'description': 'Luxurious hand-embroidered mulberry silk scarf.',
      'price': 15.0,
      'discount': '15% OFF',
      'category': 'Silk Scarf',
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/sc1.jpg',
    },
  ];

  final List<Map<String, dynamic>> _popularProducts = [
    {
      'id': 'pop1',
      'name': 'Luxury Bridal Lehenga',
      'description': 'Heavy zari & dabka work on raw silk — barat showstopper',
      'price': 420.00,
      'category': 'Bridal',
      'sizes': ['XS', 'S', 'M', 'L'],
      'imagePath': 'lib/assets/bridal2.webp',
    },
    {
      'id': 'pop2',
      'name': 'Party Wear Jumka ',
      'description': 'Premium Accessories',
      'price': 89.99,
      'category': 'Jumka',
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/j1.webp'
    },
    {
      'id': 'pop3',
      'name': 'fashianable heals',
      'description': 'part wear heals',
      'price': 45.00,
      'category': 'part wear',
      'sizes': ['40', '41', '42', '43', '44'],
      'imagePath': 'lib/assets/h2.webp',
    },
    {
      'id': 'pop4',
      'name': 'Classic Aviator Sunglasses',
      'description': 'Trendy UV400 aviator shades',
      'price': 29.99,
      'category': 'Sunglasses',
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/sun4.jpg',
    },
    {
      'id': 'pop5',
      'name': ' Silk Scarf',
      'description': 'Luxurious 100% mulberry silk floral wrap',
      'price': 24.99,
      'category': 'Silk Scarf',
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/sc1.jpg',
    },
    {
      'id': 'pop6',
      'name': 'Genuine Leather Tote Bag',
      'description': 'Spacious full-grain leather tote bag',
      'price': 89.99,
      'category': 'Hand Bag',
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/hb2.jpg',
    },
    {
      'id': 'pop7',
      'name': 'Official Men Wear',
      'description': 'Official Men Wear',
      'price': 32.00,
      'category': 'Men Official',
      'sizes': ['S', 'M', 'L', 'XL', 'XXL'],
      'imagePath': 'lib/assets/om2.jpg',
    },
    {
      'id': 'pop8',
      'name': 'Professional womens',
      'description': 'Lightweight blazer — office-ready yet breathable',
      'price': 75.00,
      'category': 'Official Wear',
      'sizes': ['XS', 'S', 'M', 'L', 'XL'],
      'imagePath': 'lib/assets/of1.webp',
    },
    {
      'id': 'pop9',
      'name': 'Strappy Heels',
      'description': 'Open-toe strappy sandal heels — party favourite',
      'price': 72.00,
      'category': 'Ladies Heels',
      'sizes': ['36', '37', '38', '39', '40'],
      'imagePath': 'lib/assets/h4.webp',
    },
    {
      'id': 'pop10',
      'name': 'Luxury Bridal Lehenga',
      'description': 'Heavy zari & dabka work on raw silk — barat showstopper',
      'price': 420.00,
      'category': 'Bridal',
      'sizes': ['XS', 'S', 'M', 'L'],
      'imagePath': 'lib/assets/bridal7.webp',
    },
    {
      'id': 'pop11',
      'name': 'Strappy Heels',
      'description': 'strappy sandal heels — party favourite',
      'price': 72.00,
      'category': 'Ladies Heels',
      'sizes': ['36', '37', '38', '39', '40'],
      'imagePath': 'lib/assets/h12.jpg',
    },
    {
      'id': 'pop12',
      'name': 'Luxury Bridal Lehenga',
      'description': 'Heavy zari & dabka work on raw silk — barat showstopper',
      'price': 420.00,
      'category': 'Bridal',
      'sizes': ['XS', 'S', 'M', 'L'],
      'imagePath': 'lib/assets/bridal8.webp',
    },
    {
      'id': 'pop13',
      'name': 'Strappy Heels',
      'description': 'strappy sandal heels — party favourite',
      'price': 72.00,
      'category': 'Ladies Heels',
      'sizes': ['36', '37', '38', '39', '40'],
      'imagePath': 'lib/assets/h11.jpg',
    },
    {
      'id': 'pop14',
      'name': 'Luxury Bridal Lehenga',
      'description': 'Heavy zari & dabka work on raw silk — barat showstopper',
      'price': 420.00,
      'category': 'Bridal',
      'sizes': ['XS', 'S', 'M', 'L'],
      'imagePath': 'lib/assets/bridal5.webp',
    },
    {
      'id': 'pop15',
      'name': 'Make-up-Kit',
      'description': 'Make up kit',
      'price': 42.00,
      'category': 'Accessories',
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/make2.jpg',
    },
    {
      'id': 'pop16',
      'name': 'Genuine Leather Tote Bag',
      'description': 'Spacious full-grain leather tote bag',
      'price': 89.99,
      'category': 'Hand Bag',
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/hb10.jpg',
    },
    {
      'id': 'pop17',
      'name': 'Party Wear Jumka ',
      'description': 'Premium Accessories',
      'price': 89.99,
      'category': 'Jumka',
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/j4.webp'
    },
    {
      'id': 'pop18',
      'name': 'Official Men Wear',
      'description': 'Official Men Wear',
      'price': 32.00,
      'category': 'Men Official',
      'sizes': ['S', 'M', 'L', 'XL', 'XXL'],
      'imagePath': 'lib/assets/om4.jpg',
    },
    {
      'id': 'pop19',
      'name': 'Party Wear Jumka ',
      'description': 'Premium Accessories',
      'price': 79.99,
      'category': 'Jumka',
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/j2.jpeg'
    },
    {
      'id': 'pop20',
      'name': 'Party Wear Jumka ',
      'description': 'Premium Accessories',
      'price': 89.99,
      'category': 'Jumka',
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/j2.webp'
    },
    {
      'id': 'pop21',
      'name': 'Luxury Bridal Lehenga',
      'description': 'Heavy zari & dabka work on raw silk — barat showstopper',
      'price': 420.00,
      'category': 'Bridal',
      'sizes': ['XS', 'S', 'M', 'L'],
      'imagePath': 'lib/assets/bridal6.webp',
    },
    {
      'id': 'pop22',
      'name': 'Professional womens',
      'description': 'Lightweight blazer — office-ready yet breathable',
      'price': 75.00,
      'category': 'Official Wear',
      'sizes': ['XS', 'S', 'M', 'L', 'XL'],
      'imagePath': 'lib/assets/of3.jpg',
    },
  ];

  int _bannerIndex = 0;
  late final PageController _bannerCtrl = PageController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _bannerCtrl.dispose();
    super.dispose();
  }

  void _onNavTap(int index) {
    switch (index) {
      case 0:
        setState(() => _selectedIndex = 0);
        break;
      case 1:
        _openProductList();
        break;
      case 2:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const CartPage()));
        break;
      case 3:
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const ProfilePage()));
        break;
    }
  }

  void _openProductList([String? category]) => Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => ProductListPage(initialCategory: category)));

  void _openDetails(Map<String, dynamic> product) => Navigator.push(context,
      MaterialPageRoute(builder: (_) => ProductDetailsPage(product: product)));

  Widget _drawerItem(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: MR.rose, size: 22),
      title: Text(label,
          style: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w500, color: MR.textMain)),
      dense: true,
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: MR.bg,
      drawer: Drawer(
        backgroundColor: MR.bg,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Drawer Header ──────────────────────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFB5451B), Color(0xFFE8956D)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.storefront_rounded,
                        color: Colors.white, size: 36),
                    const SizedBox(height: 10),
                    const Text('HS Fashion Store',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5)),
                    const SizedBox(height: 4),
                    Text('Style that speaks',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 12)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // ── Nav Items ──────────────────────────────────────────────
              _drawerItem(
                icon: Icons.home_outlined,
                label: 'Home',
                onTap: () {
                  Navigator.pop(context);
                  setState(() => _selectedIndex = 0);
                },
              ),
              _drawerItem(
                icon: Icons.grid_view_outlined,
                label: 'Products',
                onTap: () {
                  Navigator.pop(context);
                  _openProductList();
                },
              ),
              _drawerItem(
                icon: Icons.shopping_cart_outlined,
                label: 'Cart',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const CartPage()));
                },
              ),
              _drawerItem(
                icon: Icons.person_outline,
                label: 'Profile',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => const ProfilePage()));
                },
              ),
              const Divider(
                  color: Color(0xFFEAE0D5), indent: 16, endIndent: 16),
              // ── Categories ─────────────────────────────────────────────
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
                child: Text('Categories',
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: MR.textSub,
                        letterSpacing: 1.1)),
              ),
              ..._categories.map((c) => _drawerItem(
                    icon: Icons.label_outline_rounded,
                    label: c['label']!,
                    onTap: () {
                      Navigator.pop(context);
                      _openProductList(c['label']);
                    },
                  )),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(builder: (context, constraints) {
          final w = constraints.maxWidth;
          final hPad = w >= 800 ? 24.0 : 16.0;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: MR.bg,
                elevation: 0,
                floating: true,
                snap: true,
                titleSpacing: hPad,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: GestureDetector(
                    onTap: () => _scaffoldKey.currentState?.openDrawer(),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: MR.surface2,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: MR.divider),
                      ),
                      child: const Icon(Icons.menu_rounded,
                          color: MR.textMain, size: 20),
                    ),
                  ),
                ),
                title: ShaderMask(
                  shaderCallback: (b) => MR.roseFade.createShader(b),
                  child: const Text('HS Fashion Store',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 0.5)),
                ),
                centerTitle: true,
                actions: [
                  GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const CartPage())),
                    child: Container(
                      margin:
                          const EdgeInsets.only(right: 8, top: 10, bottom: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: MR.surface2,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: MR.divider),
                      ),
                      child: const Icon(Icons.shopping_bag_outlined,
                          color: MR.textMain, size: 20),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const ProfilePage())),
                    child: Container(
                      margin:
                          const EdgeInsets.only(right: 16, top: 10, bottom: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: MR.surface2,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: MR.divider),
                      ),
                      child: const Icon(Icons.person_outline,
                          color: MR.textMain, size: 20),
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Hero Banner ──────────────────────────────────────
                    const SizedBox(height: 12),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: hPad),
                      child: SizedBox(
                        height: 180,
                        child: PageView.builder(
                          controller: _bannerCtrl,
                          itemCount: _banners.length,
                          onPageChanged: (i) =>
                              setState(() => _bannerIndex = i),
                          itemBuilder: (_, i) {
                            final b = _banners[i];
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  _assetImg(b['image']!), // ← asset image
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.black.withOpacity(0.55),
                                          Colors.transparent,
                                        ],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(18),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: MR.rose,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Text(b['tag']!,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(b['title']!,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                height: 1.2)),
                                        const SizedBox(height: 4),
                                        Text(b['sub']!,
                                            style: TextStyle(
                                                color: Colors.white
                                                    .withOpacity(0.85),
                                                fontSize: 13)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _banners.length,
                        (i) => AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: _bannerIndex == i ? 16 : 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: _bannerIndex == i ? MR.rose : MR.divider,
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    ),

                    // ── Categories ───────────────────────────────────────
                    const SizedBox(height: 22),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: hPad),
                      child: const Text('Categories',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: MR.textMain)),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 90,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: hPad),
                        itemCount: _categories.length,
                        itemBuilder: (_, i) {
                          final cat = _categories[i];
                          return GestureDetector(
                            onTap: () => _openProductList(cat['label']),
                            child: Container(
                              margin: const EdgeInsets.only(right: 12),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: SizedBox(
                                      width: 60,
                                      height: 60,
                                      child: _assetImg(
                                          cat['image']!), // ← asset image
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(cat['label']!,
                                      style: const TextStyle(
                                          fontSize: 11,
                                          color: MR.textSub,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // ── On Sale ──────────────────────────────────────────
                    const SizedBox(height: 22),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: hPad),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('On Sale',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: MR.textMain)),
                          GestureDetector(
                            onTap: _openProductList,
                            child: const Text('See All',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: MR.rose,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      height: 210,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: hPad),
                        itemCount: _onSaleProducts.length,
                        itemBuilder: (_, i) {
                          final p = _onSaleProducts[i];
                          return GestureDetector(
                            onTap: () => _openDetails(p),
                            child: Container(
                              width: 150,
                              margin: const EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                color: MR.surface,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: MR.divider),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Stack(children: [
                                      ClipRRect(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                top: Radius.circular(14)),
                                        child: SizedBox.expand(
                                          child: _assetImg(p['imagePath']
                                              as String), // ← asset
                                        ),
                                      ),
                                      Positioned(
                                        top: 8,
                                        left: 8,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 3),
                                          decoration: BoxDecoration(
                                            color: MR.rose,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          child: Text(p['discount'] as String,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                    ]),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 6, 8, 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(p['name'] as String,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: MR.textMain)),
                                        const SizedBox(height: 2),
                                        Text(
                                            '\$${(p['price'] as double).toStringAsFixed(0)}',
                                            style: MR.price),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    // ── Popular ─────────────────────────────────────────
                    const SizedBox(height: 22),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: hPad),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Popular',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: MR.textMain)),
                          GestureDetector(
                            onTap: _openProductList,
                            child: const Text('See All',
                                style: TextStyle(
                                    fontSize: 13,
                                    color: MR.rose,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: hPad),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _popularProducts.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.72,
                        ),
                        itemBuilder: (_, i) {
                          final p = _popularProducts[i];
                          return GestureDetector(
                            onTap: () => _openDetails(p),
                            child: Container(
                              decoration: BoxDecoration(
                                color: MR.surface,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: MR.divider),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(14)),
                                      child: SizedBox.expand(
                                        child: _assetImg(p['imagePath']
                                            as String), // ← asset
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 8, 10, 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(p['name'] as String,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                                color: MR.textMain)),
                                        const SizedBox(height: 4),
                                        Text(
                                            '\$${(p['price'] as double).toStringAsFixed(2)}',
                                            style: MR.price),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: MR.surface,
        selectedItemColor: MR.rose,
        unselectedItemColor: MR.textSub,
        currentIndex: _selectedIndex,
        onTap: _onNavTap,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_outlined), label: 'Products'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
