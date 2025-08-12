import 'dart:math' as math;
import 'dart:ui' show lerpDouble;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomLoader extends StatefulWidget {
  const CustomLoader({
    super.key,
    this.size = 160,
    this.duration = const Duration(seconds: 2),
    this.trailAngle = 0.9,
    this.centerAsset = 'assets/icons/ic_icon.svg',
  });

  final double size;
  final Duration duration;
  final double trailAngle;
  final String centerAsset;

  @override
  State<CustomLoader> createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader>
    with TickerProviderStateMixin {
  late final AnimationController _spin =
  AnimationController(vsync: this, duration: widget.duration)..repeat();

  late final AnimationController _flash =
  AnimationController(vsync: this, duration: const Duration(milliseconds: 280));
  double _prevValue = 0.0;

  @override
  void initState() {
    super.initState();
    _spin.addListener(() {
      final v = _spin.value;
      // trigger flash at full turn
      if (v < _prevValue) {
        _flash
          ..reset()
          ..forward();
      }
      _prevValue = v;
    });
  }

  @override
  void dispose() {
    _spin.dispose();
    _flash.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size;
    final rocketSize = size * 0.16;
    final radius = size * 0.42;

    return SizedBox(
      width: size,
      height: size,
      child: AnimatedBuilder(
        animation: Listenable.merge([_spin, _flash]),
        builder: (_, __) {
          final angle = _spin.value * 2 * math.pi;
          return Stack(
            alignment: Alignment.center,
            children: [
              _GlowRing(size: size),
              CustomPaint(
                size: Size.square(size),
                painter: _TrailPainter(
                  angle: angle,
                  radius: radius,
                  trailAngle: widget.trailAngle,
                ),
              ),
              _FlashBurst(
                size: size,
                radius: radius,
                flashProgress: _flash.value,
                flashAngle: -math.pi / 2,
              ),
              _BreathingLogo(
                asset: widget.centerAsset,
                size: size * 0.54,
              ),
              _OrbitingRocket(
                angle: angle,
                radius: radius,
                size: rocketSize,
              ),
            ],
          );
        },
      ),
    );
  }
}

class _GlowRing extends StatelessWidget {
  const _GlowRing({required this.size});
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE11D48).withValues(alpha: 0.18),
              blurRadius: 28,
              spreadRadius: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class _BreathingLogo extends StatefulWidget {
  const _BreathingLogo({required this.asset, required this.size});
  final String asset;
  final double size;

  @override
  State<_BreathingLogo> createState() => _BreathingLogoState();
}

class _BreathingLogoState extends State<_BreathingLogo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _breath = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _breath.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _breath,
      builder: (_, child) {
        final scale = 1 + 0.04 * math.sin(_breath.value * 2 * math.pi);
        return Transform.scale(scale: scale, child: child);
      },
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: SvgPicture.asset(widget.asset),
      ),
    );
  }
}

class _OrbitingRocket extends StatelessWidget {
  const _OrbitingRocket({
    required this.angle,
    required this.radius,
    required this.size,
  });

  final double angle;
  final double radius;
  final double size;

  @override
  Widget build(BuildContext context) {
    final cx = radius * math.cos(angle);
    final cy = radius * math.sin(angle);

    return Transform.translate(
      offset: Offset(cx, cy),
      child: Transform.rotate(
        angle: angle + math.pi / 2,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: -size * 0.18,
              child: Container(
                width: size * 0.25,
                height: size * 0.25,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFFFFE066).withValues(alpha: 0.9),
                      const Color(0xFFFF6B6B).withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ),
            const Icon(
              Icons.rocket_launch_rounded,
              color: Color(0xFFE11D48),
              size: 24, // will be scaled below
            ),
            // keep icon size consistent with `size`
            SizedBox(width: size, height: size),
          ],
        ),
      ),
    );
  }
}

class _TrailPainter extends CustomPainter {
  _TrailPainter({
    required this.angle,
    required this.radius,
    required this.trailAngle,
  });

  final double angle;
  final double radius;
  final double trailAngle;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    const count = 28;
    for (int i = 0; i < count; i++) {
      final t = i / (count - 1);
      final a = angle - t * trailAngle;
      final p = Offset(
        center.dx + radius * math.cos(a),
        center.dy + radius * math.sin(a),
      );

      final opacity = (1.0 - t) * 0.85;
      final sz = (lerpDouble(7, 2, t) ?? 2).toDouble();
      final color = Color.lerp(
        const Color(0xFFFFE066),
        const Color(0xFFE11D48),
        math.min(1.0, t + 0.15),
      )!.withValues(alpha: opacity);

      final paint = Paint()
        ..color = color
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

      canvas.drawCircle(p, sz / 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _TrailPainter oldDelegate) {
    return oldDelegate.angle != angle ||
        oldDelegate.radius != radius ||
        oldDelegate.trailAngle != trailAngle;
  }
}

class _FlashBurst extends StatelessWidget {
  const _FlashBurst({
    required this.size,
    required this.radius,
    required this.flashProgress,
    required this.flashAngle,
  });

  final double size;
  final double radius;
  final double flashProgress; // 0..1
  final double flashAngle;

  @override
  Widget build(BuildContext context) {
    if (flashProgress <= 0) return const SizedBox.shrink();

    final center = Offset(size / 2, size / 2);
    final focus = Offset(
      center.dx + radius * math.cos(flashAngle),
      center.dy + radius * math.sin(flashAngle),
    );

    final r =
    lerpDouble(0, size * 0.18, Curves.easeOut.transform(flashProgress))!;
    final opacity = (1 - flashProgress) * 0.8;

    return CustomPaint(
      size: Size.square(size),
      painter: _BurstPainter(center: focus, radius: r, opacity: opacity),
    );
  }
}

class _BurstPainter extends CustomPainter {
  _BurstPainter({
    required this.center,
    required this.radius,
    required this.opacity,
  });
  final Offset center;
  final double radius;
  final double opacity;

  @override
  void paint(Canvas canvas, Size size) {
    final gradient = RadialGradient(
      colors: [
        const Color(0xFFFFE066).withValues(alpha: opacity),
        const Color(0xFFFF6B6B).withValues(alpha: opacity * 0.6),
        Colors.transparent,
      ],
      stops: const [0.0, 0.55, 1.0],
    );
    final rect = Rect.fromCircle(center: center, radius: radius);
    final paint = Paint()..shader = gradient.createShader(rect);
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _BurstPainter oldDelegate) {
    return oldDelegate.radius != radius ||
        oldDelegate.opacity != opacity ||
        oldDelegate.center != center;
  }
}
