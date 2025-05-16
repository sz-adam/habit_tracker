import 'package:flutter/material.dart';

class CountDown extends StatelessWidget {
  final Duration remaining;
  final bool isCountingDown;
  final bool isPaused;
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final Color buttonColor;

  const CountDown({
    super.key,
    required this.remaining,
    required this.isCountingDown,
    required this.isPaused,
    required this.onStart,
    required this.onPause,
    required this.onResume,
    required this.buttonColor,
  });

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes % 60)}:${twoDigits(duration.inSeconds % 60)}";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Countdown:',
          style: theme.textTheme.titleMedium?.copyWith(color: Colors.white),
        ),
        SizedBox(height: 8),
        Text(
          formatDuration(remaining),
          style: theme.textTheme.titleLarge?.copyWith(
            color: Colors.yellowAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        if (!isCountingDown)
          ElevatedButton.icon(
            onPressed: onStart,
            icon: Icon(Icons.play_arrow),
            label: Text("Go"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: buttonColor,
            ),
          )
        else if (isPaused)
          ElevatedButton.icon(
            onPressed: onResume,
            icon: Icon(Icons.play_arrow),
            label: Text("Continue"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: buttonColor,
            ),
          )
        else
          ElevatedButton.icon(
            onPressed: onPause,
            icon: Icon(Icons.pause),
            label: Text("Pause"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: buttonColor,
            ),
          ),
      ],
    );
  }
}
