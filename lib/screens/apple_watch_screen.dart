import 'dart:math';

import 'package:flutter/material.dart';

class AppleWatchScreen extends StatefulWidget {
  const AppleWatchScreen({super.key});

  @override
  State<AppleWatchScreen> createState() => _AppleWatchScreenState();
}

class _AppleWatchScreenState extends State<AppleWatchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Apple Watch'),
      ),
      body: Center(
        child: CustomPaint(
          painter: AppleWatchPainter(),
          size: const Size(400, 400),
        ),
      ),
    );
  }
}

class AppleWatchPainter extends CustomPainter {
  // paint 메서드는 우리가 만드는 것을 색상으로 칠해줘
  // paint는 여러분이 마법을 부릴 장소야. 여러분이 그리고 싶은 모든 모양을 그릴거야.
  @override
  void paint(Canvas canvas, Size size) {
    // 바로 여긴 이건 그냥 모양일 뿐이야. 말 그대로 그냥 모양이야.
    final rect = Rect.fromLTWH(
      0,
      0,
      size.width,
      size.height,
    );

    // 이제 해야 할 일은 모양의 색상을 선택하는 거야.
    final paint = Paint()..color = Colors.blue;

    // canvas.drawRect(rect, paint);

    final circlePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      // ..style = PaintingStyle.fill
      ..strokeWidth = 20;

    // canvas.drawCircle(
    //   // Offset.zero,
    //   Offset(size.width / 2, size.width / 2),
    //   size.width / 2,
    //   circlePaint,
    // );

    final center = Offset(
      size.width / 2,
      size.width / 2,
    );

    // draw red
    final redCirclePaint = Paint()
      ..color = Colors.red.shade400.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    final redCircleRadius = (size.width / 2) * 0.9;

    canvas.drawCircle(
      center,
      redCircleRadius,
      redCirclePaint,
    );

    // draw green
    final greenCirclePaint = Paint()
      ..color = Colors.green.shade400.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    canvas.drawCircle(
      center,
      (size.width / 2) * 0.76,
      greenCirclePaint,
    );

    // draw blue
    final blueCirclePaint = Paint()
      ..color = Colors.cyan.shade400.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 25;

    canvas.drawCircle(
      center,
      (size.width / 2) * 0.62,
      blueCirclePaint,
    );

    // red arc
    final redArcRect = Rect.fromCircle(
      center: center,
      radius: redCircleRadius,
    );

    final redArcPaint = Paint()
      ..color = Colors.red.shade400
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 25;

    canvas.drawArc(
      redArcRect,
      -0.5 * pi,
      1.5 * pi,
      false,
      redArcPaint,
    );
  }

  // 이건 true 또는 false를 반환해야 하는 메서드야
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
