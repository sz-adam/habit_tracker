import 'package:flutter/material.dart';

class DaySelector extends StatelessWidget {
  final List<int> selectedDays;
  final ValueChanged<List<int>> onSelectedDaysChanged;

  DaySelector({
    required this.selectedDays,
    required this.onSelectedDaysChanged,
  });

  final dayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.0,
      children: List.generate(7, (index) {
        final day = dayLabels[index];
        return ChoiceChip(
          label: Text(day),
          selected: selectedDays.contains(index),
          onSelected: (selected) {
            onSelectedDaysChanged(
              selected
                  ? [...selectedDays, index]
                  : selectedDays.where((i) => i != index).toList(),
            );
          },
        );
      }),
    );
  }
}
