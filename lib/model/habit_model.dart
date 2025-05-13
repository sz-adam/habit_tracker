import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'habit_model.g.dart';

@HiveType(typeId: 0)
class Habit extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String? description;

  @HiveField(2)
  int colorValue;

  @HiveField(3)
  int iconCodePoint;

  @HiveField(4)
  List<int>? selectedDays;

  @HiveField(5)
  int? durationMinutes;

  @HiveField(6)
  DateTime startDate;

  Habit({
    required this.title,
    this.description,
    Color? color,
    IconData? icon,
    this.selectedDays,
    this.durationMinutes,
    required this.startDate,
  })  : colorValue = color?.value ?? Colors.blue.value,
        iconCodePoint = icon?.codePoint ?? Icons.star.codePoint;

  Color get color => Color(colorValue);
  IconData get icon => IconData(iconCodePoint, fontFamily: 'MaterialIcons');
}
