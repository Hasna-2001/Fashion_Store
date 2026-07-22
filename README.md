# 👗 HS Fashion Store

A cross-platform **Flutter** fashion e-commerce app with a **Firebase** backend (Auth + Firestore + Storage). Browse products by category, view details, manage a cart and wishlist, checkout, and track past orders — with a responsive UI that runs on **mobile, web, and desktop**.

> Built as a university coursework project (Semester 4), showcasing full-stack mobile app development with Flutter and Firebase.

---

## ✨ Features

- **Authentication** — Email/password sign up & login via Firebase Auth, with friendly error messages (weak password, wrong credentials, email already in use, etc.)
- **Product Catalog** — Products streamed live from Firestore, browsable by category (Bridal, Make-up Kit, Casual Sneakers, Sunglasses, Hand Bag, Silk Scarf, Jumka, Men Official, Ladies Heels, and more)
- **Featured Products & Deals** — Highlighted/on-sale items on the home screen
- **Product Details** — Full product view with images, description, and pricing
- **Cart** — Add, update, and remove items with live cart state
- **Wishlist** — Save favorite products for later
- **Recently Viewed** — Automatically tracks and displays recently browsed products
- **Checkout** — Delivery details form and order placement flow
- **Order History** — View past orders tied to the signed-in user
- **User Profile** — View and manage account/profile info
- **Responsive UI** — Custom theme (`MR.theme`) that adapts across mobile, web, and desktop layouts

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Framework | [Flutter](https://flutter.dev) (Dart) |
| Backend / Auth | [Firebase Auth](https://firebase.google.com/docs/auth) |
| Database | [Cloud Firestore](https://firebase.google.com/docs/firestore) |
| Storage | [Firebase Storage](https://firebase.google.com/docs/storage) |
| Image Loading | `cached_network_image` |
| Platforms | Android, iOS, Web, Windows, macOS, Linux |

---

## 📂 Project Structure

```
lib/
├── main.dart                    # App entry point + Firebase init + auth gate
├── firebase_options.dart        # Firebase platform config (FlutterFire CLI generated)
├── mr_theme.dart                 # App-wide theme
├── models/
│   ├── cart_model.dart
│   └── wishlist_manager.dart
├── screens/
│   ├── home.dart
│   ├── login.dart
│   ├── register.dart
│   ├── product_list.dart
│   ├── product_card.dart
│   ├── product_details.dart
│   ├── cart.dart
│   ├── checkout.dart
│   ├── orders.dart
│   ├── wishlist.dart
│   ├── recently_viewed.dart
│   └── profile.dart
├── services/
│   ├── auth_service.dart         # Firebase Auth wrapper
│   ├── firestore_service.dart    # Product/cart/order/profile queries
│   └── recently_viewed_service.dart
├── scripts/
│   └── seed_products.dart        # One-off script to seed Firestore with sample products
└── assets/                       # Product images (bridal, makeup, shoes, bags, etc.)
```

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Dart SDK `>=3.0.0 <4.0.0`)
- A [Firebase](https://console.firebase.google.com/) project
- [FlutterFire CLI](https://firebase.google.com/docs/flutter/setup) (to regenerate `firebase_options.dart` if setting up your own Firebase project)

### 1. Clone the repository

```bash
git clone https://github.com/Hasna-2001/Fashion_Store.git
cd Fashion_Store
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Set up Firebase

This project uses Firebase Auth, Firestore, and Storage. `lib/firebase_options.dart` and platform config files (`google-services.json` for Android, `GoogleService-Info.plist` for iOS) must correspond to your own Firebase project:

```bash
flutterfire configure
```

Then enable **Email/Password Authentication** in the Firebase console under **Authentication → Sign-in method**.

### 4. (Optional) Seed sample products

`lib/scripts/seed_products.dart` populates Firestore with sample products across categories. Run it once against your Firebase project to have data to browse.

### 5. Run the app

```bash
flutter run
```

To target a specific platform:

```bash
flutter run -d chrome     # Web
flutter run -d windows    # Windows desktop
flutter run -d macos      # macOS desktop
```

---

## 🔐 Firestore Structure (high level)

| Collection | Purpose |
|---|---|
| `products` | Product catalog — name, description, price, category, image, `isFeatured` flag |
| `users/{uid}` | User profile data |
| `users/{uid}/cart` | Per-user cart items |
| `users/{uid}/orders` | Per-user order history |
| `users/{uid}/wishlist` | Per-user saved/wishlisted products |

Access rules are defined in [`firestore.rules`](firestore.rules).

---

## 📱 Build

```bash
flutter build apk --release      # Android APK
flutter build web                # Web build
flutter build windows             # Windows desktop
```

---

## 🗺️ Roadmap

- [ ] Google Sign-In (scaffolded in `auth_service.dart`, not yet wired up)
- [ ] Payment gateway integration
- [ ] Order status tracking / notifications
- [ ] Admin panel for product management

---

## 👤 Author

**Hasna** — Flutter & Mobile App Development, University Coursework Project

---

## 📄 License

This project is for academic/educational purposes. Add a license of your choice if you intend to distribute it publicly.
