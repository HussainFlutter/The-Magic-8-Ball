// Copyright (c) 2021 Razeware LLC

// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without
// restriction, including without limitation the rights to use,
// copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom
// the Software is furnished to do so, subject to the following
// conditions:

// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.

// Notwithstanding the foregoing, you may not use, copy, modify,
// merge, publish, distribute, sublicense, create a derivative work,
// and/or sell copies of the Software in any work that is designed,
// intended, or marketed for pedagogical or instructional purposes
// related to programming, coding, application development, or
// information technology. Permission for such use, copying,
// modification, merger, publication, distribution, sublicensing,
// creation of derivative works, or sale is expressly withheld.

// This project and source code may use libraries or frameworks
// that are released under various Open-Source licenses. Use of
// those libraries and frameworks are governed by their own
// individual licenses.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
// DEALINGS IN THE SOFTWARE.

import 'dart:convert' show base64;

import 'package:flutter/material.dart';

/// A class that draws an 8-Ball predictive blue triangle containing text
class Prediction extends StatelessWidget {
  /// Default constructor
  const Prediction({super.key, required this.text});

  /// The text of the current prediction
  final String text;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TrianglePainter(),
      child: Container(
          alignment: Alignment.center,
          child: Text(text,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 30))),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  final _gradient =
      LinearGradient(colors: [Colors.blue.shade400, Colors.blue.shade900]);

  @override
  void paint(Canvas canvas, Size size) {
    final painter = Paint()
      ..shader = _gradient.createShader(Offset.zero & size)
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;
    final path = Path()
      ..moveTo(w * 0.2, h * 0.3)
      ..quadraticBezierTo(w * 0.5, h * 0.1, w * 0.8, h * 0.3)
      ..quadraticBezierTo(w * 0.85, h * 0.6, w * 0.5, h * 0.85)
      ..quadraticBezierTo(w * 0.15, h * 0.6, w * 0.2, h * 0.3)
      ..close();

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(_TrianglePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_TrianglePainter oldDelegate) => false;
}

/// 8-Ball predictions obfuscated so as not to spoil the fun
final List<String> predictions = String.fromCharCodes(base64
        .decode('QXMgSSBzZWUgaXQsDQp5ZXN8QXNrIGFnYWluDQpsYXRlcnxCZXR0ZXIgbm90'
            'DQp0ZWxsIHlvdQ0Kbm93fENhbm5vdA0KcHJlZGljdA0Kbm93fENvbmNlbnRy'
            'YXRlDQphbmQgYXNrDQphZ2FpbnxEb24ndCBjb3VudA0Kb24gaXR8SXQgaXMN'
            'CmNlcnRhaW58SXQgaXMNCmRlY2lkZWRseQ0Kc298TW9zdCBsaWtlbHl8TXkg'
            'cmVwbHkNCmlzIG5vfE15IHNvdXJjZXMNCnNheSBub3xOb3xPdXRsb29rDQpn'
            'b29kfE91dGxvb2sgbm90DQpzbyBnb29kfFJheSBXZW5kZXJsaWNoDQpoYXMg'
            'YSBjb3Vyc2UNCm9uIGl0fFJlcGx5IGhhenkgLQ0KdHJ5IGFnYWlufFNpZ25z'
            'DQpwb2ludCB0bw0KeWVzfEZsdXR0ZXIgaGFzDQp0aGUgYW5zd2VyfFZlcnkN'
            'CmRvdWJ0ZnVsfFdpdGhvdXQgYQ0KZG91YnR8WWVzfFllcywgZGVmaW5pdGVs'
            'eXxZb3UgbWF5DQpyZWx5IG9uDQppdA=='))
    .split('|');
