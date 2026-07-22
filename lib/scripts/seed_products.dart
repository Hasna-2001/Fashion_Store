// lib/scripts/seed_products.dart
// ✅ ALL images use YOUR ImgBB direct URLs (i.ibb.co)
// HOW TO USE: Replace lib/scripts/seed_products.dart with this file,
// then tap "Seed Products to Firestore" button in your Profile page ONCE.

import '../services/firestore_service.dart';

// ── ImgBB Direct Image URLs ───────────────────────────────────────────────────
// Bridal
const _b1 = 'https://i.ibb.co/d0pRr6zK/bridal1.webp';
const _b2 = 'https://i.ibb.co/5g6Bf5pS/bridal2.webp';
const _b3 = 'https://i.ibb.co/S4B4brWt/bridal3.webp';
const _b4 = 'https://i.ibb.co/Tph60v3/bridal4.webp';
const _b5 = 'https://i.ibb.co/mF5YRG9M/bridal5.webp';
const _b6 = 'https://i.ibb.co/mFdv2sQM/bridal6.webp';
const _b7 = 'https://i.ibb.co/1G3Gxwq1/bridal7.webp';
const _b8 = 'https://i.ibb.co/ccJrnRyK/bridal8.webp';
const _b9 = 'https://i.ibb.co/ymCmjbKf/bridal9.webp';
const _b10 = 'https://i.ibb.co/XZ5wHnDH/bridal10.jpg';
const _bPink = 'https://i.ibb.co/M52R0y8s/bridal-pink.webp';
const _bRed = 'https://i.ibb.co/XrjV42wL/bridal-red.webp';

// Heels
const _h1 = 'https://i.ibb.co/SwBx1Zh1/h1.jpg';
const _h2 = 'https://i.ibb.co/nqYxpTQw/h2.webp';
const _h3 = 'https://i.ibb.co/LdgpfzLW/h3.webp';
const _h4 = 'https://i.ibb.co/DPQmNFhJ/h4.webp';
const _h5 = 'https://i.ibb.co/gFWm1hK4/h5.jpg';
const _h6 = 'https://i.ibb.co/VcJHXkMF/h6.jpg';
const _h7 = 'https://i.ibb.co/sv47C3B8/h7.jpg';
const _h8 = 'https://i.ibb.co/Jww56w8D/h8.jpg';
const _h9 = 'https://i.ibb.co/wjBjJpz/h9.webp';
const _h10 = 'https://i.ibb.co/ksmMc06N/h10.jpg';
const _h11 = 'https://i.ibb.co/5g1Z2mBx/h11.jpg';
const _h12 = 'https://i.ibb.co/RGqD6WCt/h12.jpg';

// Hand Bags
const _hb1 = 'https://i.ibb.co/DPFCNNVY/hb1.jpg';
const _hb2 = 'https://i.ibb.co/qMXYn78L/hb2.jpg';
const _hb3 = 'https://i.ibb.co/LWzJF3Z/hb3.jpg';
const _hb4 = 'https://i.ibb.co/392gzSp6/hb4.jpg';
const _hb5 = 'https://i.ibb.co/S42hcDhF/hb5.jpg';
const _hb6 = 'https://i.ibb.co/Y7jMNvWk/hb6.jpg';
const _hb7 = 'https://i.ibb.co/wNs30WD1/hb7.jpg';
const _hb8 = 'https://i.ibb.co/TMBhWZk1/hb8.jpg';
const _hb9 = 'https://i.ibb.co/4ZM69Y0p/hb9.jpg';
const _hb10 = 'https://i.ibb.co/d4b33Rtn/hb10.jpg';

// Jewellery / Accessories
const _j1 = 'https://i.ibb.co/wZ73K54v/j1.webp';
const _j2 = 'https://i.ibb.co/Jjr6q7HC/j2.jpg';
const _j2w = 'https://i.ibb.co/ksj5DQ8x/j2.webp';
const _j3 = 'https://i.ibb.co/G3NQ8r0p/j3.jpg';
const _j4 = 'https://i.ibb.co/Y7yQqdQC/j4.webp';

// Make-up
const _m1 = 'https://i.ibb.co/QvdNYgTv/make1.jpg';
const _m2 = 'https://i.ibb.co/ycpRMRmt/make2.jpg';
const _m3 = 'https://i.ibb.co/DgjkbJWz/make3.jpg';
const _m4 = 'https://i.ibb.co/Td3nYpT/make4.png';
const _m5 = 'https://i.ibb.co/Swzmk7Gv/make5.jpg';
const _m6 = 'https://i.ibb.co/ks1DNZX1/make6.jpg';
const _m7 = 'https://i.ibb.co/NnZgkSjf/make7.jpg';
const _m8 = 'https://i.ibb.co/v4vGN6sX/make8.jpg';
const _m9 = 'https://i.ibb.co/QFzSCNvj/make9.jpg';
const _m10 = 'https://i.ibb.co/HDnMTNrs/make10.jpg';

// Official Wear (Women)
const _of1 = 'https://i.ibb.co/p6VRZZKg/of1.jpg';
const _of1w = 'https://i.ibb.co/MytvpRd6/of1.webp';
const _of2 = 'https://i.ibb.co/r2W7FqD5/of2.jpg';
const _of2w = 'https://i.ibb.co/0pdcK5dt/of2.webp';
const _of3 = 'https://i.ibb.co/5xG1BHY4/of3.jpg';
const _of4 = 'https://i.ibb.co/dwxv7tqz/of4.jpg';
const _of5 = 'https://i.ibb.co/23cxDTCf/of5.jpg';
const _of6 = 'https://i.ibb.co/DHBGycyZ/of6.png';
const _of7 = 'https://i.ibb.co/Kx71mNKL/of7.jpg';
const _of8 = 'https://i.ibb.co/nsPg56yr/of8.jpg';
const _of9 = 'https://i.ibb.co/XkGgNVnr/of9.jpg';
const _of10 = 'https://i.ibb.co/Fb7rXfSX/of10.jpg';

// Men Official
const _om1 = 'https://i.ibb.co/nN66CL2M/om1.jpg';
const _om2 = 'https://i.ibb.co/PZMKk0yH/om2.jpg';
const _om3 = 'https://i.ibb.co/HfLwNbSg/om3.jpg';
const _om4 = 'https://i.ibb.co/WNzRZDBM/om4.jpg';
const _om5 = 'https://i.ibb.co/LzB0C8rv/om5.jpg';
const _om6 = 'https://i.ibb.co/vCdFHC3j/om6.jpg';
const _om7 = 'https://i.ibb.co/ycqJ3MTL/om7.jpg';
const _om8 = 'https://i.ibb.co/kgRxV7Br/om8.jpg';
const _om9 = 'https://i.ibb.co/LD7qWgcq/om9.png';
const _om10 = 'https://i.ibb.co/W4cSkRQt/om10.jpg';

