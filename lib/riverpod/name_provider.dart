import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final userNameProvider = StateProvider<String>((ref) {
  final box = Hive.box('settings');
  return box.get('userName', defaultValue: '');
});