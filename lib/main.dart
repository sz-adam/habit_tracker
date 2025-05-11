import 'package:flutter/material.dart';
import 'package:habit_tracker/riverpod/color_provider.dart';
import 'package:habit_tracker/screens/navigation/bottom_navigation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('settings');

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedColor = ref.watch(colorProvider);

    final colorScheme = ColorScheme.fromSeed(seedColor: selectedColor);

    return MaterialApp(
      title: 'Habit tracker',
      theme: ThemeData(
        colorScheme: colorScheme,
        scaffoldBackgroundColor: colorScheme.background.withOpacity(0.65),
        appBarTheme: AppBarTheme(backgroundColor: colorScheme.primary),
      ),
      home: BottomNavigation(),
    );
  }
}
