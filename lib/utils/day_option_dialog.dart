import 'package:flutter/material.dart';

class DayOptionsDialog extends StatelessWidget {
  const DayOptionsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      backgroundColor: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        'What do you want to do?',
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: theme.colorScheme.primary,
        ),
      ),
      content: Text(
        'Do you want to adopt a new habit or just watch the day?',
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: theme.colorScheme.primary,
          ),
          onPressed: () => Navigator.of(context).pop('view'),
          child: const Text('View'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
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
