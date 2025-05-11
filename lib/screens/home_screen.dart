import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:habit_tracker/widget/Calendar.dart';
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
          Calendar()
        ],
      ),
    );
  }
}