// Silk Scarves
const _sc1 = 'https://i.ibb.co/MjTyDf6/sc1.jpg';
const _sc2 = 'https://i.ibb.co/994PgV3P/sc2.jpg';
const _sc3 = 'https://i.ibb.co/4Rkyvszx/sc3.jpg';
const _sc3b = 'https://i.ibb.co/xtggVp3b/sc3-beig.jpg';
const _sc3p = 'https://i.ibb.co/yFbj7z3g/sc3-purple.jpg';
const _sc4 = 'https://i.ibb.co/yBq7hggp/sc4.jpg';
const _sc5 = 'https://i.ibb.co/FbjyZwzD/sc5.webp';
const _sc5b = 'https://i.ibb.co/LXrQrBZj/sc5-beig.webp';
const _sc5k = 'https://i.ibb.co/VcP532S9/sc5-black.webp';
const _sc5p = 'https://i.ibb.co/rG5mnfGp/sc5-purple.webp';
const _sc6 = 'https://i.ibb.co/Dfd50v5V/sc6.jpg';
const _sc7 = 'https://i.ibb.co/5gCXcFnG/sc7.jpg';
const _sc8 = 'https://i.ibb.co/XZ4j9NJ1/sc8.jpg';
const _sc9 = 'https://i.ibb.co/skF60xH/sc9.avif';
const _sc9j = 'https://i.ibb.co/BVhjbfrZ/sc9.jpg';
const _sc10 = 'https://i.ibb.co/NgNDQ04P/sc10.jpg';
const _sc11 = 'https://i.ibb.co/4gnLyPLV/sc11.jpg';
const _scSilver = 'https://i.ibb.co/wh024qpV/sc-silver.avif';

// Sneakers
const _sh1 = 'https://i.ibb.co/N2Nmh6sh/sh1.jpg';
const _sh2 = 'https://i.ibb.co/FqJCT4Ls/sh2.jpg';
const _sh3 = 'https://i.ibb.co/wF2x2M3V/sh3.jpg';
const _sh4 = 'https://i.ibb.co/KcBjxL8X/sh4.jpg';
const _sh5 = 'https://i.ibb.co/j9J2GS4M/sh5.jpg';
const _sh6 = 'https://i.ibb.co/Y4X6WW4j/sh6.jpg';
const _sh7 = 'https://i.ibb.co/7xVLPCdh/sh7.jpg';
const _sh8 = 'https://i.ibb.co/VWLxqcn8/sh8.jpg';
const _sh9 = 'https://i.ibb.co/RkjgFQQn/sh9.jpg';
const _sh10 = 'https://i.ibb.co/bRW5fLZS/sh10.jpg';
const _shBlack = 'https://i.ibb.co/dJxkFwN6/sh-black.jpg';
const _shBlue = 'https://i.ibb.co/ksjbVcYc/sh-blue.jpg';
const _shBrown = 'https://i.ibb.co/hJtzZM3c/sh-brown.jpg';
const _shSilver = 'https://i.ibb.co/Q3Dwf8Bq/sh-silver.jpg';

// Sunglasses
const _sun1 = 'https://i.ibb.co/BV0nD1jp/sun1.jpg';
const _sun2 = 'https://i.ibb.co/jvXZpMkv/sun2.jpg';
const _sun3 = 'https://i.ibb.co/fYDKcXZh/sun3.jpg';
const _sun4 = 'https://i.ibb.co/fdJrd1tR/sun4.jpg';
const _sun5 = 'https://i.ibb.co/fG91gR5R/sun5.jpg';
const _sun6 = 'https://i.ibb.co/zTZF9hxx/sun6.jpg';
const _sun7 = 'https://i.ibb.co/wht1Xrzd/sun7.jpg';
const _sun8 = 'https://i.ibb.co/ymfxwQtt/sun8.jpg';
const _sun9 = 'https://i.ibb.co/G4mTTnDR/sun9.jpg';
const _sun10 = 'https://i.ibb.co/TqkcXrJz/sun10.jpg';

class SeedProducts {
  SeedProducts._();

