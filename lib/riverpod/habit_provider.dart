import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/habit_model.dart';

// StateNotifier a Habit állapot kezelésére
class HabitNotifier extends StateNotifier<Habit?> {
  HabitNotifier() : super(null);

  // Metódus a Habit mentésére
  void saveHabit(
    String title,
    String description,
    List<int> selectedDays,
    int? durationMinutes,
    DateTime startDate,
  ) {
    final habit = Habit(
      title: title,
      description: description,
      selectedDays: selectedDays,
      durationMinutes: durationMinutes,
      startDate: startDate,
    );
    state = habit;
  }
}

// Riverpod provider létrehozása
final habitProvider = StateNotifierProvider<HabitNotifier, Habit?>((ref) {
  return HabitNotifier();
});
