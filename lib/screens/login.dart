// lib/screens/login.dart
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../mr_theme.dart';
import 'home.dart';
import 'register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _loading = false, _obscure = true;

  Future<void> _login() async {
    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text.trim();
    if (email.isEmpty || pass.isEmpty) {
      _snack('Please enter email and password');
      return;
    }
    setState(() => _loading = true);
    final err = await AuthService.login(email, pass);
    if (!mounted) return;
    setState(() => _loading = false);
    if (err != null) {
      _snack(err);
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => const HomePage()));
    }
  }

  void _snack(String msg) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg, style: const TextStyle(color: MR.textMain)),
          backgroundColor: MR.surface2,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MR.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Brand
              ShaderMask(
                shaderCallback: (b) => MR.roseFade.createShader(b),
                child: const Text('HS Fashion Store',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1,
                    )),
              ),
              const SizedBox(height: 6),
              Container(
                width: 60,
                height: 2,
                decoration: BoxDecoration(
                  gradient: MR.goldFade,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 10),
              const Text('Welcome back!', style: MR.caption),
              const SizedBox(height: 48),

              _field(_emailCtrl, 'email@domain.com',
                  keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 14),
              _field(_passCtrl, 'Password',
                  obscure: _obscure,
                  suffix: IconButton(
                    icon: Icon(
                        _obscure
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        size: 20,
                        color: MR.textSub),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  )),

              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: MR.roseFade,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ElevatedButton(
                    onPressed: _loading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    child: _loading
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 2))
                        : const Text('Login',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600)),
                  ),
                ),
              ),

              const SizedBox(height: 24),
              GestureDetector(
                onTap: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const RegisterPage())),
                child: const Text.rich(TextSpan(
                  text: "Don't have an account? ",
                  style: MR.caption,
                  children: [
                    TextSpan(
                        text: 'Register',
                        style: TextStyle(
                            color: MR.rose, fontWeight: FontWeight.bold))
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(TextEditingController ctrl, String hint,
      {TextInputType? keyboardType, bool obscure = false, Widget? suffix}) {
    return TextField(
      controller: ctrl,
      keyboardType: keyboardType,
      obscureText: obscure,
      style: const TextStyle(color: MR.textMain),
      decoration: InputDecoration(hintText: hint, suffixIcon: suffix),
    );
  }
}
