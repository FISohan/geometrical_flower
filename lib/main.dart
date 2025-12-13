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

    // The maximum radius a petal can extend from the center of the flower.
    // This accounts for the petal's own length, variations in length, and
    // the "bending" of the stem.
    const petalLengthVariation = 15.0;
    const stemDeformation = 20.0;
    final petalRadius = maxPetalLength + petalLengthVariation + stemDeformation;

    // --- Horizontal constraints ---
    final availableWidth = size.x - 2 * petalRadius;
    if (count > 0 && availableWidth <= 0) {
      // Screen is too narrow to draw even one flower without going off-screen.
      return;
    }

    var usedSpacing = spacing;
    if (count > 1 && (count - 1) * spacing > availableWidth) {
      // Adjust spacing to fit all flowers within the available width.
      usedSpacing = availableWidth / (count - 1);
    }

    final totalGroupWidth = count > 1 ? (count - 1) * usedSpacing : 0.0;
    final leftFlowerX = (size.x - totalGroupWidth) / 2;

    // --- Vertical constraints ---
    final minStemHeight = 100.0; // Original minimum height.
    final lowerStemBound = max(minStemHeight, petalRadius);
    final upperStemBound = min(maxHeight, size.y - petalRadius);

    if (lowerStemBound >= upperStemBound) {
      // Not enough vertical space to draw flowers.
      return;
    }

    for (int i = 0; i < count; i++) {
      final lineX = leftFlowerX + (i * usedSpacing);
      final stemHeight = random.nextDoubleBetween(lowerStemBound, upperStemBound);
      final line = Line(
        start: Vector2(lineX, size.y),
        end: Vector2(
          lineX,
          size.y - stemHeight,
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
