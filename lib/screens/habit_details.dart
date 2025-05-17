import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/widget/habit_details/count_down.dart';
import 'package:habit_tracker/widget/habit_details/habit_actions_button.dart';
import 'package:intl/intl.dart';
import '../model/habit_model.dart';
import '../riverpod/habit_provider.dart';
import '../widget/habit_details/habit_icon.dart';
import '../utils/timer_controller.dart';

class HabitDetails extends ConsumerStatefulWidget {
  final Habit habit;

  const HabitDetails({super.key, required this.habit});

  @override
  ConsumerState<HabitDetails> createState() => _HabitDetailsState();
}

class _HabitDetailsState extends ConsumerState<HabitDetails> {
  TimerController? timerController;

  @override
  void initState() {
    super.initState();
    if (widget.habit.durationMinutes != null) {
      timerController = TimerController(durationMinutes: widget.habit.durationMinutes!);
      timerController!.onCountdownComplete = _showCountdownCompletedDialog;
    }
  }

  @override
  void dispose() {
    timerController?.dispose();
    super.dispose();
  }

  void _showCountdownCompletedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Ready!"),
        content: Text("Congratulations, you have successfully completed it!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final habit = widget.habit;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: habit.color,
      appBar: AppBar(
        backgroundColor: habit.color,
        elevation: 0,
        iconTheme: IconThemeData(color: theme.colorScheme.onPrimary),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HabitIconBubble(
              icon: habit.icon,
              alignment: Alignment.center,
              iconSize: 62,
              backgroundColor: theme.canvasColor,
              iconColor: theme.canvasColor,
            ),
            SizedBox(height: 16),
            Center(
              child: Text(
                habit.title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (habit.description != null && habit.description!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  habit.description!,
                  style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white70),
                ),
              ),
            SizedBox(height: 24),
            if (habit.durationMinutes != null && timerController != null)
              AnimatedBuilder(
                animation: timerController!,
                builder: (context, _) => CountDown(
                  remaining: timerController!.remaining,
                  isCountingDown: timerController!.isCountingDown,
                  isPaused: timerController!.isPaused,
                  onStart: timerController!.start,
                  onPause: timerController!.pause,
                  onResume: timerController!.resume,
                  buttonColor: habit.color,
                ),
              ),
            SizedBox(height: 24),
            _buildInfoRow(Icons.calendar_today, 'Start Date', DateFormat.yMMMd().format(habit.startDate)),
            if (habit.selectedDays != null && habit.selectedDays!.isNotEmpty)
              _buildInfoRow(
                Icons.repeat,
                'Repeats',
                habit.selectedDays!
                    .map((i) => ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][i])
                    .join(', '),
              ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: HabitActionsButton(
          habit: habit,
          primaryColor: theme.colorScheme.primary,
          onDelete: () async {
            await ref.read(habitProvider.notifier).deleteHabit(widget.habit);
            Navigator.pop(context);
          },
          onEdit: _editHabit,
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70),
          SizedBox(width: 12),
          Text(
            '$title: ',
            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void _editHabit() {
    // TODO: szerkesztési logika implementálása
  }
}
