import 'package:flutter/material.dart';
import '../mr_theme.dart';
import 'product_details.dart';
import 'checkout.dart';
import '../services/firestore_service.dart';
import '../models/wishlist_manager.dart';

class ProductListPage extends StatefulWidget {
  final String? initialCategory;
  const ProductListPage({super.key, this.initialCategory});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';
  String _selectedCategory = 'All';
  final _wl = WishlistManager();

  late AnimationController _fadeController;
  late Animation<double> _fadeAnim;

  static const List<String> _categories = [
    'All',
    'Bridal',
    'Accessories',
    'Casual Sneakers',
    'Sunglasses',
    'Silk Scarf',
    'Hand Bag',
    'Men Official',
    'Official Wear',
    'Ladies Heels',
  ];

  static const Map<String, IconData> _categoryIcons = {
    'All': Icons.apps_rounded,
    'Bridal': Icons.favorite_border,
    'Accessories': Icons.face_retouching_natural,
    'Casual Sneakers': Icons.directions_walk_outlined,
    'Sunglasses': Icons.wb_sunny_outlined,
    'Silk Scarf': Icons.style_outlined,
    'Hand Bag': Icons.shopping_bag_outlined,
    'Men Official': Icons.checkroom_outlined,
    'Official Wear': Icons.celebration_outlined,
    'Ladies Heels': Icons.female_outlined,
  };

