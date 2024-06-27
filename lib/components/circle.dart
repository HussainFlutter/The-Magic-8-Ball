import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  const Circle(
      {super.key,
      required this.diameter,
      required this.lightSource,
      required this.child});
  final Offset lightSource;
  final Widget child;
  final double diameter;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(lightSource.dx, lightSource.dy),
          colors: const [Colors.grey, Colors.black],
        ),
        shape: BoxShape.circle,
      ),
      child: child,
    );
  }
}
