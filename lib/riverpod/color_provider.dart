import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

final colorProvider = StateNotifierProvider<ColorNotifier, Color>((ref) {
  final box = Hive.box('settings');
  final storedColorValue = box.get('themeColor') as int?;
  final color = storedColorValue != null ? Color(storedColorValue) : Colors.blue;
  return ColorNotifier(color);
});

class ColorNotifier extends StateNotifier<Color> {
  ColorNotifier(super.initialColor);

  void changeColor(Color newColor) {
    state = newColor;
    final box = Hive.box('settings');
    box.put('themeColor', newColor.value);
  }
}