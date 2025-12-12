import 'dart:async';
import 'dart:math';

import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:geometry_flower/animated_line.dart';

void main() {
  runApp(GameWidget(game: MainApp()));
}

class MainApp extends FlameGame {
  final double leftMargin = 100;
  final double topMargin = 200;
  final double spaceing = 120;
  @override
  Color backgroundColor() => Colors.blueGrey;
  @override
  FutureOr<void> load() async {
    await super.onLoad();

    Random random = Random();

    for (int i = 0; i < 10; i++) {
      final line = Line(
        start: Vector2((i * spaceing) + leftMargin, topMargin + size.y / 2),
        end: Vector2(
          (i * spaceing) + leftMargin,
          random.nextDoubleBetween(100, 300),
        ),
      );
      add(line);
    }
    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    super.render(canvas);

    canvas.drawLine(
      Offset(0, topMargin + size.y / 2),
      Offset(size.x, topMargin + size.y / 2),
      Paint()..color = const Color.fromARGB(173, 255, 251, 251),
    );
  }
}
