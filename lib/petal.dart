import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:geometry_flower/color.dart';

class Petal extends PositionComponent {
  final Vector2 endLinePosition;
  final double minAngle;
  final double maxAngle;
  final double minLength;
  final double maxLength;

  double _angle = 20;
  double _length = 60;
  final Random _random = Random();
  final Path _path = Path();
  final Color _color = randomPetalColor();

  Petal({
    super.children,
    super.priority,
    super.key,
    required this.endLinePosition,
    this.minAngle = 10,
    this.maxAngle = 24,
    this.minLength = 55,
    this.maxLength = 60,
  }) : super(position: endLinePosition, anchor: Anchor.center);

  void _generatePetal() {
    _angle = _random.nextDoubleBetween(minAngle, maxAngle);
    _length = _random.nextDoubleBetween(minLength, maxLength);
    final len1 =
        _length +
        _random.nextDoubleBetween(0, 15) * (_random.nextBool() ? -1 : 1);
    final len2 =
        _length +
        _random.nextDoubleBetween(0, 15) * (_random.nextBool() ? -1 : 1);

    final double a = ((90.0 - _angle) / 2.0) * (pi / 180);
    final Vector2 oa = Vector2(len1 * cos(a), len2 * sin(a));
    final Vector2 ob = Vector2(
      len1 * cos(a + (_angle * (pi / 180))),
      len2 * sin(a + (_angle * (pi / 180))),
    );
    _path.reset();
    _path.moveTo(0, 0);
    _path.lineTo(oa.x, oa.y);
    _path.lineTo(ob.x, ob.y);
    _path.close();
  }

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    _generatePetal();
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()
      ..color = _color
      ..style = PaintingStyle.fill;
    canvas.drawPath(_path, paint);
    final paint1 = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawPath(_path, paint1);
  }
}
