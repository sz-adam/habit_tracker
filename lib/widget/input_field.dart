import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final int? maxLines;

  const InputField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: controller,
      maxLines: maxLines ?? 1,
      style: TextStyle(color: theme.primaryColor, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        labelText: hintText,
        hintStyle: TextStyle(color: theme.primaryColor),
        prefixIcon: Icon(icon, color: theme.primaryColor),
        filled: true,
        fillColor: theme.scaffoldBackgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: theme.primaryColor, width: 2),
        ),
      ),
    );
  }
}
