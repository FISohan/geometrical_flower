import 'dart:async';
import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flutter/material.dart';
import 'package:geometry_flower/petal.dart';

class Line extends Component {
  final Vector2 start;
  final Vector2 end;
  Vector2 _endPoint;

  final int _totalSteps = 20;
  final double _deformationFactor = 1.0;

  final minPetals = 6;
  final maxPetals = 15;

  final double minPetalAngle;
  final double maxPetalAngle;
  final double minPetalLength;
  final double maxPetalLength;

  Line({
    super.children,
    super.priority,
    super.key,
    required this.start,
    required this.end,
    this.minPetalAngle = 10,
    this.maxPetalAngle = 24,
    this.minPetalLength = 55,
    this.maxPetalLength = 60,
  }) : _endPoint = end;

  final Path _path = Path();
  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    _generatePath();
    _generatePetals();
    return super.onLoad();
  }

  void _generatePetals() {
    final Random random = Random();
    final int petals = random.nextIntBetween(minPetals, maxPetals);

    for (int i = 0; i < petals; i++) {
      final Petal petal = Petal(
        endLinePosition: _endPoint,
        minAngle: minPetalAngle,
        maxAngle: maxPetalAngle,
        minLength: minPetalLength,
        maxLength: maxPetalLength,
      );
      double angle = i * 2 * pi / petals + (Random().nextDouble() - 0.5) * 0.2;
      petal.angle += angle;
      add(petal);
    }
  }

  Vector2 get endPoint => _endPoint;

  void _generatePath() {
    double distance = start.distanceTo(end);
    double step = distance / _totalSteps.toDouble();
    Vector2 direction = end - start;
    _path.moveTo(start.x, start.y);
    Random random = Random();
    Vector2 prevPoint = start;
    for (int i = 0; i < _totalSteps; i += 1) {
      Vector2 nextPoint = (direction.normalized() * step) + prevPoint;
      nextPoint.x +=
          random.nextDouble() *
          _deformationFactor *
          (random.nextBool() ? -1 : 1);
      prevPoint = nextPoint;
      _path.lineTo(nextPoint.x, nextPoint.y);
    }
    _endPoint = prevPoint;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawCircle(
      Offset(_endPoint.x, _endPoint.y),
      5,
      Paint()..color = Colors.white,
    );
    canvas.drawPath(
      _path,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = Colors.white,
    );
  }
}