  static final List<Map<String, dynamic>> _allProducts = [
    // ══════════════════════════════════════════════════════════════════════════
    // BRIDAL (10)
    // ══════════════════════════════════════════════════════════════════════════
    {
      'id': 'b1',
      'name': 'Bridal Frock',
      'category': 'Bridal',
      'price': 399.99,
      'description':
          'Stunning embroidered Pakistani wedding frock with heavy bridal work',
      'sizes': ['XS', 'S', 'M', 'L'],
      'imagePath': 'lib/assets/bridal-red.webp',
    },
    {
      'id': 'b2',
      'name': 'Pakistani Bridal Lehenga',
      'category': 'Bridal',
      'price': 349.00,
      'description':
          'Luxurious Pakistani bridal lehenga with intricate embroidery',
      'sizes': ['XS', 'S', 'M', 'L', 'XL'],
      'imagePath': 'lib/assets/bridal4.webp',
    },
    {
      'id': 'b3',
      'name': 'Walima Bridal Outfit',
      'category': 'Bridal',
      'price': 475.00,
      'description':
          'Elegant walima bridal dress with delicate hand embroidery',
      'sizes': ['S', 'M', 'L'],
      'imagePath': 'lib/assets/bridal3.webp',
    },
    {
      'id': 'b4',
      'name': 'Heavy Zari Bridal Gown',
      'category': 'Bridal',
      'price': 420.00,
      'description': 'Heavy zari & dabka work bridal gown — barat showstopper',
      'sizes': ['XS', 'S', 'M'],
      'imagePath': 'lib/assets/bridal-pink.webp',
    },
    {
      'id': 'b5',
      'name': 'Kundan Bridal Set',
      'category': 'Bridal',
      'price': 390.00,
      'description':
          'Opulent bridal dress with kundan stonework and matching dupatta',
      'sizes': ['S', 'M', 'L', 'XL'],
      'imagePath': 'lib/assets/bridal4.webp',
    },
    {
      'id': 'b6',
      'name': 'Classic Bridal Gown',
      'category': 'Bridal',
      'price': 399.00,
      'description': 'Timeless white Western bridal gown with lace detailing',
      'sizes': ['XS', 'S', 'M', 'L'],
      'imagePath': 'lib/assets/bridal5.webp',
    },
    {
      'id': 'b7',
      'name': 'Bridal Gown',
      'category': 'Bridal',
      'price': 355.00,
      'description': 'Sparkling crystal bridal',
      'sizes': ['S', 'M', 'L', 'XL'],
      'imagePath': 'lib/assets/bridal6.webp',
    },
    {
      'id': 'b8',
      'name': 'Bridal Gowns',
      'category': 'Bridal',
      'price': 420.00,
      'description': 'Elegant Gowns for brides',
      'sizes': ['S', 'M', 'L', 'XL'],
      'imagePath': 'lib/assets/bridal7.webp',
    },
    {
      'id': 'b9',
      'name': 'Bridal Gown with Dupatta',
      'category': 'Bridal',
      'price': 475.00,
      'description': 'Elegant Bridal Gown',
      'sizes': ['XS', 'S', 'M', 'L'],
      'imagePath': 'lib/assets/bridal8.webp',
    },
    {
      'id': 'b10',
      'name': 'Bridal Dress',
      'category': 'Bridal',
      'price': 345.00,
      'description': 'Beautiful Dress for brides',
      'colors': ['White', 'Ivory'],
      'sizes': ['XS', 'S', 'M', 'L'],
      'imagePath': 'lib/assets/bridal9.webp',
    },

    // ══════════════════════════════════════════════════════════════════════════
    // ACCESSORIES (10)
    // ══════════════════════════════════════════════════════════════════════════
    {
      'id': 'm1',
      'name': 'Premium Jumka',
      'category': 'Accessories',
      'price': 89.99,
      'description': 'Premium jumka',
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/j1.webp',
    },
    {
      'id': 'm2',
      'name': 'Lipstick',
      'category': 'Accessories',
      'price': 24.99,
      'description': 'Long-lasting Lipstick',
      'colors': ['Light'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/make3.jpg',
    },
    {
      'id': 'm3',
      'name': 'Lipstick Collection',
      'category': 'Accessories',
      'price': 24.99,
      'description': 'Set of 6 long-lasting lipsticks',
      'colors': ['Pink'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/make4.png',
    },
    {
      'id': 'm4',
      'name': 'Palette',
      'category': 'Accessories',
      'price': 29.99,
      'description': 'Palette',
      'colors': ['Neutral'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/make2.jpg',
    },
    {
      'id': 'm5',
      'name': 'Elegant Jumkha',
      'category': 'Accessories',
      'price': 19.99,
      'description': 'Elegant party wear',
      'colors': ['Pink'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/j2.jpeg',
    },
    {
      'id': 'm6',
      'name': 'Premium Silver Jumka',
      'category': 'Accessories',
      'price': 18.50,
      'description': 'Elegant Jumka',
      'colors': ['Silver'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/j2.webp',
    },
    {
      'id': 'm7',
      'name': 'Simple Jumka',
      'category': 'Accessories',
      'price': 12.99,
      'description': 'Simple premium look jumkha',
      'colors': ['Maroon'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/j3.jpg',
    },
    {
      'id': 'm8',
      'name': 'Cream',
      'category': 'Accessories',
      'price': 14.99,
      'description': 'Long-lasting makeup cream',
      'colors': ['Natural', 'Dewy', 'Matte'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/make9.jpg',
    },
    {
      'id': 'm9',
      'name': 'Colourful Jumkha',
      'category': 'Accessories',
      'price': 19.99,
      'description': 'Multi Colour Jumka with beads',
      'colors': ['Rose Gold'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/j4.webp',
    },
    {
      'id': 'm10',
      'name': 'Primer',
      'category': 'Accessories',
      'price': 7.99,
      'description': 'Pore-minimizing face primer for flawless look',
      'colors': ['Natural'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/make10.jpg',
    },

    // ══════════════════════════════════════════════════════════════════════════
    // CASUAL SNEAKERS (10)
    // ══════════════════════════════════════════════════════════════════════════
    {
      'id': 's1',
      'name': 'Classic Black Sneakers',
      'category': 'Casual Sneakers',
      'price': 45.00,
      'description': 'Clean classic Black everyday sneakers',
      'colors': ['White'],
      'sizes': ['40', '41', '42', '43', '44'],
      'imagePath': 'lib/assets/sh1.jpg',
    },
    {
      'id': 's2',
      'name': 'Running Sneakers',
      'category': 'Casual Sneakers',
      'price': 65.00,
      'description': 'Lightweight breathable running shoes',
      'colors': ['Orange'],
      'sizes': ['39', '40', '41', '42', '43', '44'],
      'imagePath': 'lib/assets/sh6.jpg',
    },
    {
      'id': 's3',
      'name': 'Hi-Top Sneakers',
      'category': 'Casual Sneakers',
      'price': 72.00,
      'description': 'Stylish high-top canvas sneakers',
      'colors': ['Navy'],
      'sizes': ['40', '41', '42', '43', '44', '45'],
      'imagePath': 'lib/assets/sh7.jpg',
    },
    {
      'id': 's4',
      'name': 'Slip-On Sneakers',
      'category': 'Casual Sneakers',
      'price': 68.00,
      'description': 'Comfortable laceless slip-on sneakers',
      'colors': ['Grey'],
      'sizes': ['37', '38', '39', '40', '41', '42'],
      'imagePath': 'lib/assets/sh-silver.jpg',
    },
    {
      'id': 's5',
      'name': 'Platform Sneakers',
      'category': 'Casual Sneakers',
      'price': 82.00,
      'description': 'Chunky platform sole sneakers',
      'colors': ['Black'],
      'sizes': ['36', '37', '38', '39', '40', '41'],
      'imagePath': 'lib/assets/sh-black.jpg',
    },
    {
      'id': 's6',
      'name': 'Retro Sneakers',
      'category': 'Casual Sneakers',
      'price': 58.00,
      'description': 'Vintage inspired retro trainers',
      'colors': ['White/Gold'],
      'sizes': ['40', '41', '42', '43', '44'],
      'imagePath': 'lib/assets/sh3.jpg',
    },
    {
      'id': 's7',
      'name': 'Knit Sneakers',
      'category': 'Casual Sneakers',
      'price': 55.00,
      'description': 'Sock-like knit upper sneakers',
      'colors': ['Brown'],
      'sizes': ['38', '39', '40', '41', '42', '43'],
      'imagePath': 'lib/assets/sh5.jpg',
    },
    {
      'id': 's8',
      'name': 'Suede Sneakers',
      'category': 'Casual Sneakers',
      'price': 68.00,
      'description': 'Premium suede casual sneakers',
      'colors': ['Tan'],
      'sizes': ['38', '39', '40', '41', '42', '43', '44'],
      'imagePath': 'lib/assets/sh4.jpg',
    },
    {
      'id': 's9',
      'name': 'Chunky Sneakers',
      'category': 'Casual Sneakers',
      'price': 88.00,
      'description': 'Bold chunky dad-style sneakers',
      'colors': ['Multi'],
      'sizes': ['39', '40', '41', '42', '43'],
      'imagePath': 'lib/assets/sh9.jpg',
    },
    {
      'id': 's10',
      'name': 'Canvas Low-Tops',
      'category': 'Casual Sneakers',
      'price': 32.00,
      'description': 'Everyday canvas low-top sneakers',
      'colors': ['Navy'],
      'sizes': ['37', '38', '39', '40', '41', '42'],
      'imagePath': 'lib/assets/sh-blue.jpg',
    },

    // ══════════════════════════════════════════════════════════════════════════
    // SUNGLASSES (10)
    // ══════════════════════════════════════════════════════════════════════════
    {
      'id': 'sg1',
      'name': 'Aviator Sunglasses',
      'category': 'Sunglasses',
      'price': 29.99,
      'description': 'Timeless aviator sunglasses',
      'colors': ['Black'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/sun1.jpg',
    },
    {
      'id': 'sg2',
      'name': 'Cat Eye Shades',
      'category': 'Sunglasses',
      'price': 24.99,
      'description': 'Retro cat-eye sunglasses',
      'colors': ['Black'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/sun2.jpg',
    },
    {
      'id': 'sg3',
      'name': 'Round Sunglasses',
      'category': 'Sunglasses',
      'price': 19.99,
      'description': 'Boho round frame sunglasses',
      'colors': ['Black'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/sun3.jpg',
    },
    {
      'id': 'sg4',
      'name': 'Oversized Shades',
      'category': 'Sunglasses',
      'price': 34.99,
      'description': 'Glamorous oversized sunglasses',
      'colors': ['Green'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/sun4.jpg',
    },
    {
      'id': 'sg5',
      'name': 'Sport Sunglasses',
      'category': 'Sunglasses',
      'price': 42.00,
      'description': 'Wraparound UV400 sports sunglasses',
      'colors': ['Black'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/sun5.jpg',
    },
    {
      'id': 'sg6',
      'name': 'Mirrored Shades',
      'category': 'Sunglasses',
      'price': 22.00,
      'description': 'Trendy mirrored lens sunglasses',
      'colors': ['Black'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/sun6.jpg',
    },
    {
      'id': 'sg7',
      'name': 'Square Frame',
      'category': 'Sunglasses',
      'price': 27.50,
      'description': 'Modern square frame sunglasses',
      'colors': ['Black'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/sun7.jpg',
    },
    {
      'id': 'sg8',
      'name': 'Vintage Wayfarers',
      'category': 'Sunglasses',
      'price': 31.00,
      'description': 'Classic wayfarer style sunglasses',
      'colors': ['Tortoise'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/sun8.jpg',
    },
    {
      'id': 'sg9',
      'name': 'Polarized Shades',
      'category': 'Sunglasses',
      'price': 55.00,
      'description': 'Premium polarized anti-glare sunglasses',
      'colors': ['Brown'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/sun9.jpg',
    },
    {
      'id': 'sg10',
      'name': 'Kids Sunglasses',
      'category': 'Sunglasses',
      'price': 12.99,
      'description': 'Fun UV-protective kids sunglasses',
      'colors': ['Green'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/sun10.jpg',
    },

    // ══════════════════════════════════════════════════════════════════════════
    // SILK SCARF (10)
    // ══════════════════════════════════════════════════════════════════════════
    {
      'id': 'sc1',
      'name': 'Embroidered Rose Silk Scarf',
      'category': 'Silk Scarf',
      'price': 14.99,
      'description':
          'Luxurious hand-embroidered rose silk scarf with tassel ends',
      'colors': ['Pink'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/sc1.jpg',
    },
    {
      'id': 'sc2',
      'name': 'Mulberry Silk Cheongsam Scarf',
      'category': 'Silk Scarf',
      'price': 15.00,
      'description': 'Premium mulberry silk scarf — elegant floral embroidery',
      'colors': ['Pink'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/sc2.jpg',
    },
    {
      'id': 'sc3',
      'name': 'MUSUMI Embroidered Scarf',
      'category': 'Silk Scarf',
      'price': 16.99,
      'description': 'All-match women embroidered floral silk scarf wrap',
      'colors': ['Black'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/sc3.jpg',
    },
    {
      'id': 'sc4',
      'name': 'Natural Silk Handmade Scarf',
      'category': 'Silk Scarf',
      'price': 18.00,
      'description': 'Handmade natural silk scarf — lightweight and breathable',
      'colors': ['Beige'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/sc3-beig.jpg',
    },
    {
      'id': 'sc5',
      'name': 'Red Roses Silk Scarf',
      'category': 'Silk Scarf',
      'price': 22.00,
      'description': 'Ladies fashion red rose print 100% silk scarf',
      'colors': ['Purple'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/sc3-purple.jpg',
    },
    {
      'id': 'sc6',
      'name': 'Plain Pom-Pom Scarf',
      'category': 'Silk Scarf',
      'price': 15.99,
      'description': 'Traditional plain scarf with pom-pom trim',
      'colors': ['Cream'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/sc11.jpg',
    },
    {
      'id': 'sc7',
      'name': 'Chiffon Hijab Shawl',
      'category': 'Silk Scarf',
      'price': 12.99,
      'description': 'Long chiffon hijab / Arab wrap shawl headwear',
      'colors': ['Orange'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/sc4.jpg',
    },
    {
      'id': 'sc8',
      'name': 'Cotton Flower Diamond Stole',
      'category': 'Silk Scarf',
      'price': 14.99,
      'description': 'Women cotton flower diamond pattern stole scarf',
      'colors': ['Black'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/sc5-black.jpg',
    },
    {
      'id': 'sc9',
      'name': 'Silk Hijab Scarf',
      'category': 'Silk Scarf',
      'price': 27.00,
      'description':
          'Silk hijab wrap scarf — versatile for hair and neck styling',
      'colors': ['Sky Blue'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/sc8.jpg',
    },
    {
      'id': 'sc10',
      'name': 'Woolen Scarf',
      'category': 'Silk Scarf',
      'price': 35.00,
      'description': 'High-quality embroidery rose flower tassel silk scarf',
      'colors': ['Cream'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/sc10.jpg',
    },

    // ══════════════════════════════════════════════════════════════════════════
    // HAND BAG (10)
    // ══════════════════════════════════════════════════════════════════════════
    {
      'id': 'hb1',
      'name': 'Leather Tote Bag',
      'category': 'Hand Bag',
      'price': 89.99,
      'description': 'Spacious genuine leather tote bag',
      'colors': ['Purple'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/hb1.jpg',
    },
    {
      'id': 'hb2',
      'name': 'Crossbody Bag',
      'category': 'Hand Bag',
      'price': 55.00,
      'description': 'Compact stylish crossbody bag',
      'colors': ['Nude'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/hb2.jpg',
    },
    {
      'id': 'hb3',
      'name': 'Clutch Bag',
      'category': 'Hand Bag',
      'price': 38.00,
      'description': 'Elegant evening clutch bag',
      'colors': ['Green'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/hb3.jpg',
    },
    {
      'id': 'hb4',
      'name': 'Backpack',
      'category': 'Hand Bag',
      'price': 45.00,
      'description': 'Stylish hand Bag',
      'colors': ['Purple'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/hb4.jpg',
    },
    {
      'id': 'hb5',
      'name': 'Shoulder Bag',
      'category': 'Hand Bag',
      'price': 42.00,
      'description': 'Chic leather shoulder bag',
      'colors': ['Cream'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/hb5.jpg',
    },
    {
      'id': 'hb6',
      'name': 'Mini Bag',
      'category': 'Hand Bag',
      'price': 45.00,
      'description': 'Trendy mini handbag',
      'colors': ['Brown'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/hb6.jpg',
    },
    {
      'id': 'hb7',
      'name': 'Bucket Bag',
      'category': 'Hand Bag',
      'price': 48.00,
      'description': 'Casual drawstring bucket bag',
      'colors': ['Silver'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/hb7.jpg',
    },
    {
      'id': 'hb8',
      'name': 'Straw Beach Bag',
      'category': 'Hand Bag',
      'price': 32.00,
      'description': 'Summer woven straw beach bag',
      'colors': ['Brown'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/hb8.jpg',
    },
    {
      'id': 'hb9',
      'name': 'Velvet Bag',
      'category': 'Hand Bag',
      'price': 52.00,
      'description': 'Luxurious velvet evening bag',
      'colors': ['White'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/hb9.jpg',
    },
    {
      'id': 'hb10',
      'name': 'Canvas Tote',
      'category': 'Hand Bag',
      'price': 32.00,
      'description': 'Lightweight everyday canvas tote bag',
      'colors': ['White'],
      'sizes': ['One Size'],
      'imagePath': 'lib/assets/hb10.jpg',
    },

    // ══════════════════════════════════════════════════════════════════════════
    // MEN OFFICIAL (10)
    // ══════════════════════════════════════════════════════════════════════════
    {
      'id': 'mo1',
      'name': 'Light Blue Formal Shirt',
      'category': 'Men Official',
      'price': 32.00,
      'description': "Men's Black formal shirt — slim fit",
      'colors': ['Black'],
      'sizes': ['S', 'M', 'L', 'XL', 'XXL'],
      'imagePath': 'lib/assets/om1.jpg',
    },
    {
      'id': 'mo2',
      'name': 'Beige Pants Formal Combo',
      'category': 'Men Official',
      'price': 65.00,
      'description': 'Men formal office outfit — beige trousers combination',
      'colors': ['Beige'],
      'sizes': ['28', '30', '32', '34', '36'],
      'imagePath': 'lib/assets/om2.jpg',
    },
    {
      'id': 'mo3',
      'name': 'Formal for Men',
      'category': 'Men Official',
      'price': 28.00,
      'description': 'Classic crisp formal dress',
      'colors': ['White', 'Blue', 'Grey', 'Black'],
      'sizes': ['S', 'M', 'L', 'XL', 'XXL'],
      'imagePath': 'lib/assets/om3.jpg',
    },
    {
      'id': 'mo4',
      'name': 'Men Slim-Fit Suit',
      'category': 'Men Official',
      'price': 149.99,
      'description': '2-piece slim-fit formal suit for business and events',
      'colors': ['Black'],
      'sizes': ['38', '40', '42', '44', '46'],
      'imagePath': 'lib/assets/om4.jpg',
    },
    {
      'id': 'mo5',
      'name': 'Formal Wear Set',
      'category': 'Men Official',
      'price': 89.99,
      'description': 'Formal wear set — shirt and trousers',
      'colors': ['Navy'],
      'sizes': ['S', 'M', 'L', 'XL'],
      'imagePath': 'lib/assets/om5.jpg',
    },
    {
      'id': 'mo6',
      'name': 'Tuxedo Formal Look',
      'category': 'Men Official',
      'price': 195.00,
      'description': "Men's tuxedo style for events and galas",
      'colors': ['Brown'],
      'sizes': ['38', '40', '42', '44'],
      'imagePath': 'lib/assets/om6.jpg',
    },
    {
      'id': 'mo7',
      'name': 'Formal Belt',
      'category': 'Men Official',
      'price': 129.99,
      'description': 'Genuine leather formal dress belt',
      'colors': ['Black'],
      'sizes': ['S', 'M', 'L', 'XL'],
      'imagePath': 'lib/assets/om7.jpg',
    },
    {
      'id': 'mo8',
      'name': 'Striped Dress Shirt',
      'category': 'Men Official',
      'price': 34.00,
      'description': 'Pinstripe formal dress shirt — office ready',
      'colors': ['Black'],
      'sizes': ['S', 'M', 'L', 'XL', 'XXL'],
      'imagePath': 'lib/assets/om8.jpg',
    },
    {
      'id': 'mo9',
      'name': 'Men Waistcoat',
      'category': 'Men Official',
      'price': 49.00,
      'description': 'Classic formal waistcoat / vest',
      'colors': ['Silver'],
      'sizes': ['S', 'M', 'L', 'XL'],
      'imagePath': 'lib/assets/om9.png',
    },
    {
      'id': 'mo10',
      'name': 'Oxford Shirt',
      'category': 'Men Official',
      'price': 79.00,
      'description': 'Official Shirt',
      'colors': ['Green'],
      'sizes': ['40', '41', '42', '43', '44', '45'],
      'imagePath': 'lib/assets/om10.jpg',
    },

    // ══════════════════════════════════════════════════════════════════════════
    // OFFICIAL WEAR (10)
    // ══════════════════════════════════════════════════════════════════════════
    {
      'id': 'ow1',
      'name': 'Professional Summer Outfit',
      'category': 'Official Wear',
      'price': 75.00,
      'description': 'Chic professional summer outfit for women — office-ready',
      'colors': ['Beige'],
      'sizes': ['XS', 'S', 'M', 'L', 'XL'],
      'imagePath': 'lib/assets/of1.jpg',
    },
    {
      'id': 'ow2',
      'name': 'Elegant Formal Outfit',
      'category': 'Official Wear',
      'price': 95.00,
      'description': 'Business formal outfit — elegant and classy for women',
      'colors': ['Black'],
      'sizes': ['XS', 'S', 'M', 'L', 'XL'],
      'imagePath': 'lib/assets/of1.webp',
    },
    {
      'id': 'ow3',
      'name': 'Business Casual Jeans Look',
      'category': 'Official Wear',
      'price': 55.00,
      'description': 'Business casual with jeans — smart and stylish',
      'colors': ['Beige'],
      'sizes': ['XS', 'S', 'M', 'L', 'XL'],
      'imagePath': 'lib/assets/of2.jpg',
    },
    {
      'id': 'ow4',
      'name': 'Meetings & Conferences Blazer',
      'category': 'Official Wear',
      'price': 55.00,
      'description': 'Formal blazer for meetings and conferences',
      'colors': ['Beige'],
      'sizes': ['XS', 'S', 'M', 'L', 'XL'],
      'imagePath': 'lib/assets/of3.jpg',
    },
    {
      'id': 'ow5',
      'name': 'Classy Women Formal Outfit',
      'category': 'Official Wear',
      'price': 78.00,
      'description': 'Business meets fashion — classy women formal wear',
      'colors': ['Blue'],
      'sizes': ['XS', 'S', 'M', 'L'],
      'imagePath': 'lib/assets/of4.jpg',
    },
    {
      'id': 'ow6',
      'name': 'Formal Pantsuit',
      'category': 'Official Wear',
      'price': 112.00,
      'description': 'Sharp women pantsuit — professional and elegant',
      'colors': ['Black / Beige'],
      'sizes': ['XS', 'S', 'M', 'L', 'XL'],
      'imagePath': 'lib/assets/of10.jpg',
    },
    {
      'id': 'ow7',
      'name': 'Formal Blouse and Pant',
      'category': 'Official Wear',
      'price': 32.00,
      'description': 'Elegant silk-look formal blouse for corporate wear',
      'colors': ['Beige / Cream'],
      'sizes': ['XS', 'S', 'M', 'L'],
      'imagePath': 'lib/assets/of6.png',
    },
    {
      'id': 'ow8',
      'name': 'Pencil Skirt',
      'category': 'Official Wear',
      'price': 42.00,
      'description':
          'Classic fitted pencil skirt for office and formal occasions',
      'colors': ['Grey'],
      'sizes': ['XS', 'S', 'M', 'L', 'XL'],
      'imagePath': 'lib/assets/of8.jpg',
    },
    {
      'id': 'ow9',
      'name': 'Business Casual Outfit Set',
      'category': 'Official Wear',
      'price': 68.00,
      'description': 'Business casual outfit set for women',
      'colors': ['Black'],
      'sizes': ['XS', 'S', 'M', 'L', 'XL'],
      'imagePath': 'lib/assets/of7.jpg',
    },
    {
      'id': 'ow10',
      'name': 'Women Formal Dress',
      'category': 'Official Wear',
      'price': 88.00,
      'description': 'Classy midi formal dress for important office events',
      'colors': ['Brown'],
      'sizes': ['XS', 'S', 'M', 'L', 'XL'],
      'imagePath': 'lib/assets/of9.jpg',
    },

    // ══════════════════════════════════════════════════════════════════════════
    // LADIES HEELS (10)
    // ══════════════════════════════════════════════════════════════════════════
    {
      'id': 'lh1',
      'name': 'Stiletto Heels',
      'category': 'Ladies Heels',
      'price': 65.00,
      'description':
          'Classic pointed-toe stiletto heels — timeless and elegant for parties and formal events',
      'colors': ['Silver'],
      'sizes': ['36', '37', '38', '39', '40'],
      'imagePath': 'lib/assets/h2.webp',
    },
    {
      'id': 'lh2',
      'name': 'Block Heels',
      'category': 'Ladies Heels',
      'price': 55.00,
      'description':
          'Comfortable chunky block heels — perfect for all-day wear at the office or events',
      'colors': ['Beige'],
      'sizes': ['36', '37', '38', '39', '40', '41'],
      'imagePath': 'lib/assets/h3.webp',
    },
    {
      'id': 'lh3',
      'name': 'Kitten Heels',
      'category': 'Ladies Heels',
      'price': 48.00,
      'description':
          'Delicate low kitten heels — elegant, feminine and easy to walk in all day',
      'colors': ['Pink'],
      'sizes': ['35', '36', '37', '38', '39', '40'],
      'imagePath': 'lib/assets/h4.webp',
    },
    {
      'id': 'lh4',
      'name': 'Strappy Heels',
      'category': 'Ladies Heels',
      'price': 72.00,
      'description':
          'Open-toe strappy sandal heels — ideal for weddings, parties and summer nights',
      'colors': ['White'],
      'sizes': ['36', '37', '38', '39', '40'],
      'imagePath': 'lib/assets/h5.jpg',
    },
    {
      'id': 'lh5',
      'name': 'Wedge Heels',
      'category': 'Ladies Heels',
      'price': 60.00,
      'description':
          'Comfortable wedge platform heels — stylish height without the wobble',
      'colors': ['Beige'],
      'sizes': ['36', '37', '38', '39', '40', '41'],
      'imagePath': 'lib/assets/h6.jpg',
    },
    {
      'id': 'lh6',
      'name': 'Ankle Strap Heels',
      'category': 'Ladies Heels',
      'price': 68.00,
      'description':
          'Elegant ankle-strap court heels — secure fit with a classy look',
      'colors': ['White'],
      'sizes': ['36', '37', '38', '39', '40'],
      'imagePath': 'lib/assets/h7.jpg',
    },
    {
      'id': 'lh7',
      'name': 'Platform Heels',
      'category': 'Ladies Heels',
      'price': 80.00,
      'description':
          'Bold platform heels with extra height — statement shoes for any occasion',
      'colors': ['White'],
      'sizes': ['36', '37', '38', '39', '40', '41'],
      'imagePath': 'lib/assets/h8.jpg',
    },
    {
      'id': 'lh8',
      'name': 'Bridal Heels',
      'category': 'Ladies Heels',
      'price': 95.00,
      'description':
          'Embellished bridal heels with pearl and crystal detailing — made for your big day',
      'colors': ['White'],
      'sizes': ['35', '36', '37', '38', '39', '40'],
      'imagePath': 'lib/assets/h9.webp',
    },
    {
      'id': 'lh9',
      'name': 'Pointed Pump Heels',
      'category': 'Ladies Heels',
      'price': 58.00,
      'description':
          'Sleek pointed-toe pump heels — the ultimate office-to-evening shoe',
      'colors': ['White'],
      'sizes': ['36', '37', '38', '39', '40'],
      'imagePath': 'lib/assets/h10.jpg',
    },
    {
      'id': 'lh10',
      'name': 'Mule Heels',
      'category': 'Ladies Heels',
      'price': 52.00,
      'description':
          'Backless slip-on mule heels — effortlessly chic and easy to wear',
      'colors': ['Beige'],
      'sizes': ['36', '37', '38', '39', '40', '41'],
      'imagePath': 'lib/assets/h11.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory ?? 'All';
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _fadeAnim = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
    _fadeController.forward();
    _wl.addListener(_onWishlistChanged);
  }

  void _onWishlistChanged() => setState(() {});

  @override
  void dispose() {
    _searchController.dispose();
    _fadeController.dispose();
    _wl.removeListener(_onWishlistChanged);
    super.dispose();
  }

  List<Map<String, dynamic>> get _filtered {
    var result = _allProducts;
    if (_selectedCategory != 'All') {
      result = result.where((p) => p['category'] == _selectedCategory).toList();
    }
    if (_query.isNotEmpty) {
      result = result
          .where((p) => (p['name'] as String)
              .toLowerCase()
              .contains(_query.toLowerCase()))
          .toList();
    }
    return result;
  }

  void _showQuickActions(Map<String, dynamic> p) {
    final price = (p['price'] as num).toDouble();
    final name = p['name'] as String? ?? 'Product';
    final colors =
        (p['colors'] as List<dynamic>?)?.map((e) => e.toString()).toList() ??
            [];
    final sizes =
        (p['sizes'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [];

    String selectedColor = colors.isNotEmpty ? colors.first : '';
    String selectedSize = sizes.isNotEmpty ? sizes.first : '';

    showModalBottomSheet(
      context: context,
      backgroundColor: MR.surface,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => StatefulBuilder(builder: (ctx, setModalState) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: MR.divider,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(name,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: MR.textMain)),
              const SizedBox(height: 4),
              Text('\$${price.toStringAsFixed(2)}', style: MR.price),
              if (colors.isNotEmpty) ...[
                const SizedBox(height: 14),
                const Text('Color',
                    style: TextStyle(
                        fontSize: 12,
                        color: MR.textSub,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: colors.map((c) {
                    final sel = selectedColor == c;
                    return GestureDetector(
                      onTap: () => setModalState(() => selectedColor = c),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: sel ? MR.roseFade : null,
                          color: sel ? null : MR.surface2,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: sel ? Colors.transparent : MR.divider),
                        ),
                        child: Text(c,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: sel ? Colors.white : MR.textSub)),
                      ),
                    );
                  }).toList(),
                ),
              ],
              if (sizes.isNotEmpty && sizes.first != 'One Size') ...[
                const SizedBox(height: 14),
                const Text('Size',
                    style: TextStyle(
                        fontSize: 12,
                        color: MR.textSub,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: sizes.map((s) {
                    final sel = selectedSize == s;
                    return GestureDetector(
                      onTap: () => setModalState(() => selectedSize = s),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 8),
                        width: 44,
                        height: 36,
                        decoration: BoxDecoration(
                          gradient: sel ? MR.roseFade : null,
                          color: sel ? null : MR.surface2,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: sel ? Colors.transparent : MR.divider),
                        ),
                        alignment: Alignment.center,
                        child: Text(s,
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: sel ? Colors.white : MR.textSub)),
                      ),
                    );
                  }).toList(),
                ),
              ],
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.shopping_bag_outlined,
                            size: 18, color: MR.rose),
                        label: const Text('Add to Cart',
                            style: TextStyle(
                                color: MR.rose, fontWeight: FontWeight.w700)),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: MR.rose, width: 1.5),
                          backgroundColor: MR.surface2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () async {
                          Navigator.pop(ctx);
                          await FirestoreService.addToCart({
                            'id': p['id'] ?? 'item',
                            'name': name,
                            'description': p['description'] ?? '',
                            'price': price,
                            'imagePath': p['imagePath'] ?? '',
                            'color': selectedColor,
                            'size': selectedSize,
                          });
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('$name added to cart!',
                                    style: const TextStyle(color: MR.textMain)),
                                backgroundColor: MR.surface2,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SizedBox(
                      height: 50,
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
                                  fontWeight: FontWeight.w700)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                          ),
                          onPressed: () {
                            Navigator.pop(ctx);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CheckoutPage(
                                  selectedItems: [
                                    {
                                      'id': p['id'] ?? 'item',
                                      'name': name,
                                      'description': p['description'] ?? '',
                                      'price': price,
                                      'imagePath': p['imagePath'] ?? '',
                                      'color': selectedColor,
                                      'size': selectedSize,
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
            ],
          ),
        );
      }),
    );
  }

  Widget _productImage(String path) {
    if (path.isEmpty) return _placeholder();
    return Image.asset(
      path,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => _placeholder(),
    );
  }

  Widget _placeholder() => Container(
        color: MR.surface2,
        child: const Center(
          child: Icon(Icons.shopping_bag_outlined, size: 36, color: MR.textSub),
        ),
      );

  Widget _categoryChip(String label) {
    final isSelected = _selectedCategory == label;
    final icon = _categoryIcons[label];
    return GestureDetector(
      onTap: () {
        if (_selectedCategory == label) return;
        setState(() {
          _selectedCategory = label;
          _query = '';
          _searchController.clear();
        });
        _fadeController
          ..reset()
          ..forward();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          gradient: isSelected ? MR.roseFade : null,
          color: isSelected ? null : MR.surface2,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: isSelected ? Colors.transparent : MR.divider,
            width: 1.2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                      color: MR.rose.withOpacity(0.28),
                      blurRadius: 8,
                      offset: const Offset(0, 3))
                ]
              : [],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon,
                  size: 14, color: isSelected ? Colors.white : MR.textSub),
              const SizedBox(width: 6),
            ],
            Text(label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : MR.textSub)),
          ],
        ),
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> p) {
    final imagePath = p['imagePath'] as String? ?? '';
    final docId = p['id'] as String? ?? '';
    final isFav = _wl.isFaved(docId);
    final price = (p['price'] as num?)?.toStringAsFixed(2) ?? '0.00';

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => ProductDetailsPage(product: p),
          transitionsBuilder: (_, anim, __, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: const Duration(milliseconds: 250),
        ),
      ),
      onLongPress: () => _showQuickActions(p),
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
                    child: SizedBox.expand(child: _productImage(imagePath)),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () {
                        _wl.toggle(WishlistItem(
                          id: docId,
                          name: p['name'] as String? ?? '',
                          price: (p['price'] as num?)?.toDouble() ?? 0,
                          imagePath: imagePath,
                          category: p['category'] as String? ?? '',
                        ));
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isFav ? MR.rose : MR.surface.withOpacity(0.85),
                          border:
                              Border.all(color: isFav ? MR.rose : MR.divider),
                        ),
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          size: 16,
                          color: isFav ? Colors.white : MR.textSub,
                        ),
                      ),
                    ),
                  ),
                  if ((p['category'] as String? ?? '').isNotEmpty)
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 7, vertical: 3),
                        decoration: BoxDecoration(
                          color: MR.surface.withOpacity(0.88),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: MR.divider),
                        ),
                        child: Text(
                          p['category'] as String,
                          style: const TextStyle(
                              fontSize: 9,
                              color: MR.textSub,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['name'] as String? ?? '',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: MR.textMain),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$$price', style: MR.price),
                      GestureDetector(
                        onTap: () => _showQuickActions(p),
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, gradient: MR.roseFade),
                          child: const Icon(Icons.add,
                              size: 16, color: Colors.white),
                        ),
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

  @override
  Widget build(BuildContext context) {
    final filtered = _filtered;
    return Scaffold(
      backgroundColor: MR.bg,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: MR.bg,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 38,
                          height: 38,
                          decoration: BoxDecoration(
                            color: MR.surface2,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: MR.divider),
                          ),
                          child: const Icon(Icons.chevron_left,
                              color: MR.textMain, size: 24),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          height: 44,
                          decoration: BoxDecoration(
                            color: MR.surface2,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: MR.divider),
                          ),
                          child: TextField(
                            controller: _searchController,
                            style: const TextStyle(
                                color: MR.textMain, fontSize: 14),
                            onChanged: (v) => setState(() => _query = v),
                            decoration: const InputDecoration(
                              hintText: 'Search products…',
                              hintStyle:
                                  TextStyle(color: MR.textSub, fontSize: 13.5),
                              prefixIcon: Icon(Icons.search_rounded,
                                  color: MR.textSub, size: 20),
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedCategory == 'All'
                            ? 'All Products'
                            : _selectedCategory,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: MR.textMain),
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: Text(
                          '${filtered.length} items',
                          key: ValueKey(filtered.length),
                          style: const TextStyle(
                              fontSize: 12,
                              color: MR.textSub,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 36,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      itemBuilder: (_, i) => _categoryChip(_categories[i]),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),

            // ── Bridal cover banner ───────────────────────────────────────
            if (_selectedCategory == 'Bridal' || _selectedCategory == 'All')
              GestureDetector(
                onTap: () {
                  setState(() => _selectedCategory = 'Bridal');
                  _fadeController
                    ..reset()
                    ..forward();
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                  height: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: MR.divider),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          'lib/assets/bridal1.webp',
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            decoration: const BoxDecoration(
                              gradient: MR.roseFade,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                const Color(0xFF1A0A0A).withOpacity(0.72),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  gradient: MR.goldFade,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text('Bridal Collection',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white)),
                              ),
                              const SizedBox(height: 6),
                              const Text('Dress Your\nDream Day',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      height: 1.15)),
                              const SizedBox(height: 4),
                              const Text('Pakistani & South Asian Bridal Wear',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white70)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            // ── Ladies Heels cover banner ─────────────────────────────────
            if (_selectedCategory == 'Ladies Heels' ||
                _selectedCategory == 'All')
              GestureDetector(
                onTap: () {
                  setState(() => _selectedCategory = 'Ladies Heels');
                  _fadeController
                    ..reset()
                    ..forward();
                },
                child: Container(
                  margin: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                  height: 110,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: MR.divider),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          'lib/assets/lh1.jpg',
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Container(
                            decoration: const BoxDecoration(
                              gradient: MR.roseFade,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                const Color(0xFF1A0A0A).withOpacity(0.72),
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  gradient: MR.roseFade,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text('Heels Collection',
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white)),
                              ),
                              const SizedBox(height: 6),
                              const Text('Step Into\nStyle',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      height: 1.15)),
                              const SizedBox(height: 4),
                              const Text(
                                  'Stilettos · Wedges · Platforms & More',
                                  style: TextStyle(
                                      fontSize: 10, color: Colors.white70)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            Container(height: 1, color: MR.divider),

            Expanded(
              child: filtered.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            decoration: const BoxDecoration(
                                color: MR.surface2, shape: BoxShape.circle),
                            child: const Icon(Icons.shopping_bag_outlined,
                                size: 34, color: MR.textSub),
                          ),
                          const SizedBox(height: 14),
                          Text(
                            _query.isNotEmpty
                                ? 'No results for "$_query"'
                                : 'No products in $_selectedCategory yet.',
                            style: const TextStyle(
                                fontSize: 13, color: MR.textSub),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : FadeTransition(
                      opacity: _fadeAnim,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.68,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: filtered.length,
                          itemBuilder: (_, i) => _buildProductCard(filtered[i]),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: MR.surface,
          border: Border(top: BorderSide(color: MR.divider)),
        ),
        child: BottomNavigationBar(
          currentIndex: 1,
          onTap: (i) {
            if (i == 0) Navigator.pop(context);
          },
          selectedItemColor: MR.rose,
          unselectedItemColor: MR.textSub,
          backgroundColor: MR.surface,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.explore_outlined), label: 'Explore'),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_bag_outlined), label: 'Bag'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
