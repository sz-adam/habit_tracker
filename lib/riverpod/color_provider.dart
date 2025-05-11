import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final colorProvider = StateNotifierProvider<ColorNotifier, Color>(
  (ref) => ColorNotifier(Colors.blue),
);

class ColorNotifier extends StateNotifier<Color> {
  ColorNotifier(Color state) : super(state);

  //szin frissítés
  void changeColor(Color newColor) {
    state = newColor;
  }
}
