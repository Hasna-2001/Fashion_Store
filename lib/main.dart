import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'mr_theme.dart';
import 'screens/home.dart';
import 'screens/login.dart';

void main() async {
  print('🔵 Step 1: WidgetsFlutterBinding');
  WidgetsFlutterBinding.ensureInitialized();

  print('🔵 Step 2: Firebase initializing...');
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('✅ Step 3: Firebase initialized successfully');
  } catch (e) {
    print('❌ Firebase error: $e');
  }

  print('🔵 Step 4: Running app...');
  runApp(const HSFashionApp());
}

class HSFashionApp extends StatelessWidget {
  const HSFashionApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('🔵 Step 5: HSFashionApp building...');
    return MaterialApp(
      title: 'HS Fashion Store',
      debugShowCheckedModeBanner: false,
      theme: MR.theme,
      home: const _AuthGate(),
    );
  }
}

class _AuthGate extends StatelessWidget {
  const _AuthGate();

  @override
  Widget build(BuildContext context) {
    print('🔵 Step 6: AuthGate building...');
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        print('🔵 Step 7: StreamBuilder state: ${snapshot.connectionState}');

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }

        if (snapshot.hasData) return const HomePage();
        return LoginScreen();
      },
    );
  }
}
