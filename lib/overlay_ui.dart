import 'package:flutter/material.dart';
import 'package:geometry_flower/main.dart';

class OverlayUI extends StatefulWidget {
  final MainApp game;
  const OverlayUI({super.key, required this.game});

  @override
  State<OverlayUI> createState() => _OverlayUIState();
}

class _OverlayUIState extends State<OverlayUI> {
  double _flowerCount = 10;
  double _spacing = 120;
  double _maxHeight = 300;
  RangeValues _petalAngle = const RangeValues(10, 24);
  RangeValues _petalLength = const RangeValues(55, 60);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 10,
      left: 10,
      right: 10,
      child: Card(
        color: Colors.black.withOpacity(0.5),
        child: Theme(
          data: ThemeData.dark().copyWith(
            sliderTheme: const SliderThemeData(
              activeTrackColor: Colors.tealAccent,
              inactiveTrackColor: Colors.grey,
              thumbColor: Colors.tealAccent,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ExpansionTile(
                  iconColor: Colors.white,
                  collapsedIconColor: Colors.white,
                  title: const Text(
                    'Controls',
                    style: TextStyle(color: Colors.white),
                  ),
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Number of flowers:',
                          style: TextStyle(color: Colors.white),
                        ),
                        Expanded(
                          child: Slider(
                            value: _flowerCount,
                            min: 1,
                            max: 20,
                            divisions: 19,
                            label: _flowerCount.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _flowerCount = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Spacing:',
                          style: TextStyle(color: Colors.white),
                        ),
                        Expanded(
                          child: Slider(
                            value: _spacing,
                            min: 50,
                            max: 200,
                            divisions: 15,
                            label: _spacing.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _spacing = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Max Height:',
                          style: TextStyle(color: Colors.white),
                        ),
                        Expanded(
                          child: Slider(
                            value: _maxHeight,
                            min: 100,
                            max: 500,
                            divisions: 40,
                            label: _maxHeight.round().toString(),
                            onChanged: (double value) {
                              setState(() {
                                _maxHeight = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Petal Angle:',
                          style: TextStyle(color: Colors.white),
                        ),
                        Expanded(
                          child: RangeSlider(
                            values: _petalAngle,
                            min: 5,
                            max: 45,
                            divisions: 40,
                            labels: RangeLabels(
                              _petalAngle.start.round().toString(),
                              _petalAngle.end.round().toString(),
                            ),
                            onChanged: (RangeValues values) {
                              setState(() {
                                _petalAngle = values;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Petal Length:',
                          style: TextStyle(color: Colors.white),
                        ),
                        Expanded(
                          child: RangeSlider(
                            values: _petalLength,
                            min: 20,
                            max: 100,
                            divisions: 80,
                            labels: RangeLabels(
                              _petalLength.start.round().toString(),
                              _petalLength.end.round().toString(),
                            ),
                            onChanged: (RangeValues values) {
                              setState(() {
                                _petalLength = values;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.refresh, color: Colors.white),
                      onPressed: () {
                        widget.game.regenerate(
                          count: _flowerCount.toInt(),
                          spacing: _spacing,
                          maxHeight: _maxHeight,
                          minPetalAngle: _petalAngle.start,
                          maxPetalAngle: _petalAngle.end,
                          minPetalLength: _petalLength.start,
                          maxPetalLength: _petalLength.end,
                        );
                      },
                    ),
                    IconButton(
                      icon:
                          const Icon(Icons.visibility_off, color: Colors.white),
                      onPressed: () {
                        widget.game.hideOverlay();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
