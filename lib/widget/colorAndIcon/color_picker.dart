import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPicker extends StatelessWidget {
  final Color selectedColor;
  final ValueChanged<Color> onColorChanged;

  const ColorPicker({
    super.key,
    required this.selectedColor,
    required this.onColorChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(backgroundColor: selectedColor, radius: 20),
        SizedBox(width: 8),
        ElevatedButton(
          onPressed: () => _openColorPickerDialog(context),
          child: Text("Pick of Color"),
        ),
      ],
    );
  }

  void _openColorPickerDialog(BuildContext context) async {
    Color pickedColor =
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return ColorPickerDialog(currentColor: selectedColor);
          },
        ) ??
        selectedColor;

    onColorChanged(pickedColor);
  }
}

class ColorPickerDialog extends StatefulWidget {
  final Color currentColor;

  const ColorPickerDialog({super.key, required this.currentColor});

  @override
  _ColorPickerDialogState createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<ColorPickerDialog> {
  late Color _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedColor = widget.currentColor;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Pick a Color"),
      content: SingleChildScrollView(
        child: BlockPicker(
          pickerColor: _selectedColor,
          onColorChanged: (color) {
            setState(() {
              _selectedColor = color;
            });
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(_selectedColor);
          },
          child: Text("Select"),
        ),
      ],
    );
  }
}
