import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../model/habit_model.dart';

final habitProvider = StateNotifierProvider<HabitNotifier, List<Habit>>((ref) {
  return HabitNotifier();
});

class HabitNotifier extends StateNotifier<List<Habit>> {
  HabitNotifier() : super([]) {
    loadHabits();
  }

  Future<void> loadHabits() async {
    final box = Hive.box<Habit>('habits');
    state = box.values.toList();
  }

  Future<void> saveHabit(String title, String? description, Color color, IconData icon,
      List<int>? selectedDays, int? durationMinutes, DateTime startDate) async {
    final habit = Habit(
      title: title,
      description: description,
      color: color,
      icon: icon,
      selectedDays: selectedDays,
      durationMinutes: durationMinutes,
      startDate: startDate,
    );

    final box = Hive.box<Habit>('habits');
    await box.add(habit); // Hive mentés

    state = [...state, habit];
  }
}
