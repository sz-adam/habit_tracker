import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

import '../model/habit_model.dart';
import '../riverpod/date_provider.dart';
import '../riverpod/habit_provider.dart';
import '../screens/add_habit.dart';
import '../utils/day_option_dialog.dart';

class Calendar extends ConsumerStatefulWidget {
  const Calendar({super.key});

  @override
  ConsumerState<Calendar> createState() => _CalendarState();
}

class _CalendarState extends ConsumerState<Calendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final selectedDay = ref.watch(selectedDateProvider);
    final habits = ref.watch(habitProvider);

    // habitok csoportosítása dátum alapján
    Map<DateTime, List<Habit>> events = {};
    for (var habit in habits) {
      final date = DateTime(
        habit.startDate.year,
        habit.startDate.month,
        habit.startDate.day,
      );
      events.putIfAbsent(date, () => []).add(habit);
    }
    //eltávolítja az órát, percet, másodpercet. Visszaadjuk a habitokat
    List<Habit> _getEventsForDay(DateTime day) {
      final key = DateTime(day.year, day.month, day.day);
      return events[key] ?? [];
    }

    return TableCalendar(
      firstDay: DateTime.utc(2020, 1, 1),
      lastDay: DateTime.utc(2030, 12, 31),
      focusedDay: _focusedDay,
      selectedDayPredicate: (day) => isSameDay(selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) async {
        ref.read(selectedDateProvider.notifier).state = selectedDay;
        setState(() {
          _focusedDay = focusedDay;
        });
        final result = await showDayOptionsDialog(context);

        //navigáció
        if (result == 'add') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddHabit()),
          );
        }
      },
      calendarFormat: _calendarFormat,
      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
      startingDayOfWeek: StartingDayOfWeek.monday,
      eventLoader: _getEventsForDay,
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          if (events.isNotEmpty) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              events.map((e) {
                final habit = e as Habit;
                return Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 1.5),
                  decoration: BoxDecoration(
                    color: habit.color,
                    shape: BoxShape.circle,
                  ),
                );
              }).toList(),
            );
          }
          return null;
        },
      ),
      calendarStyle: CalendarStyle(
        holidayDecoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
          shape: BoxShape.circle,
        ),
        selectedDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
        ),
      ),
      headerStyle: HeaderStyle(
        titleTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.primary,
        ),
        formatButtonVisible: true,
        formatButtonTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          fontWeight: FontWeight.bold,
        ),
        formatButtonDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}