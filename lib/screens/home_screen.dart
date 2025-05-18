import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/widget/Calendar.dart';
import '../animation/animation_habit_card.dart';
import '../riverpod/habit_provider.dart';
import '../riverpod/name_provider.dart';
import '../riverpod/date_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userName = ref.watch(userNameProvider);
    final habits = ref.watch(habitProvider);
    final selectedDate = ref.watch(selectedDateProvider);

    final theme = Theme.of(context);


    final safeSelectedDate = selectedDate ?? DateTime.now();

    // Szűrés az adott nap habitjaira
    final filteredHabits = habits.where((habit) {

      final habitDate = DateTime(
        habit.startDate.year,
        habit.startDate.month,
        habit.startDate.day,
      );
      final selected = DateTime(safeSelectedDate.year, safeSelectedDate.month, safeSelectedDate.day);
      return habitDate == selected;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          userName.isNotEmpty ? 'Welcome, $userName' : 'Welcome : User',
          style: TextStyle(
            color: theme.colorScheme.onPrimary.withOpacity(0.75),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          const Calendar(),
          const SizedBox(height: 20),
          filteredHabits.isNotEmpty
              ? Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              itemCount: filteredHabits.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                final habit = filteredHabits[index];
                return AnimatedHabitCard(
                  key: ValueKey(habit.key),
                  habit: habit,
                  delay: index * 400,
                );
              },
            ),
          )
              : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'No habit for selected day.',
              style: TextStyle(
                fontSize: 24,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700,
                color: theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
