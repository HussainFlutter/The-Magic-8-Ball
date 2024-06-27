import 'dart:math' as math;

import 'package:flutter/material.dart';

class ShadowForBall extends StatelessWidget {
  final double diameter;
  const ShadowForBall({super.key, required this.diameter});

  @override
  Widget build(BuildContext context) {
    return Transform(
      origin: Offset(0, diameter),
      transform: Matrix4.identity()..rotateX(math.pi / 2.1),
      child: Container(
        height: diameter,
        width: diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.8), blurRadius: 25),
          ],
        ),
      ),
    );
  }
}
