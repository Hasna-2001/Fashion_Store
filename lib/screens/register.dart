// lib/screens/register.dart
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../mr_theme.dart';
import 'home.dart';
import 'login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _loading = false, _obscure = true;

  Future<void> _register() async {
    final email = _emailCtrl.text.trim();
    final pass = _passCtrl.text.trim();
    if (email.isEmpty || pass.isEmpty) {
      _snack('Please enter email and password');
      return;
    }
    setState(() => _loading = true);
    final err = await AuthService.register(email, pass);
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Top label
              const Text('Sign up', style: MR.caption),
              const SizedBox(height: 48),

              // Brand
              Center(
                child: Column(
                  children: [
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
                    const SizedBox(height: 4),
                    Container(
                      width: 60,
                      height: 2,
                      decoration: BoxDecoration(
                        gradient: MR.goldFade,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),
              const Center(child: Text('Create an account', style: MR.h2)),
              const SizedBox(height: 8),
              const Center(
                child: Text('Enter your email to sign up',
                    style: MR.caption, textAlign: TextAlign.center),
              ),
              const SizedBox(height: 30),

              // Fields
              _field(_emailCtrl, 'email@domain.com',
                  keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 14),
              _field(_passCtrl, 'Password (min 6 characters)',
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

              const SizedBox(height: 20),

              // Continue button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: MR.roseFade,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ElevatedButton(
                    onPressed: _loading ? null : _register,
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
                        : const Text('Continue',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600)),
                  ),
                ),
              ),

              const SizedBox(height: 28),
              Row(children: [
                Expanded(child: Divider(color: MR.divider)),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Text('or', style: MR.caption)),
                Expanded(child: Divider(color: MR.divider)),
              ]),
              const SizedBox(height: 28),

              _socialBtn(_googleIcon(), 'Continue with Google', _register),
              const SizedBox(height: 12),
              _socialBtn(const Icon(Icons.apple, size: 22, color: MR.textMain),
                  'Continue with Apple', _register),

              const SizedBox(height: 28),
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => LoginScreen())),
                  child: const Text.rich(TextSpan(
                    text: 'Already have an account? ',
                    style: MR.caption,
                    children: [
                      TextSpan(
                          text: 'Login',
                          style: TextStyle(
                              color: MR.rose, fontWeight: FontWeight.bold))
                    ],
                  )),
                ),
              ),

              const SizedBox(height: 36),
              Center(
                child: Text.rich(
                  TextSpan(
                    style: const TextStyle(fontSize: 11, color: MR.textSub),
                    children: const [
                      TextSpan(text: 'By continuing, you agree to our '),
                      TextSpan(
                          text: 'Terms of Service',
                          style: TextStyle(
                              color: MR.blush, fontWeight: FontWeight.bold)),
                      TextSpan(text: ' and '),
                      TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                              color: MR.blush, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 28),
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
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: suffix,
      ),
    );
  }

  Widget _socialBtn(Widget icon, String label, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: MR.divider),
          backgroundColor: MR.surface2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          icon,
          const SizedBox(width: 10),
          Text(label,
              style: const TextStyle(
                  color: MR.textMain,
                  fontWeight: FontWeight.w600,
                  fontSize: 14))
        ]),
      ),
    );
  }

  Widget _googleIcon() => SizedBox(
      width: 22, height: 22, child: CustomPaint(painter: _GooglePainter()));
}

class _GooglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2, cy = size.height / 2, r = size.width / 2;
    const colors = [
      Color(0xFF4285F4),
      Color(0xFF34A853),
      Color(0xFFFBBC05),
      Color(0xFFEA4335)
    ];
    for (int i = 0; i < 4; i++) {
      canvas.drawArc(
          Rect.fromCircle(center: Offset(cx, cy), radius: r),
          (i * 90 - 45) * (3.14159 / 180),
          90 * (3.14159 / 180),
          true,
          Paint()..color = colors[i]);
    }
    canvas.drawCircle(Offset(cx, cy), r * 0.6, Paint()..color = const Color(0xFFF0E9DC));
    canvas.drawRect(Rect.fromLTWH(cx, cy - r * 0.13, r * 0.98, r * 0.26),
        Paint()..color = const Color(0xFF4285F4));
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}