import 'package:flutter/material.dart';

class AddHabit extends StatefulWidget {
  const AddHabit({super.key});

  @override
  State<AddHabit> createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Habit",style: TextStyle(
          color: theme.colorScheme.onPrimary.withOpacity(0.75),
          fontWeight: FontWeight.bold,
        ),),
      ),
      body: const Center(
        child: Text(
          'Add habit',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}