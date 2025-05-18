import 'dart:async';
import 'package:flutter/material.dart';
import 'package:habit_tracker/widget/habit_card.dart';
import '../model/habit_model.dart';

class AnimatedHabitCard extends StatefulWidget {
  final Habit habit;
  final int delay;

  const AnimatedHabitCard({
    super.key,
    required this.habit,
    this.delay = 0,
  });

  @override
  State<AnimatedHabitCard> createState() => _AnimatedHabitCardState();
}

class _AnimatedHabitCardState extends State<AnimatedHabitCard>
    with SingleTickerProviderStateMixin {
  double _opacity = 0;
  double _scale = 0.95;

  @override
  void initState() {
    super.initState();

    Timer(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        setState(() {
          _opacity = 1;
          _scale = 1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutBack,
        child: HabitCard(habit: widget.habit),
      ),
    );
  }
}
