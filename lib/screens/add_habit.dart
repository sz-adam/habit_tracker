import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/widget/input_field.dart';
import '../model/habit_model.dart';
import '../riverpod/date_provider.dart';
import '../riverpod/habit_provider.dart';
import '../widget/colorAndIcon/colorAndIconPicker.dart';
import '../widget/day/date_picker.dart';
import '../widget/day/day_selector.dart';

class AddHabit extends ConsumerStatefulWidget {
  final Habit? habit;
  const AddHabit({super.key, this.habit});

  @override
  ConsumerState<AddHabit> createState() => _AddHabitState();
}

class _AddHabitState extends ConsumerState<AddHabit> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  List<int> _selectedDays = [];
  int? _durationMinutes;
  Color _selectedColor = Colors.blue;
  IconData? _selectedIcon = Icons.star;

  @override
  void initState() {
    super.initState();
    if (widget.habit != null) {
      _titleController.text = widget.habit!.title;
      _descriptionController.text = widget.habit!.description ?? '';
      _selectedColor = widget.habit!.color;
      _selectedIcon = widget.habit!.icon;
      _selectedDays = widget.habit!.selectedDays ?? [];
      _durationMinutes = widget.habit!.durationMinutes;

      // Késleltetett frissítés
      Future(() {
        ref.read(selectedDateProvider.notifier).state = widget.habit!.startDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedDate = ref.watch(selectedDateProvider) ?? DateTime.now();

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: theme.colorScheme.onPrimary,),
        title: Text(
          widget.habit != null ? 'Edit Habit' : 'Add Habit',
          style: TextStyle(
            color: theme.colorScheme.onPrimary.withOpacity(0.75),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputField(
              controller: _titleController,
              hintText: "Habit Title",
              icon: Icons.psychology_alt,
            ),
            SizedBox(height: 16),
            InputField(
              controller: _descriptionController,
              hintText: 'Description (optional)',
              icon: Icons.description,
              maxLines: 3,
            ),
            SizedBox(height: 16),
            Text('Start Date:'),
            SizedBox(height: 8),
            DatePicker(
              selectedDate: selectedDate,
              onDateSelected: (date) {
                ref.read(selectedDateProvider.notifier).state = date;
              },
            ),
            SizedBox(height: 16),
            ColorAndIconPicker(
              selectedColor: _selectedColor,
              selectedIcon: _selectedIcon ?? Icons.star,
              onColorChanged: (color) {
                setState(() => _selectedColor = color);
              },
              onIconChanged: (icon) {
                setState(() => _selectedIcon = icon);
              },
            ),
            SizedBox(height: 16),
            Text(
              'Select Days to Repeat (optional):',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.primary,
              ),
            ),
            SizedBox(height: 8),
            DaySelector(
              selectedDays: _selectedDays,
              onSelectedDaysChanged: (days) {
                setState(() => _selectedDays = days);
              },
            ),
            if (_selectedDays.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Selected: ${_selectedDays.map((i) => ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][i]).join(', ')}',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            SizedBox(height: 16),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Duration (Optional)",
                prefixIcon: Icon(Icons.hourglass_bottom, color: theme.primaryColor),
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
              onChanged: (value) {
                setState(() {
                  _durationMinutes = int.tryParse(value);
                });
              },
            ),
            SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () => _saveHabit(selectedDate),
                child: Text(widget.habit != null ? 'Update Habit' : 'Save Habit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveHabit(DateTime selectedDate) async {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    final color = _selectedColor;
    final icon = _selectedIcon ?? Icons.star;
    final days = _selectedDays;
    final duration = _durationMinutes;

    await ref.read(habitProvider.notifier).saveHabit(
      title,
      description,
      color,
      icon,
      days,
      duration,
      selectedDate,
      habit: widget.habit,
    );

    Navigator.pop(context);
  }
}
