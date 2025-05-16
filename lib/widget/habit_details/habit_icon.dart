import 'package:flutter/material.dart';

class HabitIconBubble extends StatelessWidget {
  final IconData icon;
  final Alignment alignment;
  final double iconSize;
  final Color backgroundColor;
  final Color iconColor;

  const HabitIconBubble({
    super.key,
    required this.icon,
    required this.alignment,
    required this.iconSize,
    required this.backgroundColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor.withOpacity(0.15),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.white10,
              blurRadius: 6,
              offset: Offset(2, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Icon(icon, size: iconSize, color: iconColor),
      ),
    );
  }
}
