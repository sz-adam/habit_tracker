import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../model/habit_model.dart';

final habitBoxProvider = Provider<Box<Habit>>((ref) {
  return Hive.box<Habit>('habits');
});

final habitProvider = StateNotifierProvider<HabitNotifier, List<Habit>>((ref) {
  final box = ref.watch(habitBoxProvider);
  return HabitNotifier(box);
});

class HabitNotifier extends StateNotifier<List<Habit>> {
  final Box<Habit> _habitBox;

  HabitNotifier(this._habitBox) : super(_habitBox.values.toList());

  Future<void> saveHabit(
      String title,
      String description,
      Color color,
      IconData icon,
      List<int> selectedDays,
      int? durationMinutes,
      DateTime startDate, {
        Habit? habit,
      }) async {
    if (habit != null) {
      habit.title = title;
      habit.description = description;
      habit.colorValue = color.value;
      habit.iconCodePoint = icon.codePoint;
      habit.selectedDays = selectedDays;
      habit.durationMinutes = durationMinutes;
      habit.startDate = startDate;

      await habit.save();
      state = _habitBox.values.toList();
    } else {
      final newHabit = Habit(
        title: title,
        description: description,
        color: color,
        icon: icon,
        selectedDays: selectedDays,
        durationMinutes: durationMinutes,
        startDate: startDate,
      );

      await _habitBox.add(newHabit);
      state = [...state, newHabit];
    }
  }


  Future<void> deleteHabit(Habit habit) async {
    await habit.delete();
    state = _habitBox.values.toList();
  }
}
