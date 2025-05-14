import 'package:flutter/material.dart';
import '../model/habit_model.dart';

class HabitCard extends StatelessWidget {
  final Habit habit;

  const HabitCard({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: habit.color,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ikon
          Align(
            alignment: Alignment.topRight,
            child: Container(
              decoration: BoxDecoration(
                color: theme.canvasColor.withOpacity(0.15),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.white10,
                    blurRadius: 6,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(12),
              child: Icon(habit.icon, size: 32, color: theme.canvasColor),
            ),
          ),

          const SizedBox(height: 3),

          // Cím
          Text(
            habit.title,
            style: TextStyle(
              color: theme.canvasColor,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),

          const Spacer(),

          // Gomb
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.splashColor,
                foregroundColor: theme.canvasColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
              ),
              onPressed: () {
                // TODO: Start gomb működés
              },
              child: const Text('View'),
            ),
          ),
        ],
      ),
    );
  }
}
