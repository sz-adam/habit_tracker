import 'package:flutter/material.dart';

import '../../model/habit_model.dart';

class HabitActionsButton extends StatelessWidget {
  final Habit habit;
  final Color primaryColor;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const HabitActionsButton({
    super.key,
    required this.habit,
    required this.primaryColor,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _confirmDelete(context),
            icon: Icon(Icons.delete, color: colorScheme.onError),
            label: Text("Delete"),
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.error,
              foregroundColor: colorScheme.onError,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),

              textStyle: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: onEdit,
            icon: Icon(Icons.edit, color: colorScheme.onPrimary),
            label: Text("Edit"),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),

              textStyle: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  //Törlés
  void _confirmDelete(BuildContext context) async {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: colorScheme.surface,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 12),
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            actionsPadding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            title: Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: colorScheme.error,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    "Are you sure?",
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            content: Text(
              "This habit will be permanently deleted. This action cannot be undone.",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
            actions: [
              TextButton.icon(
                onPressed: () => Navigator.pop(context, false),
                icon: Icon(Icons.cancel, color: colorScheme.primary),
                label: Text("Cancel"),
                style: TextButton.styleFrom(
                  foregroundColor: colorScheme.primary,
                  textStyle: theme.textTheme.labelLarge,
                ),
              ),
              TextButton.icon(
                onPressed: () => Navigator.pop(context, true),
                icon: Icon(Icons.delete_forever, color: colorScheme.error),
                label: Text("Delete"),
                style: TextButton.styleFrom(
                  foregroundColor: colorScheme.error,
                  textStyle: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
    );

    if (confirm == true) {
      await habit.delete();
      onDelete();
    }
  }
}
