// lib/widget/dialogs/day_options_dialog.dart

import 'package:flutter/material.dart';

class DayOptionsDialog extends StatelessWidget {
  const DayOptionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('What do you want to do?'),
      content: const Text(
        'Do you want to adopt a new habit or just watch the day?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop('view'),
          child: const Text('View'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pop('add'),
          child: const Text('New Habit'),
        ),
      ],
    );
  }
}

Future<String?> showDayOptionsDialog(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (context) => const DayOptionsDialog(),
  );
}
