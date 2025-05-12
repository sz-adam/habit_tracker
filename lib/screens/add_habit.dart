import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/widget/input_field.dart';
import 'package:intl/intl.dart';
import '../riverpod/date_provider.dart';
import '../riverpod/habit_provider.dart';
import '../widget/color_picker.dart';
import '../widget/day/date_picker.dart';
import '../widget/day/day_selector.dart';

class AddHabit extends ConsumerStatefulWidget {
  const AddHabit({super.key});

  @override
  ConsumerState<AddHabit> createState() => _AddHabitState();
}

class _AddHabitState extends ConsumerState<AddHabit> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  List<int> _selectedDays = [];
  int? _durationMinutes;
  Color _selectedColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedDate = ref.watch(selectedDateProvider) ?? DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Habit',
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
            //Szin választás
            Text('Select Habit Color:'),
            SizedBox(height: 8),
            ColorPicker(
              selectedColor: _selectedColor,
              onColorChanged: (color) {
                setState(() {
                  _selectedColor = color;
                });
              },
            ),

            SizedBox(height: 16),
            Text('Select Days to Repeat (optional):'),
            SizedBox(height: 8),
            DaySelector(
              selectedDays: _selectedDays,
              onSelectedDaysChanged: (selectedDays) {
                setState(() {
                  _selectedDays = selectedDays;
                });
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
                hintStyle: TextStyle(color: theme.primaryColor),
                prefixIcon: Icon(
                  Icons.hourglass_bottom,
                  color: theme.primaryColor,
                ),
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
                child: Text('Save Habit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveHabit(DateTime selectedDate) {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();
    final color = _selectedColor;
    final days = _selectedDays;

    final duration = _durationMinutes;

    // Mentés a Riverpod provider-be
    ref
        .read(habitProvider.notifier)
        .saveHabit(title, description,color, days, duration, selectedDate, );

    print('--- Habit Saved ---');
    print('Title: $title');
    print('Description: $description');
    print('Color: $color');
    print('Days: ${days.isEmpty ? 'None selected' : days.join(', ')}');
    print('Duration: ${duration ?? 'Not specified'} minutes');
    print('Start Date: ${DateFormat.yMMMd().format(selectedDate)}');

    Navigator.pop(context);
  }
}
