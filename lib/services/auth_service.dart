// lib/services/auth_service.dart
import 'package:firebase_auth/firebase_auth.dart';

/// AuthService – wraps FirebaseAuth for the HS Fashion Store app.
///
/// Supported methods:
///   • [register]  – creates a new account with email + password
///   • [login]     – signs in an existing account
///   • [logout]    – signs out the current user
///
/// Future enhancement (Phase 3):
///   • Google Sign-In via `google_sign_in` package:
///       final googleUser  = await GoogleSignIn().signIn();
///       final googleAuth  = await googleUser!.authentication;
///       final credential  = GoogleAuthProvider.credential(
///           accessToken: googleAuth.accessToken,
///           idToken:     googleAuth.idToken);
///       await FirebaseAuth.instance.signInWithCredential(credential);
class AuthService {
  static final _auth = FirebaseAuth.instance;

  /// The currently signed-in Firebase user, or null if not authenticated.
  static User? get currentUser => _auth.currentUser;

  /// Stream that emits whenever the auth state changes (sign-in / sign-out).
  static Stream<User?> get authStateChanges => _auth.authStateChanges();

  // ── Registration ─────────────────────────────────────────────────────────────

  /// Creates a new user with [email] and [password].
  /// Returns null on success, or a human-readable error message on failure.
  static Future<String?> register(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return null; // success
    } on FirebaseAuthException catch (e) {
      return _msg(e.code);
    }
  }

  // ── Login ────────────────────────────────────────────────────────────────────

  /// Signs in an existing user with [email] and [password].
  /// Returns null on success, or a human-readable error message on failure.
  static Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null; // success
    } on FirebaseAuthException catch (e) {
      return _msg(e.code);
    }
  }

  // ── Logout ───────────────────────────────────────────────────────────────────

  /// Signs out the currently authenticated user.
  static Future<void> logout() => _auth.signOut();

  // ── Error messages ───────────────────────────────────────────────────────────

  /// Maps a FirebaseAuth error [code] to a user-friendly message.
  ///
  /// Firebase v9+ collapses wrong-email and wrong-password into a single
  /// 'invalid-credential' code (or the legacy uppercase variant) to prevent
  /// user-enumeration attacks.  We handle both forms here.
  static String _msg(String code) {
    // Normalise — some SDK versions return SCREAMING_SNAKE_CASE
    final c = code.toLowerCase().replaceAll('_', '-');

    switch (c) {
      // ── Registration errors ──────────────────────────────────────────
      case 'email-already-in-use':
        return 'Email already registered. Please login.';
      case 'weak-password':
        return 'Password must be at least 6 characters.';

      // ── Login errors ────────────────────────────────────────────────
      //
      // Firebase v9+ returns 'invalid-credential' for BOTH wrong email
      // and wrong password (intentional — prevents user enumeration).
      // The legacy SDK returned 'user-not-found' / 'wrong-password'.
      // We map all of them to the same safe message.
      case 'invalid-credential':
      case 'invalid-login-credentials': // older SDK variant
      case 'user-not-found':
      case 'wrong-password':
        return 'Wrong email or password. Please check and try again.';

      // ── Shared errors ────────────────────────────────────────────────
      case 'invalid-email':
        return 'Invalid email address.';
      case 'too-many-requests':
        return 'Too many failed attempts. Please wait a moment and try again.';
      case 'user-disabled':
        return 'This account has been disabled. Please contact support.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      case 'operation-not-allowed':
        return 'Sign-in method not enabled. Please contact support.';
      default:
        return 'Something went wrong. Please try again.';
    }
  }
}