  static Future<void> run({
    void Function(int current, int total)? onProgress,
  }) async {
    final products = [
      // ══════════════════════════════════════
      // 1. BRIDAL (10 products)
      // ══════════════════════════════════════
      {
        'name': 'Embroidered Pakistani Bridal Frock',
        'description':
            'Stunning hand-embroidered Pakistani wedding frock with heavy bridal stonework and intricate zari work. Perfect for the nikah or mehndi ceremony.',
        'price': 299.99,
        'category': 'Bridal',
        'imageUrl': _b1,
        'thumbnailUrls': [_b2, _b3, _bRed],
        'colorImages': {'Red': _bRed, 'Maroon': _b1, 'Gold': _b3},
        'isFeatured': true,
        'stock': 8,
        'sizes': ['XS', 'S', 'M', 'L'],
        'colors': ['Red', 'Maroon', 'Gold'],
      },
      {
        'name': 'Luxury Bridal Lehenga – Maryam',
        'description':
            'Luxurious Pakistani bridal lehenga — intricate embroidery on soft tissue fabric with a matching dupatta. Ideal for barat and valima.',
        'price': 349.00,
        'category': 'Bridal',
        'imageUrl': _b2,
        'thumbnailUrls': [_b1, _bPink, _b4],
        'colorImages': {'Pink': _bPink, 'Blush': _b2, 'Ivory': _b4},
        'isFeatured': true,
        'stock': 5,
        'sizes': ['XS', 'S', 'M', 'L', 'XL'],
        'colors': ['Pink', 'Blush', 'Ivory'],
      },
      {
        'name': 'Walima Bridal Silk Dress',
        'description':
            'Elegant walima bridal dress — delicate hand embroidery on premium silk base. Regal and feminine.',
        'price': 275.00,
        'category': 'Bridal',
        'imageUrl': _b3,
        'thumbnailUrls': [_b1, _b2],
        'colorImages': {'White': _b3, 'Champagne': _b4, 'Silver': _b5},
        'isFeatured': false,
        'stock': 6,
        'sizes': ['S', 'M', 'L'],
        'colors': ['White', 'Champagne', 'Silver'],
      },
      {
        'name': 'Heavy Zari Bridal Gown',
        'description':
            'Heavy zari and dabka work on rich raw silk. A showstopper for the barat ceremony.',
        'price': 420.00,
        'category': 'Bridal',
        'imageUrl': _b4,
        'thumbnailUrls': [_b1, _bRed],
        'colorImages': {'Deep Red': _bRed, 'Burgundy': _b4, 'Crimson': _b5},
        'isFeatured': true,
        'stock': 4,
        'sizes': ['XS', 'S', 'M'],
        'colors': ['Deep Red', 'Crimson', 'Burgundy'],
      },
      {
        'name': 'Kundan Bridal Set',
        'description':
            'Opulent bridal dress set with heavy stonework and kundan detailing. Perfect for sangeet and barat.',
        'price': 390.00,
        'category': 'Bridal',
        'imageUrl': _b5,
        'thumbnailUrls': [_b1, _b3],
        'colorImages': {'Red': _bRed, 'Gold': _b5},
        'isFeatured': false,
        'stock': 7,
        'sizes': ['S', 'M', 'L', 'XL'],
        'colors': ['Red', 'Gold'],
      },
      {
        'name': 'Chiffon Walima Maxi',
        'description':
            'Graceful walima maxi in soft chiffon with silver threadwork — flowing silhouette for the walima reception.',
        'price': 310.00,
        'category': 'Bridal',
        'imageUrl': _b6,
        'thumbnailUrls': [_b3, _b9],
        'colorImages': {'Silver': _b6, 'Ivory': _b3, 'Champagne': _b9},
        'isFeatured': false,
        'stock': 10,
        'sizes': ['XS', 'S', 'M', 'L'],
        'colors': ['Silver', 'Ivory', 'Champagne'],
      },
      {
        'name': 'Mehndi Ceremony Outfit',
        'description':
            'Vibrant mehndi ceremony outfit in lime and gold — traditional Pakistani three-piece with printed dupatta.',
        'price': 180.00,
        'category': 'Bridal',
        'imageUrl': _b7,
        'thumbnailUrls': [_b8, _b9],
        'colorImages': {'Green': _b7, 'Yellow': _b8, 'Orange': _b9},
        'isFeatured': false,
        'stock': 12,
        'sizes': ['XS', 'S', 'M', 'L'],
        'colors': ['Green', 'Yellow', 'Orange'],
      },
      {
        'name': 'Heavy Embroidered Bridal Dupatta',
        'description':
            'Bridal dupatta with kiran border and hand-done embroidery — a stunning finishing piece.',
        'price': 75.00,
        'category': 'Bridal',
        'imageUrl': _b8,
        'thumbnailUrls': [_bPink, _bRed],
        'colorImages': {'Red': _bRed, 'Pink': _bPink, 'White': _b8},
        'isFeatured': false,
        'stock': 20,
        'sizes': ['One Size'],
        'colors': ['Red', 'Pink', 'White'],
      },
      {
        'name': 'Signature Bridal Luxury Gown',
        'description':
            'Full-length bridal gown — heavyweight silk with embellished neckline and sleeves.',
        'price': 480.00,
        'category': 'Bridal',
        'imageUrl': _b9,
        'thumbnailUrls': [_bRed, _bPink],
        'colorImages': {'Crimson': _bRed, 'Rose': _bPink, 'Burgundy': _b9},
        'isFeatured': true,
        'stock': 3,
        'sizes': ['XS', 'S', 'M', 'L'],
        'colors': ['Crimson', 'Rose', 'Burgundy'],
      },
      {
        'name': 'Pakistani Wedding Bridal Dress',
        'description':
            'Traditional Pakistani wedding bridal dress — full embroidery coverage and statement dupatta.',
        'price': 360.00,
        'category': 'Bridal',
        'imageUrl': _b10,
        'thumbnailUrls': [_b1, _b2],
        'colorImages': {'Red': _bRed, 'Maroon': _b10, 'Gold': _b3},
        'isFeatured': false,
        'stock': 6,
        'sizes': ['S', 'M', 'L', 'XL'],
        'colors': ['Red', 'Maroon', 'Gold'],
      },

      // ══════════════════════════════════════
      // 2. MAKE-UP KIT (10 products)
      // ══════════════════════════════════════
      {
        'name': 'Pro 50-Piece Makeup Kit',
        'description':
            'Full professional 50-piece makeup kit — eyeshadow, lip, foundation, brush set all in one.',
        'price': 89.99,
        'category': 'Make-up Kit',
        'imageUrl': _m1,
        'thumbnailUrls': [_m2, _m3],
        'colorImages': {'Rose': _m1, 'Nude': _m2, 'Bold': _m3},
        'isFeatured': true,
        'stock': 25,
        'sizes': ['One Size'],
        'colors': ['Rose', 'Nude', 'Bold'],
      },
      {
        'name': 'Long-Lasting Foundation Set',
        'description':
            'Buildable coverage matte foundation in 12 shades from porcelain to deep espresso.',
        'price': 34.99,
        'category': 'Make-up Kit',
        'imageUrl': _m2,
        'thumbnailUrls': [_m3],
        'colorImages': {'Light': _m2, 'Medium': _m3, 'Dark': _m4},
        'isFeatured': false,
        'stock': 40,
        'sizes': ['One Size'],
        'colors': ['Light', 'Medium', 'Dark'],
      },
      {
        'name': '6-Piece Lipstick Collection',
        'description':
            'Six long-wear creamy lipsticks in curated shades — from soft nudes to bold reds.',
        'price': 24.99,
        'category': 'Make-up Kit',
        'imageUrl': _m3,
        'thumbnailUrls': [],
        'colorImages': {'Red': _m3, 'Nude': _m2},
        'isFeatured': false,
        'stock': 50,
        'sizes': ['One Size'],
        'colors': ['Red', 'Pink', 'Nude', 'Berry'],
      },
      {
        'name': '24-Colour Smoky Eye Palette',
        'description':
            'Blendable 24-pan eyeshadow palette with mattes, shimmers and glitters.',
        'price': 29.99,
        'category': 'Make-up Kit',
        'imageUrl': _m4,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 35,
        'sizes': ['One Size'],
        'colors': ['Neutral', 'Smoky', 'Colourful'],
      },
      {
        'name': 'Glow Setting Spray & Primer',
        'description':
            'Makeup setting spray with dewy glow finish — lock makeup for up to 16 hours.',
        'price': 18.99,
        'category': 'Make-up Kit',
        'imageUrl': _m5,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 60,
        'sizes': ['One Size'],
        'colors': ['Glow', 'Matte'],
      },
      {
        'name': 'Contouring & Highlight Kit',
        'description':
            'Bronze, contour, highlight and blush in one sculpting palette.',
        'price': 22.99,
        'category': 'Make-up Kit',
        'imageUrl': _m6,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 45,
        'sizes': ['One Size'],
        'colors': ['Light/Medium', 'Medium/Dark'],
      },
      {
        'name': 'Waterproof Mascara & Liner Set',
        'description':
            'Volumising waterproof mascara paired with precise felt-tip eyeliner.',
        'price': 16.99,
        'category': 'Make-up Kit',
        'imageUrl': _m7,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 55,
        'sizes': ['One Size'],
        'colors': ['Black', 'Brown'],
      },
      {
        'name': 'Bridal Makeup Complete Set',
        'description':
            'All-in-one bridal makeup kit for a flawless wedding day look.',
        'price': 120.00,
        'category': 'Make-up Kit',
        'imageUrl': _m8,
        'thumbnailUrls': [_m1, _m2],
        'colorImages': {},
        'isFeatured': true,
        'stock': 15,
        'sizes': ['One Size'],
        'colors': ['One Kit'],
      },
      {
        'name': 'Skincare + Makeup Starter Pack',
        'description':
            'Beginner-friendly skincare and makeup starter bundle — cleanser, primer, BB cream and lip tint.',
        'price': 45.00,
        'category': 'Make-up Kit',
        'imageUrl': _m9,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 30,
        'sizes': ['One Size'],
        'colors': ['One Kit'],
      },
      {
        'name': 'Luxury Brush Set – 12 Piece',
        'description':
            'Professional 12-piece makeup brush set with synthetic bristles and rose-gold ferrule.',
        'price': 38.00,
        'category': 'Make-up Kit',
        'imageUrl': _m10,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 40,
        'sizes': ['One Size'],
        'colors': ['Rose Gold', 'Black'],
      },

      // ══════════════════════════════════════
      // 3. CASUAL SNEAKERS (10 products)
      // ══════════════════════════════════════
      {
        'name': 'Classic White Sneakers',
        'description':
            'Timeless white leather-look sneakers — the everyday essential that pairs with everything.',
        'price': 45.00,
        'category': 'Casual Sneakers',
        'imageUrl': _sh1,
        'thumbnailUrls': [_shBlack, _shBlue],
        'colorImages': {'White': _sh1, 'Black': _shBlack, 'Blue': _shBlue},
        'isFeatured': true,
        'stock': 50,
        'sizes': ['40', '41', '42', '43', '44'],
        'colors': ['White', 'Black', 'Blue'],
      },
      {
        'name': 'Lightweight Running Sneakers',
        'description':
            'Breathable mesh upper with cushioned sole — engineered for daily running and gym.',
        'price': 65.00,
        'category': 'Casual Sneakers',
        'imageUrl': _sh2,
        'thumbnailUrls': [_shBlue, _shBrown],
        'colorImages': {
          'Blue': _shBlue,
          'Brown': _shBrown,
          'Silver': _shSilver
        },
        'isFeatured': false,
        'stock': 35,
        'sizes': ['39', '40', '41', '42', '43', '44'],
        'colors': ['Blue', 'Brown', 'Silver'],
      },
      {
        'name': 'Hi-Top Canvas Sneakers',
        'description':
            'Stylish high-top canvas sneakers with padded collar and metal eyelets.',
        'price': 72.00,
        'category': 'Casual Sneakers',
        'imageUrl': _sh3,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 25,
        'sizes': ['40', '41', '42', '43', '44', '45'],
        'colors': ['White', 'Black', 'Navy'],
      },
      {
        'name': 'Slip-On Sneakers',
        'description':
            'Laceless elastic-side slip-ons with memory foam insole — effortless comfort.',
        'price': 38.00,
        'category': 'Casual Sneakers',
        'imageUrl': _sh4,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 40,
        'sizes': ['37', '38', '39', '40', '41', '42'],
        'colors': ['White', 'Black', 'Grey'],
      },
      {
        'name': 'Chunky Platform Sneakers',
        'description':
            'Bold chunky sole platform sneakers — adds height while keeping you street-style ready.',
        'price': 82.00,
        'category': 'Casual Sneakers',
        'imageUrl': _sh5,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 20,
        'sizes': ['36', '37', '38', '39', '40', '41'],
        'colors': ['White', 'Black', 'Pink'],
      },
      {
        'name': 'Retro Trainers',
        'description':
            'Vintage 80s-inspired retro trainers with suede overlays and gum sole.',
        'price': 58.00,
        'category': 'Casual Sneakers',
        'imageUrl': _sh6,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 22,
        'sizes': ['40', '41', '42', '43', '44'],
        'colors': ['White/Red', 'White/Blue', 'Black/Gold'],
      },
      {
        'name': 'Knit Sock Sneakers',
        'description':
            'Sock-fit knit upper sneakers with zero-drop sole — like wearing a cloud.',
        'price': 55.00,
        'category': 'Casual Sneakers',
        'imageUrl': _sh7,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 30,
        'sizes': ['38', '39', '40', '41', '42', '43'],
        'colors': ['Grey', 'Navy', 'Black'],
      },
      {
        'name': 'Premium Suede Sneakers',
        'description':
            'Soft suede uppers with pigment-dyed finish — casual luxury for every occasion.',
        'price': 68.00,
        'category': 'Casual Sneakers',
        'imageUrl': _sh8,
        'thumbnailUrls': [_shBrown],
        'colorImages': {'Tan': _shBrown, 'Silver': _shSilver},
        'isFeatured': false,
        'stock': 18,
        'sizes': ['38', '39', '40', '41', '42', '43', '44'],
        'colors': ['Tan', 'Grey', 'Navy'],
      },
      {
        'name': 'Dad-Style Chunky Sneakers',
        'description':
            'Bold dad sneaker with multi-layer EVA midsole — the chunky silhouette that never goes out of style.',
        'price': 88.00,
        'category': 'Casual Sneakers',
        'imageUrl': _sh9,
        'thumbnailUrls': [_shBlack],
        'colorImages': {'White': _sh9, 'Black': _shBlack},
        'isFeatured': false,
        'stock': 15,
        'sizes': ['39', '40', '41', '42', '43'],
        'colors': ['White', 'Black', 'Multi'],
      },
      {
        'name': 'Canvas Low-Top Classics',
        'description':
            'Everyday canvas low-tops with vulcanised rubber sole — simple, durable and timeless.',
        'price': 32.00,
        'category': 'Casual Sneakers',
        'imageUrl': _sh10,
        'thumbnailUrls': [_shBlue, _shBlack],
        'colorImages': {
          'Blue': _shBlue,
          'Black': _shBlack,
          'Silver': _shSilver
        },
        'isFeatured': false,
        'stock': 60,
        'sizes': ['37', '38', '39', '40', '41', '42'],
        'colors': ['White', 'Black', 'Red', 'Navy'],
      },

      // ══════════════════════════════════════
      // 4. SUNGLASSES (10 products)
      // ══════════════════════════════════════
      {
        'name': 'Classic Aviator Sunglasses',
        'description':
            'Timeless teardrop aviator with UV400 metal frame — the iconic shape that suits every face.',
        'price': 29.99,
        'category': 'Sunglasses',
        'imageUrl': _sun1,
        'thumbnailUrls': [_sun2, _sun3],
        'colorImages': {'Black': _sun1, 'Gold': _sun2, 'Silver': _sun3},
        'isFeatured': true,
        'stock': 40,
        'sizes': ['One Size'],
        'colors': ['Black', 'Gold', 'Silver'],
      },
      {
        'name': 'Retro Cat-Eye Shades',
        'description':
            'Vintage cat-eye frame with UV protection — bold and feminine.',
        'price': 24.99,
        'category': 'Sunglasses',
        'imageUrl': _sun2,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 30,
        'sizes': ['One Size'],
        'colors': ['Black', 'Tortoise', 'Pink'],
      },
      {
        'name': 'Boho Round Sunglasses',
        'description':
            'Round wire-frame sunglasses with a bohemian flair — perfect for festivals and travel.',
        'price': 19.99,
        'category': 'Sunglasses',
        'imageUrl': _sun3,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 35,
        'sizes': ['One Size'],
        'colors': ['Gold', 'Rose Gold', 'Silver'],
      },
      {
        'name': 'Oversized Square Sunglasses',
        'description':
            'Bold oversized square acetate frames with polarised lenses — maximum drama, maximum protection.',
        'price': 34.99,
        'category': 'Sunglasses',
        'imageUrl': _sun4,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 25,
        'sizes': ['One Size'],
        'colors': ['Black', 'Tortoise', 'Clear'],
      },
      {
        'name': 'Sports Wrap Sunglasses',
        'description':
            'Wraparound sports sunglasses with anti-glare polarised lenses — built for outdoor action.',
        'price': 39.99,
        'category': 'Sunglasses',
        'imageUrl': _sun5,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 20,
        'sizes': ['One Size'],
        'colors': ['Black', 'White', 'Red'],
      },
      {
        'name': 'Geometric Hexagon Frames',
        'description':
            'Edgy geometric hexagon frames with coloured mirror lenses — for the bold and fearless.',
        'price': 27.99,
        'category': 'Sunglasses',
        'imageUrl': _sun6,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 28,
        'sizes': ['One Size'],
        'colors': ['Gold/Blue', 'Silver/Pink', 'Black/Green'],
      },
      {
        'name': 'Transparent Frame Sunglasses',
        'description':
            'Trendy clear acetate frames with gradient tinted lenses — minimal yet impactful.',
        'price': 22.99,
        'category': 'Sunglasses',
        'imageUrl': _sun7,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 32,
        'sizes': ['One Size'],
        'colors': ['Clear', 'Pink', 'Yellow'],
      },
      {
        'name': 'Butterfly Frame Sunglasses',
        'description':
            'Glamorous butterfly-shaped frames with UV400 lenses — effortlessly chic.',
        'price': 31.99,
        'category': 'Sunglasses',
        'imageUrl': _sun8,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 22,
        'sizes': ['One Size'],
        'colors': ['Black', 'Brown', 'Purple'],
      },
      {
        'name': 'Slim Rectangle Sunglasses',
        'description':
            'Sleek slim rectangle frames — the minimalist accessory that elevates any outfit.',
        'price': 26.99,
        'category': 'Sunglasses',
        'imageUrl': _sun9,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 38,
        'sizes': ['One Size'],
        'colors': ['Black', 'Gold', 'Silver'],
      },
      {
        'name': 'Luxury Shield Sunglasses',
        'description':
            'Statement shield-style sunglasses with single-piece curved lens — futuristic and fierce.',
        'price': 48.99,
        'category': 'Sunglasses',
        'imageUrl': _sun10,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': true,
        'stock': 15,
        'sizes': ['One Size'],
        'colors': ['Black', 'Silver', 'Gold'],
      },

      // ══════════════════════════════════════
      // 5. SILK SCARF (10 products)
      // ══════════════════════════════════════
      {
        'name': 'Embroidered Rose Silk Scarf',
        'description':
            'Luxurious hand-embroidered mulberry silk scarf with a delicate floral rose pattern.',
        'price': 24.99,
        'category': 'Silk Scarf',
        'imageUrl': _sc1,
        'thumbnailUrls': [_sc2, _sc3],
        'colorImages': {'Red': _sc1, 'Beige': _sc3b, 'Purple': _sc3p},
        'isFeatured': true,
        'stock': 30,
        'sizes': ['One Size'],
        'colors': ['Red', 'Beige', 'Purple'],
      },
      {
        'name': 'Classic Printed Silk Scarf',
        'description':
            'Smooth satin-weave silk scarf with a classic geometric print — perfect for hair, neck or bag.',
        'price': 19.99,
        'category': 'Silk Scarf',
        'imageUrl': _sc2,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 40,
        'sizes': ['One Size'],
        'colors': ['Multi', 'Navy', 'Red'],
      },
      {
        'name': 'Boho Floral Silk Wrap',
        'description':
            'Large boho floral silk wrap — wear as a shawl, sarong or statement scarf.',
        'price': 29.99,
        'category': 'Silk Scarf',
        'imageUrl': _sc3,
        'thumbnailUrls': [_sc3b, _sc3p],
        'colorImages': {'Beige': _sc3b, 'Purple': _sc3p, 'Original': _sc3},
        'isFeatured': false,
        'stock': 25,
        'sizes': ['One Size'],
        'colors': ['Beige', 'Purple', 'Multi'],
      },
      {
        'name': 'Solid Silk Neck Scarf',
        'description':
            'Lightweight solid-colour silk neck scarf — the effortless French-girl accessory.',
        'price': 15.99,
        'category': 'Silk Scarf',
        'imageUrl': _sc4,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 50,
        'sizes': ['One Size'],
        'colors': ['Black', 'White', 'Red', 'Navy', 'Beige'],
      },
      {
        'name': 'Luxury Paisley Silk Scarf',
        'description':
            'Rich paisley pattern on 100% mulberry silk — a timeless heritage piece.',
        'price': 34.99,
        'category': 'Silk Scarf',
        'imageUrl': _sc5,
        'thumbnailUrls': [_sc5b, _sc5k, _sc5p],
        'colorImages': {'Beige': _sc5b, 'Black': _sc5k, 'Purple': _sc5p},
        'isFeatured': true,
        'stock': 20,
        'sizes': ['One Size'],
        'colors': ['Beige', 'Black', 'Purple'],
      },
      {
        'name': 'Summer Stripe Silk Scarf',
        'description':
            'Vibrant stripe silk scarf — lightweight and breezy for summer styling.',
        'price': 17.99,
        'category': 'Silk Scarf',
        'imageUrl': _sc6,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 45,
        'sizes': ['One Size'],
        'colors': ['Multi', 'Blue/White', 'Red/White'],
      },
      {
        'name': 'Monogram Square Silk Scarf',
        'description':
            'Chic square silk scarf with a subtle monogram border print.',
        'price': 27.99,
        'category': 'Silk Scarf',
        'imageUrl': _sc7,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 30,
        'sizes': ['One Size'],
        'colors': ['Beige', 'Black', 'Red'],
      },
      {
        'name': 'Marble Print Silk Scarf',
        'description':
            'Contemporary marble swirl print on satin silk — modern art you can wear.',
        'price': 21.99,
        'category': 'Silk Scarf',
        'imageUrl': _sc8,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 35,
        'sizes': ['One Size'],
        'colors': ['White/Grey', 'Black/Gold', 'Blue/White'],
      },
      {
        'name': 'Ombre Dip-Dye Silk Scarf',
        'description':
            'Gradient ombre dip-dye silk scarf — artistic, flowing and unique in look.',
        'price': 32.99,
        'category': 'Silk Scarf',
        'imageUrl': _sc9,
        'thumbnailUrls': [_sc9j],
        'colorImages': {'Original': _sc9, 'Alt': _sc9j},
        'isFeatured': false,
        'stock': 20,
        'sizes': ['One Size'],
        'colors': ['Pink/White', 'Blue/White', 'Purple/Pink'],
      },
      {
        'name': 'Silver Shimmer Evening Scarf',
        'description':
            'Lustrous silver-threaded evening scarf — adds glamour to any formal or party look.',
        'price': 39.99,
        'category': 'Silk Scarf',
        'imageUrl': _scSilver,
        'thumbnailUrls': [_sc10, _sc11],
        'colorImages': {'Silver': _scSilver, 'Gold': _sc10},
        'isFeatured': true,
        'stock': 15,
        'sizes': ['One Size'],
        'colors': ['Silver', 'Gold', 'Rose Gold'],
      },

      // ══════════════════════════════════════
      // 6. HAND BAG (10 products)
      // ══════════════════════════════════════
      {
        'name': 'Genuine Leather Tote Bag',
        'description':
            'Spacious full-grain leather tote bag with magnetic snap closure and interior pockets.',
        'price': 89.99,
        'category': 'Hand Bag',
        'imageUrl': _hb1,
        'thumbnailUrls': [_hb2, _hb3],
        'colorImages': {'Black': _hb1, 'Brown': _hb2, 'Tan': _hb3},
        'isFeatured': true,
        'stock': 20,
        'sizes': ['One Size'],
        'colors': ['Black', 'Brown', 'Tan'],
      },
      {
        'name': 'Quilted Chain Shoulder Bag',
        'description':
            'Elegant quilted flap bag with gold-tone chain strap — day to evening in seconds.',
        'price': 65.00,
        'category': 'Hand Bag',
        'imageUrl': _hb2,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 25,
        'sizes': ['One Size'],
        'colors': ['Black', 'Beige', 'Pink'],
      },
      {
        'name': 'Mini Crossbody Bag',
        'description':
            'Compact mini crossbody with adjustable strap — holds essentials without the bulk.',
        'price': 35.00,
        'category': 'Hand Bag',
        'imageUrl': _hb3,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 35,
        'sizes': ['One Size'],
        'colors': ['Black', 'White', 'Red', 'Nude'],
      },
      {
        'name': 'Woven Straw Beach Bag',
        'description':
            'Handwoven natural straw tote — roomy, lightweight and perfect for the beach.',
        'price': 28.00,
        'category': 'Hand Bag',
        'imageUrl': _hb4,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 30,
        'sizes': ['One Size'],
        'colors': ['Natural', 'Black Trim', 'Pink Trim'],
      },
      {
        'name': 'Structured Top-Handle Bag',
        'description':
            'Classic structured satchel with top handle and detachable shoulder strap.',
        'price': 75.00,
        'category': 'Hand Bag',
        'imageUrl': _hb5,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 18,
        'sizes': ['One Size'],
        'colors': ['Black', 'Burgundy', 'Navy'],
      },
      {
        'name': 'Velvet Evening Clutch',
        'description':
            'Luxurious velvet evening clutch with jewelled clasp — the perfect formal accessory.',
        'price': 45.00,
        'category': 'Hand Bag',
        'imageUrl': _hb6,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 22,
        'sizes': ['One Size'],
        'colors': ['Emerald', 'Burgundy', 'Navy', 'Black'],
      },
      {
        'name': 'Bucket Bag with Drawstring',
        'description':
            'Relaxed slouchy bucket bag in pebble-grain leather — roomy, chic and effortlessly cool.',
        'price': 58.00,
        'category': 'Hand Bag',
        'imageUrl': _hb7,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 20,
        'sizes': ['One Size'],
        'colors': ['Tan', 'Black', 'White'],
      },
      {
        'name': 'Backpack Shoulder Bag',
        'description':
            'Convertible backpack-to-shoulder bag — carry it your way for work or weekend.',
        'price': 69.00,
        'category': 'Hand Bag',
        'imageUrl': _hb8,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 15,
        'sizes': ['One Size'],
        'colors': ['Black', 'Grey', 'Navy'],
      },
      {
        'name': 'Flap Envelope Clutch',
        'description':
            'Sleek envelope clutch in smooth faux leather — minimalist and versatile.',
        'price': 30.00,
        'category': 'Hand Bag',
        'imageUrl': _hb9,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 28,
        'sizes': ['One Size'],
        'colors': ['Black', 'Gold', 'Silver', 'Red'],
      },
      {
        'name': 'Large Weekend Tote Bag',
        'description':
            'Oversized canvas weekend tote — fits everything for a day trip or gym session.',
        'price': 42.00,
        'category': 'Hand Bag',
        'imageUrl': _hb10,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 25,
        'sizes': ['One Size'],
        'colors': ['Natural', 'Black', 'Navy'],
      },

      // ══════════════════════════════════════
      // 7. MEN OFFICIAL (10 products)
      // ══════════════════════════════════════
      {
        'name': "Men's Formal Shirt – Classic Fit",
        'description':
            'Slim-fit formal cotton dress shirt with button-down collar — polished and professional.',
        'price': 28.00,
        'category': 'Men Official',
        'imageUrl': _om1,
        'thumbnailUrls': [_om2, _om3],
        'colorImages': {'White': _om1, 'Light Blue': _om2, 'Navy': _om3},
        'isFeatured': true,
        'stock': 50,
        'sizes': ['S', 'M', 'L', 'XL', 'XXL'],
        'colors': ['White', 'Light Blue', 'Navy'],
      },
      {
        'name': "Men's Business Suit",
        'description':
            'Two-piece tailored business suit in premium wool blend — sharp, structured and authoritative.',
        'price': 120.00,
        'category': 'Men Official',
        'imageUrl': _om2,
        'thumbnailUrls': [_om3],
        'colorImages': {'Charcoal': _om2, 'Navy': _om3, 'Black': _om4},
        'isFeatured': true,
        'stock': 15,
        'sizes': ['S', 'M', 'L', 'XL'],
        'colors': ['Charcoal', 'Navy', 'Black'],
      },
      {
        'name': "Men's Blazer",
        'description':
            'Unstructured linen blazer — smart-casual versatility for office and evening.',
        'price': 75.00,
        'category': 'Men Official',
        'imageUrl': _om3,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 20,
        'sizes': ['S', 'M', 'L', 'XL'],
        'colors': ['Navy', 'Grey', 'Beige'],
      },
      {
        'name': "Men's Dress Trousers",
        'description':
            'Flat-front slim dress trousers in stretch fabric — comfort and style for long office days.',
        'price': 42.00,
        'category': 'Men Official',
        'imageUrl': _om4,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 30,
        'sizes': ['28', '30', '32', '34', '36'],
        'colors': ['Black', 'Charcoal', 'Navy', 'Khaki'],
      },
      {
        'name': "Men's Office Polo Shirt",
        'description':
            'Smart piqué cotton polo shirt — the smart-casual option between a shirt and T-shirt.',
        'price': 22.00,
        'category': 'Men Official',
        'imageUrl': _om5,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 40,
        'sizes': ['S', 'M', 'L', 'XL', 'XXL'],
        'colors': ['White', 'Navy', 'Black', 'Grey'],
      },
      {
        'name': "Men's Waistcoat",
        'description':
            'Classic five-button waistcoat in fine wool blend — elevates any shirt-and-trouser combination.',
        'price': 55.00,
        'category': 'Men Official',
        'imageUrl': _om6,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 18,
        'sizes': ['S', 'M', 'L', 'XL'],
        'colors': ['Charcoal', 'Navy', 'Black'],
      },
      {
        'name': "Men's Kurta Shalwar",
        'description':
            'Traditional Pakistani kurta shalwar in soft cotton lawn — perfect for Eid and formal occasions.',
        'price': 35.00,
        'category': 'Men Official',
        'imageUrl': _om7,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 25,
        'sizes': ['S', 'M', 'L', 'XL', 'XXL'],
        'colors': ['White', 'Off-White', 'Light Blue', 'Grey'],
      },
      {
        'name': "Men's Sherwani",
        'description':
            'Regal embroidered sherwani for weddings and formal events — the pinnacle of South Asian menswear.',
        'price': 180.00,
        'category': 'Men Official',
        'imageUrl': _om8,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': true,
        'stock': 10,
        'sizes': ['S', 'M', 'L', 'XL'],
        'colors': ['Ivory', 'Charcoal', 'Navy', 'Black'],
      },
      {
        'name': "Men's Oxford Dress Shoes",
        'description':
            'Classic Oxford brogues in genuine leather — the foundation of every formal wardrobe.',
        'price': 85.00,
        'category': 'Men Official',
        'imageUrl': _om9,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 20,
        'sizes': ['40', '41', '42', '43', '44', '45'],
        'colors': ['Black', 'Brown', 'Tan'],
      },
      {
        'name': "Men's Formal Leather Belt",
        'description':
            'Genuine leather dress belt with brushed silver buckle — the finishing touch to any formal outfit.',
        'price': 28.00,
        'category': 'Men Official',
        'imageUrl': _om10,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 35,
        'sizes': ['S (28–32)', 'M (32–36)', 'L (36–40)', 'XL (40–44)'],
        'colors': ['Black', 'Brown'],
      },

      // ══════════════════════════════════════
      // 8. OFFICIAL WEAR - Women (10 products)
      // ══════════════════════════════════════
      {
        'name': 'Professional Summer Blazer Outfit',
        'description':
            'Lightweight blazer with matching trousers — office-ready yet breathable for summer.',
        'price': 75.00,
        'category': 'Official Wear',
        'imageUrl': _of1,
        'thumbnailUrls': [_of1w, _of2],
        'colorImages': {'White': _of1, 'Beige': _of1w, 'Navy': _of2},
        'isFeatured': true,
        'stock': 30,
        'sizes': ['XS', 'S', 'M', 'L', 'XL'],
        'colors': ['White', 'Beige', 'Navy'],
      },
      {
        'name': 'Elegant Business Formal Outfit',
        'description':
            'Elegant formal outfit for classy women. Structured blazer with slim-cut trousers.',
        'price': 95.00,
        'category': 'Official Wear',
        'imageUrl': _of2,
        'thumbnailUrls': [_of2w],
        'colorImages': {'Black': _of2, 'Navy': _of2w},
        'isFeatured': false,
        'stock': 20,
        'sizes': ['XS', 'S', 'M', 'L', 'XL'],
        'colors': ['Black', 'Navy', 'Charcoal'],
      },
      {
        'name': 'Business Casual Jeans Outfit',
        'description':
            'Smart dark jeans with tailored blazer — business casual done right.',
        'price': 55.00,
        'category': 'Official Wear',
        'imageUrl': _of3,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 25,
        'sizes': ['XS', 'S', 'M', 'L', 'XL'],
        'colors': ['Blue Denim', 'Black', 'White'],
      },
      {
        'name': 'Meetings & Conferences Blazer',
        'description':
            'Polished double-breasted blazer for meetings and conferences.',
        'price': 85.00,
        'category': 'Official Wear',
        'imageUrl': _of4,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 18,
        'sizes': ['XS', 'S', 'M', 'L', 'XL'],
        'colors': ['Black', 'Camel', 'Grey'],
      },
      {
        'name': 'Classy Formal Women Outfit',
        'description':
            'The complete elevated workwear look — business meets fashion for the classy professional.',
        'price': 78.00,
        'category': 'Official Wear',
        'imageUrl': _of5,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 22,
        'sizes': ['XS', 'S', 'M', 'L'],
        'colors': ['Navy', 'Black', 'Blush'],
      },
      {
        'name': 'Sharp Women Pantsuit',
        'description':
            'Sharp tailored pantsuit for women — clean lines, professional and empowering.',
        'price': 112.00,
        'category': 'Official Wear',
        'imageUrl': _of6,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 14,
        'sizes': ['XS', 'S', 'M', 'L', 'XL'],
        'colors': ['Black', 'White', 'Beige'],
      },
      {
        'name': 'Silk-Look Formal Blouse',
        'description':
            'Elegant silk-look formal blouse — pairs with skirts, trousers or jeans.',
        'price': 32.00,
        'category': 'Official Wear',
        'imageUrl': _of7,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 35,
        'sizes': ['XS', 'S', 'M', 'L'],
        'colors': ['White', 'Black', 'Blush', 'Navy'],
      },
      {
        'name': 'Classic Fitted Pencil Skirt',
        'description':
            "Lined high-waisted pencil skirt — the cornerstone of professional women's wardrobes.",
        'price': 42.00,
        'category': 'Official Wear',
        'imageUrl': _of8,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 28,
        'sizes': ['XS', 'S', 'M', 'L', 'XL'],
        'colors': ['Black', 'Navy', 'Grey', 'Red'],
      },
      {
        'name': 'Business Casual Complete Set',
        'description':
            'The complete business casual outfit set — relaxed yet polished.',
        'price': 68.00,
        'category': 'Official Wear',
        'imageUrl': _of9,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 20,
        'sizes': ['XS', 'S', 'M', 'L', 'XL'],
        'colors': ['Beige', 'Cream', 'Light Grey'],
      },
      {
        'name': 'Classy Midi Formal Dress',
        'description':
            'Elegant midi dress for important office events and presentations.',
        'price': 88.00,
        'category': 'Official Wear',
        'imageUrl': _of10,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 16,
        'sizes': ['XS', 'S', 'M', 'L', 'XL'],
        'colors': ['Black', 'Navy', 'Deep Plum'],
      },

      // ══════════════════════════════════════
      // 9. ACCESSORIES / JUMKA (5 products)
      // ══════════════════════════════════════
      {
        'name': 'Party Wear Jumka – Gold',
        'description':
            'Traditional gold-tone jumka earrings with intricate filigree work — festive favourite.',
        'price': 19.99,
        'category': 'Accessories',
        'imageUrl': _j1,
        'thumbnailUrls': [_j2, _j2w],
        'colorImages': {'Gold': _j1, 'Silver': _j2, 'Rose Gold': _j2w},
        'isFeatured': true,
        'stock': 40,
        'sizes': ['One Size'],
        'colors': ['Gold', 'Silver', 'Rose Gold'],
      },
      {
        'name': 'Oxidised Silver Jumka',
        'description':
            'Boho-chic oxidised silver jumka with dangling beads — adds ethnic flair to any outfit.',
        'price': 14.99,
        'category': 'Accessories',
        'imageUrl': _j2,
        'thumbnailUrls': [_j2w],
        'colorImages': {'Silver': _j2, 'Alt': _j2w},
        'isFeatured': false,
        'stock': 35,
        'sizes': ['One Size'],
        'colors': ['Oxidised Silver'],
      },
      {
        'name': 'Kundan Stone Jumka Set',
        'description':
            'Elegant kundan stone-studded jumka earrings — bridal and festive favourite.',
        'price': 24.99,
        'category': 'Accessories',
        'imageUrl': _j3,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 25,
        'sizes': ['One Size'],
        'colors': ['Gold/Red', 'Gold/Green', 'Gold/Blue'],
      },
      {
        'name': 'Pearl Drop Jumka',
        'description':
            'Delicate freshwater pearl drop jumka — sophisticated for office or evening.',
        'price': 29.99,
        'category': 'Accessories',
        'imageUrl': _j4,
        'thumbnailUrls': [_j1],
        'colorImages': {'Gold': _j4, 'Silver': _j1},
        'isFeatured': false,
        'stock': 20,
        'sizes': ['One Size'],
        'colors': ['Gold/Pearl', 'Silver/Pearl'],
      },
      {
        'name': 'Enamel Floral Jumka',
        'description':
            'Colourful enamel floral jumka — cheerful and vibrant for daytime ethnic looks.',
        'price': 12.99,
        'category': 'Accessories',
        'imageUrl': _j2w,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 45,
        'sizes': ['One Size'],
        'colors': ['Multi', 'Red/Gold', 'Blue/Gold'],
      },

      // ══════════════════════════════════════
      // 10. LADIES HEELS (10 products)
      // ══════════════════════════════════════
      {
        'name': 'Classic Stiletto Heels',
        'description':
            'Timeless pointed-toe stiletto heels in patent leather — instantly elevates any outfit.',
        'price': 55.00,
        'category': 'Ladies Heels',
        'imageUrl': _h1,
        'thumbnailUrls': [_h2, _h3],
        'colorImages': {'Black': _h1, 'Nude': _h2, 'Red': _h3},
        'isFeatured': true,
        'stock': 25,
        'sizes': ['36', '37', '38', '39', '40'],
        'colors': ['Black', 'Nude', 'Red'],
      },
      {
        'name': 'Fashionable Party Heels',
        'description':
            'Party-wear block heels with embellished ankle strap — comfortable enough to dance the night away.',
        'price': 45.00,
        'category': 'Ladies Heels',
        'imageUrl': _h2,
        'thumbnailUrls': [_h4],
        'colorImages': {'Gold': _h2, 'Silver': _h4},
        'isFeatured': false,
        'stock': 20,
        'sizes': ['36', '37', '38', '39', '40'],
        'colors': ['Gold', 'Silver', 'Rose Gold'],
      },
      {
        'name': 'Strappy Sandal Heels',
        'description':
            'Open-toe strappy sandal heels — the ultimate summer party favourite.',
        'price': 42.00,
        'category': 'Ladies Heels',
        'imageUrl': _h3,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 30,
        'sizes': ['36', '37', '38', '39', '40'],
        'colors': ['Nude', 'Black', 'White'],
      },
      {
        'name': 'Platform Block Heels',
        'description':
            'Chunky platform block heels with square toe — retro-inspired comfort with modern flair.',
        'price': 60.00,
        'category': 'Ladies Heels',
        'imageUrl': _h4,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 22,
        'sizes': ['36', '37', '38', '39', '40', '41'],
        'colors': ['Black', 'White', 'Beige'],
      },
      {
        'name': 'Kitten Heels – Office Chic',
        'description':
            'Low kitten heels with pointed toe — elegant and comfortable for all-day office wear.',
        'price': 38.00,
        'category': 'Ladies Heels',
        'imageUrl': _h5,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 28,
        'sizes': ['36', '37', '38', '39', '40'],
        'colors': ['Black', 'Nude', 'Navy'],
      },
      {
        'name': 'Mule Heels – Slip On',
        'description':
            'Backless slip-on mule heels — effortlessly chic for brunch, shopping or a night out.',
        'price': 48.00,
        'category': 'Ladies Heels',
        'imageUrl': _h6,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 20,
        'sizes': ['36', '37', '38', '39', '40'],
        'colors': ['White', 'Black', 'Blush'],
      },
      {
        'name': 'Ankle Strap Court Heels',
        'description':
            'Mid-height court heels with buckle ankle strap — supportive, stylish and all-occasion ready.',
        'price': 52.00,
        'category': 'Ladies Heels',
        'imageUrl': _h7,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 25,
        'sizes': ['36', '37', '38', '39', '40'],
        'colors': ['Black', 'Nude', 'Red', 'White'],
      },
      {
        'name': 'Knee-High Heeled Boots',
        'description':
            'Sleek knee-high heeled boots in faux suede — power dressing from ankle to knee.',
        'price': 85.00,
        'category': 'Ladies Heels',
        'imageUrl': _h8,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 15,
        'sizes': ['36', '37', '38', '39', '40', '41'],
        'colors': ['Black', 'Brown', 'Grey'],
      },
      {
        'name': 'Wedge Espadrille Heels',
        'description':
            'Summer wedge espadrille with jute sole — casual-chic for warm-weather outings.',
        'price': 39.00,
        'category': 'Ladies Heels',
        'imageUrl': _h9,
        'thumbnailUrls': [],
        'colorImages': {},
        'isFeatured': false,
        'stock': 30,
        'sizes': ['36', '37', '38', '39', '40'],
        'colors': ['Natural', 'Black', 'Navy'],
      },
      {
        'name': 'Embellished Bridal Heels',
        'description':
            'Crystal-embellished bridal heels — the fairytale shoe for your special day.',
        'price': 72.00,
        'category': 'Ladies Heels',
        'imageUrl': _h12,
        'thumbnailUrls': [_h10, _h11],
        'colorImages': {'Ivory': _h12, 'Gold': _h10, 'Silver': _h11},
        'isFeatured': true,
        'stock': 12,
        'sizes': ['36', '37', '38', '39', '40'],
        'colors': ['Ivory', 'Gold', 'Silver'],
      },
    ];

    int count = 0;
    final total = products.length;
    for (final p in products) {
      await FirestoreService.addProduct(
        name: p['name'] as String,
        description: p['description'] as String,
        price: p['price'] as num,
        category: p['category'] as String,
        imageUrl: p['imageUrl'] as String,
        thumbnailUrls: List<String>.from(p['thumbnailUrls'] as List? ?? []),
        colorImages: Map<String, String>.from(
          ((p['colorImages'] as Map?) ?? {})
              .map((k, v) => MapEntry(k.toString(), v.toString())),
        ),
        isFeatured: p['isFeatured'] as bool,
        stock: p['stock'] as int,
        sizes: List<String>.from(p['sizes'] as List),
        colors: List<String>.from(p['colors'] as List),
      );
      count++;
      onProgress?.call(count, total);
    }

    print('✅ Seeding complete — $count products added to Firestore.');
  }
}
