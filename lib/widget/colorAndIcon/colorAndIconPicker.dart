import 'package:flutter/material.dart';
import 'color_picker.dart';
import 'icon_picker.dart';

class ColorAndIconPicker extends StatelessWidget {
  final Color selectedColor;
  final IconData selectedIcon;
  final ValueChanged<Color> onColorChanged;
  final ValueChanged<IconData> onIconChanged;

  const ColorAndIconPicker({
    super.key,
    required this.selectedColor,
    required this.selectedIcon,
    required this.onColorChanged,
    required this.onIconChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Select Habit Color:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            ColorPicker(
              selectedColor: selectedColor,
              onColorChanged: onColorChanged,
            ),
          ],
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Select Habit Icon:',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            IconPickerWidget(
              selectedIcon: selectedIcon,
              onIconChanged: onIconChanged,
            ),
          ],
        ),
      ],
    );
  }
}
