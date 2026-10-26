import 'dart:ui' as ui;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class ChefCardComponent extends PositionComponent with TapCallbacks {
  final String asset;
  final String cardName;
  final void Function(ChefCardComponent card) onTap;
  ui.Image? svgImage;

  bool _isPressed = false;
  double _scale = 1.0;
  double _scaleTarget = 1.0;
  static const double _scaleSpeed = 8.0;

  ChefCardComponent({
    required this.asset,
    required this.cardName,
    required super.position,
    required super.size,
    required this.onTap,
    this.svgImage,
  });

  @override
  void update(double dt) {
    super.update(dt);

    if ((_scale - _scaleTarget).abs() > 0.001) {
      _scale += (_scaleTarget - _scale) * _scaleSpeed * dt;
    } else {
      _scale = _scaleTarget;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final actualWidth = size.x * _scale;
    final actualHeight = size.y * _scale;
    final offsetX = (size.x - actualWidth) / 2;
    final offsetY = (size.y - actualHeight) / 2;

    final rect = Rect.fromLTWH(offsetX, offsetY, actualWidth, actualHeight);
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(8));

    final bgPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawRRect(rrect, bgPaint);

    final borderPaint = Paint()
      ..color = const Color(0xFFD84315)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(rrect, borderPaint);

    if (svgImage != null) {
      _drawCardImage(canvas, rrect);
    } else {
      _drawPlaceholder(canvas, rrect);
    }
  }

  void _drawCardImage(Canvas canvas, RRect rrect) {
    final img = svgImage!;
    final padding = rrect.width * 0.08;
    final destRect = Rect.fromLTWH(
      rrect.left + padding,
      rrect.top + padding,
      rrect.width - padding * 2,
      rrect.height - padding * 2,
    );
    final srcRect = Rect.fromLTWH(
      0,
      0,
      img.width.toDouble(),
      img.height.toDouble(),
    );
    canvas.drawImageRect(img, srcRect, destRect, Paint());
  }

  void _drawPlaceholder(Canvas canvas, RRect rrect) {
    // Show card rank from filename
    final parts = asset.replaceAll('.svg', '').split('_of_');
    final rank = parts.isNotEmpty ? parts[0].toUpperCase() : '?';

    final textPainter = TextPainter(
      text: TextSpan(
        text: rank,
        style: TextStyle(
          fontSize: rrect.width * 0.25,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        rrect.center.dx - textPainter.width / 2,
        rrect.center.dy - textPainter.height / 2,
      ),
    );
  }

  @override
  void onTapDown(TapDownEvent event) {
    _isPressed = true;
    _scaleTarget = 0.9;
  }

  @override
  void onTapUp(TapUpEvent event) {
    _isPressed = false;
    _scaleTarget = 1.0;
    onTap(this);
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    _isPressed = false;
    _scaleTarget = 1.0;
  }
}
