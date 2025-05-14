import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/widget/Calendar.dart';
import 'package:habit_tracker/widget/habit_card.dart';
import '../riverpod/habit_provider.dart';
import '../riverpod/name_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userName = ref.watch(userNameProvider);
    final habits = ref.watch(habitProvider);

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          userName.isNotEmpty ? 'Welcome, $userName' : 'Welcome : User',
          style: TextStyle(
            color: theme.colorScheme.onPrimary.withOpacity(0.75),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Calendar(),
          const SizedBox(height: 20),
          habits.isNotEmpty
              ? Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  itemCount: habits.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final habit = habits[index];
                    return HabitCard(habit: habit);
                  },
                ),
              )
              : const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'No habit saved yet.',
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                ),
              ),
        ],
      ),
    );
  }
}
