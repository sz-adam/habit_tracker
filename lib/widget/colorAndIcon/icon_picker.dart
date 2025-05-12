import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart' as FlutterIconPicker;

class IconPickerWidget extends StatefulWidget {
  final IconData? selectedIcon;
  final ValueChanged<IconData> onIconChanged;

  const IconPickerWidget({
    super.key,
    required this.selectedIcon,
    required this.onIconChanged,
  });

  @override
  State<IconPickerWidget> createState() => _IconPickerWidgetState();
}

class _IconPickerWidgetState extends State<IconPickerWidget> {
  late IconData? _currentIcon;

  @override
  void initState() {
    super.initState();
    _currentIcon = widget.selectedIcon ?? Icons.star;
  }

  Future<void> _pickIcon() async {
    IconData? icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.material]);

    if (icon != null) {
      setState(() {
        _currentIcon = icon;
      });
      widget.onIconChanged(icon);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(_currentIcon, size: 32),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: _pickIcon,
          child: const Text("Pick Icon"),
        ),
      ],
    );
  }
}
