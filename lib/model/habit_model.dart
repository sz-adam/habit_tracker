import 'dart:ui';

import 'package:flutter/material.dart';

class Habit {
  String title;
  String? description;
  Color color;
  IconData icon;
  List<int>? selectedDays;
  int? durationMinutes;
  DateTime startDate;

  Habit({
    required this.title,
    this.description,
    required this.color,
    required this.icon,
    this.selectedDays,
    this.durationMinutes,
    required this.startDate,
  });
}
