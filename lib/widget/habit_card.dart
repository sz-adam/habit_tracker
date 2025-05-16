import 'package:flutter/material.dart';
import 'package:habit_tracker/screens/habit_details.dart';
import '../model/habit_model.dart';
import 'habit_details/habit_icon.dart';

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
          HabitIconBubble(
            icon: habit.icon,
            alignment: Alignment.topRight,
            iconSize: 32,
            backgroundColor: theme.canvasColor,
            iconColor: theme.canvasColor,
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HabitDetails(habit: habit)),
                );
              },
              child: const Text('View'),
            ),
          ),
        ],
      ),
    );
  }
}
