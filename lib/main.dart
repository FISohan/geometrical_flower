import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:geometry_flower/animated_line.dart';
import 'package:geometry_flower/overlay_ui.dart';

void main() {
  runApp(const GameApp());
}

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  late final MainApp _game;

  @override
  void initState() {
    super.initState();
    _game = MainApp();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GestureDetector(
          onTap: () {
            if (!_game.overlays.isActive('overlay')) {
              _game.showOverlay();
            }
          },
          child: GameWidget(
            game: _game,
            overlayBuilderMap: {
              'overlay': (context, game) {
                return OverlayUI(game: _game);
              },
            },
          ),
        ),
      ),
    );
  }
}

class MainApp extends FlameGame {
  @override
  Color backgroundColor() => Colors.blueGrey;
  @override
  FutureOr<void> load() async {
    await super.onLoad();
    regenerate();
    showOverlay();
    return super.onLoad();
  }

  void regenerate({
    int count = 10,
    double spacing = 120,
    double maxHeight = 300,
    double minPetalAngle = 10,
    double maxPetalAngle = 24,
    double minPetalLength = 55,
    double maxPetalLength = 60,
  }) {
    removeAll(children);
    Random random = Random();

    final totalWidth = count * spacing;
    final double leftMargin = (size.x - totalWidth) / 2;

    for (int i = 0; i < count; i++) {
      final line = Line(
        start: Vector2((i * spacing) + leftMargin, size.y),
        end: Vector2(
          (i * spacing) + leftMargin,
          size.y - random.nextDoubleBetween(100, maxHeight.clamp(0, size.y)),
        ),
        minPetalAngle: minPetalAngle,
        maxPetalAngle: maxPetalAngle,
        minPetalLength: minPetalLength,
        maxPetalLength: maxPetalLength,
      );
      add(line);
    }
  }

  void hideOverlay() {
    overlays.remove('overlay');
  }

  void showOverlay() {
    overlays.add('overlay');
  }

  @override
  void render(Canvas canvas) {
    // TODO: implement render
    super.render(canvas);

    canvas.drawLine(
      Offset(0, size.y),
      Offset(size.x, size.y),
      Paint()..color = const Color.fromARGB(173, 255, 251, 251),
    );
  }
}
