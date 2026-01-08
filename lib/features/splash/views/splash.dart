import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get440_test_app/components/get440button.dart';
import 'package:go_router/go_router.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: height * 0.95,
            child: CustomPaint(
              painter: SprayPainter(color: const Color(0xFFF77A11)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SlideTransition(
              position: _slideAnimation,
              child: Image.asset(
                "assets/images/splash_hoodie.jpeg",
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Positioned(
            bottom: 32,
            left: 24,
            right: 24,
            child: Get440button(
              cta: "Take a tour",
              onPressed: () {
                context.push("/home");
              },
              isLoading: false,
            ),
          ),
        ],
      ),
    );
  }
}

class SprayPainter extends CustomPainter {
  final Color color;
  final int density;

  SprayPainter({required this.color, this.density = 140});

  @override
  void paint(Canvas canvas, Size size) {
    final random = Random(99);

    for (int i = 0; i < density; i++) {
      final paint = Paint()
        ..color = color.withOpacity(random.nextDouble() * 0.55)
        ..maskFilter = MaskFilter.blur(
          BlurStyle.normal,
          random.nextDouble() * 25 + 10,
        );

      final dx = random.nextDouble() * size.width;
      final dy = random.nextDouble() * size.height * 0.7;
      final radius = random.nextDouble() * 15 + 8;

      canvas.drawCircle(Offset(dx, dy), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
