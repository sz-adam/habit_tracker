import 'package:flutter/material.dart';
import 'package:habit_tracker/widget/theme_selector.dart';
import 'package:habit_tracker/widget/update_name.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(
            color: theme.colorScheme.onPrimary.withOpacity(0.75),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [UpdateName(), SizedBox(height: 8), ThemeColorSelector()],
        ),
      ),
    );
  }
}
