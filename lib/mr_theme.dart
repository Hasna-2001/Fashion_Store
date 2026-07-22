// lib/mr_theme.dart  ──  Champagne Garden Theme
// Warm cream + champagne beige + cognac — soft light mode, luxury boutique feel
import 'package:flutter/material.dart';

class MR {
  MR._();

  // ── Core palette ─────────────────────────────────────────────────────────────
  /// Page background — warm ivory/cream
  static const Color bg = Color(0xFFF7F2EA);

  /// Primary surface (cards, app bars) — soft champagne white
  static const Color surface = Color(0xFFFDFAF5);

  /// Secondary surface (inputs, chips, alt rows) — light beige
  static const Color surface2 = Color(0xFFF0E9DC);

  /// Divider / border — warm greige
  static const Color divider = Color(0xFFDDD3C2);

  // ── Accent — cognac rose (replaces the dark-mode rose/pink) ──────────────────
  /// Primary action colour — cognac-rose
  static const Color rose = Color(0xFFB5623E);

  /// Softer blush variant used for links / secondary accents
  static const Color blush = Color(0xFFC8845E);

  // ── Gold — warm amber/honey (slightly deeper for light-mode contrast) ─────────
  static const Color gold = Color(0xFF9A6B2E);

  // ── Text ─────────────────────────────────────────────────────────────────────
  /// Primary text — deep warm brown (replaces near-white)
  static const Color textMain = Color(0xFF2E1E10);

  /// Secondary / caption text — muted warm taupe
  static const Color textSub = Color(0xFF8A7260);

  // ── Gradients ────────────────────────────────────────────────────────────────
  /// Primary button / hero gradient — cognac → blush
  static const LinearGradient roseFade = LinearGradient(
    colors: [Color(0xFFB5623E), Color(0xFFD4906A)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  /// Gold accent gradient — amber → honey
  static const LinearGradient goldFade = LinearGradient(
    colors: [Color(0xFF9A6B2E), Color(0xFFC99A52)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  /// Subtle warm surface gradient (checkout summary card)
  static const LinearGradient surfaceFade = LinearGradient(
    colors: [Color(0xFFFDFAF5), Color(0xFFF0E9DC)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ── Text styles ──────────────────────────────────────────────────────────────
  static const TextStyle h2 = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.bold,
    color: textMain,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    color: textSub,
  );

  static const TextStyle price = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: rose,
  );

  // ── ThemeData ────────────────────────────────────────────────────────────────
  static ThemeData get theme => ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: bg,
        colorScheme: const ColorScheme.light(
          primary: rose,
          secondary: gold,
          background: bg,
          surface: surface,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onBackground: textMain,
          onSurface: textMain,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: bg,
          foregroundColor: textMain,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: textMain,
            letterSpacing: 0.5,
          ),
          iconTheme: IconThemeData(color: textMain),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: surface2,
          hintStyle: const TextStyle(color: textSub, fontSize: 14),
          labelStyle: const TextStyle(color: textSub),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: divider),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: rose, width: 1.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFCC3300)),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFCC3300), width: 1.5),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: MaterialStateProperty.resolveWith((states) =>
              states.contains(MaterialState.selected) ? rose : surface2),
          checkColor: MaterialStateProperty.all(Colors.white),
          side: const BorderSide(color: divider, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: rose,
            foregroundColor: Colors.white,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            textStyle:
                const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: textMain,
            side: const BorderSide(color: divider),
            backgroundColor: surface2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            textStyle:
                const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: surface,
          selectedItemColor: rose,
          unselectedItemColor: textSub,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          selectedLabelStyle:
              TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
        ),
        dividerTheme: const DividerThemeData(
          color: divider,
          space: 1,
          thickness: 1,
        ),
        cardTheme: CardThemeData(
          color: surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: divider),
          ),
          margin: const EdgeInsets.all(0),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: surface2,
          contentTextStyle: const TextStyle(color: textMain, fontSize: 13),
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        dialogTheme: DialogThemeData(
          backgroundColor: surface,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          titleTextStyle: const TextStyle(
              fontSize: 17, fontWeight: FontWeight.bold, color: textMain),
          contentTextStyle:
              const TextStyle(fontSize: 13, color: textSub, height: 1.5),
        ),
        progressIndicatorTheme: const ProgressIndicatorThemeData(color: rose),
      );
}
