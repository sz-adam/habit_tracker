import 'dart:ui';

class Habit {
  String title;
  String? description;
  Color color;
  List<int>? selectedDays;
  int? durationMinutes;
  DateTime startDate;

  Habit({
    required this.title,
    this.description,
     required this.color,
    this.selectedDays,
    this.durationMinutes,
    required this.startDate,
  });
}
