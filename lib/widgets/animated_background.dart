import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import 'dart:math';

class AnimatedBackground extends StatefulWidget {
  const AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<_Particle> _particles = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..addListener(() {
            setState(() {
              for (var p in _particles) {
                p.move();
              }
            });
          })
          ..repeat();

    // Initialize particles
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      for (int i = 0; i < 25; i++) {
        _particles.add(
          _Particle(
            x: _random.nextDouble() * size.width,
            y: _random.nextDouble() * size.height,
            vx: (_random.nextDouble() - 0.5) * 1.0,
            vy: (_random.nextDouble() - 0.5) * 1.0,
            radius: _random.nextDouble() * 1.5 + 0.5,
            color: AppColors.primary.withOpacity(
              _random.nextDouble() * 0.2 + 0.05,
            ),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: CustomPaint(
        size: Size.infinite,
        painter: _ParticlePainter(particles: _particles),
      ),
    );
  }
}

class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;

  _ParticlePainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    for (var p in particles) {
      if (p.x < 0) p.x = size.width;
      if (p.x > size.width) p.x = 0;
      if (p.y < 0) p.y = size.height;
      if (p.y > size.height) p.y = 0;

      final paint = Paint()..color = p.color;
      canvas.drawCircle(Offset(p.x, p.y), p.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _Particle {
  double x;
  double y;
  double vx;
  double vy;
  double radius;
  Color color;

  _Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.radius,
    required this.color,
  });

  void move() {
    x += vx;
    y += vy;
  }
}
