import 'dart:math' as math;

import 'package:complex_ui/components/WindowOfOpportunity.dart';
import 'package:complex_ui/components/circle.dart';
import 'package:flutter/material.dart';

import 'components/prediction.dart';
import 'components/shadowOfBox.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  static const restPosition = Offset(0, -0.15);
  double wobble = 0.0;
  Offset tapPosition = Offset.zero;
  String prediction = predictions[0];
  late AnimationController controller;
  late Animation animation;
  static const lightSource = Offset(0, -0.75);
  final innerShadowWidth = lightSource.distance * 0.1;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        reverseDuration: const Duration(milliseconds: 1500));
    controller.addListener(() => setState(() {}));
    animation = CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
        reverseCurve: Curves.elasticIn);
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final windowPosition =
        Offset.lerp(restPosition, tapPosition, animation.value)!;
    final size = Size.square(MediaQuery.of(context).size.shortestSide);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("The Magic 8 Ball"),
          centerTitle: true,
          backgroundColor: Colors.cyan,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                children: [
                  ShadowForBall(diameter: size.shortestSide),
                  GestureDetector(
                    onPanEnd: (_) => _end(),
                    onPanStart: (details) =>
                        _start(details.localPosition, size),
                    onPanUpdate: (details) =>
                        _update(details.localPosition, size),
                    child: Circle(
                      diameter: size.longestSide,
                      lightSource: lightSource,
                      child: Transform(
                        origin: size.center(Offset.zero),
                        transform: Matrix4.identity()
                          ..translate(windowPosition.dx * size.width / 2,
                              windowPosition.dy * size.height / 2)
                          ..rotateZ(windowPosition.direction)
                          ..rotateY(windowPosition.distance * math.pi / 2)
                          ..rotateZ(-windowPosition.direction)
                          ..scale(0.5 - 0.15 * windowPosition.distance),
                        child: WindowOfOpportunity(
                          innerShadowWidth: innerShadowWidth,
                          lightSource: lightSource - windowPosition,
                          child: Opacity(
                            opacity: 1 - controller.value,
                            child: Transform.rotate(
                              angle: wobble,
                              child: Prediction(
                                text: prediction,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              const Text(
                'Drag the Magic 8-Ball around\n'
                'while concentrating on\n'
                'the question you most\n'
                'want answered.\n\n'
                'Let go, and the oracle will\n'
                'give you an answer - of sorts!',
              )
            ],
          ),
        ),
      ),
    );
  }

  void _update(Offset position, Size size) {
    Offset offsetPosition = Offset(
      (2 * position.dx / size.width) - 1,
      (2 * position.dy / size.height) - 1,
    );
    if (offsetPosition.distance > 0.85) {
      offsetPosition = Offset.fromDirection(tapPosition.direction, 0.85);
    }
    setState(() => tapPosition = offsetPosition);
  }

  void _start(Offset offset, Size size) {
    controller.forward(from: 0);
    _update(offset, size);
  }

  void _end() {
    final rand = math.Random();
    prediction = predictions[rand.nextInt(predictions.length)];
    wobble = rand.nextDouble() * (wobble.isNegative ? 0.5 : -0.5);
    controller.reverse(from: 1);
  }
}
