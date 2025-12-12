import 'dart:math';
import 'package:flutter/material.dart';

Color randomPetalColor({int seed = 0}) {
  final random = seed == 0 ? Random() : Random(seed);

  // Choose hue range for flowers: pink, red, purple, orange
  // Red: 0-20, 340-360
  // Pink: 300-340
  // Purple: 260-300
  // Orange: 20-45
  final hueRanges = [
    [0.0, 20.0],
    [340.0, 360.0],
    [300.0, 340.0],
    [260.0, 300.0],
    [20.0, 45.0],
  ];

  // Pick a random hue range
  final range = hueRanges[random.nextInt(hueRanges.length)];
  final hue = range[0] + random.nextDouble() * (range[1] - range[0]);

  // Saturation: 70% - 100% (vibrant colors)
  final saturation = 0.7 + random.nextDouble() * 0.3;

  // Lightness: 50% - 80% (soft & bright)
  final lightness = 0.5 + random.nextDouble() * 0.3;

  // Convert HSL to Color
  final hslColor = HSLColor.fromAHSL(1.0, hue, saturation, lightness);

  return hslColor.toColor();
}