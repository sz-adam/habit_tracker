import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../riverpod/name_provider.dart';
import 'input_field.dart';

class UpdateName extends ConsumerStatefulWidget {
  const UpdateName({super.key});

  @override
  ConsumerState<UpdateName> createState() => _UpdateNameState();
}

class _UpdateNameState extends ConsumerState<UpdateName> {
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // téma elérése
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Change name",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: theme.primaryColor,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child:
                InputField(controller:_nameController, hintText:"Enter your name" ,icon: Icons.person)
              ),
              SizedBox(width: 12),
              ElevatedButton(
                onPressed: () async {
                  final enteredName = _nameController.text;
                  if (enteredName.isNotEmpty) {
                    // Riverpod állapot frissítése
                    ref.read(userNameProvider.notifier).state = enteredName;

                    // Hive-ba mentés
                    final box = Hive.box('settings');
                    await box.put('userName', enteredName);

                    FocusScope.of(context).unfocus();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Name saved: $enteredName')),
                    );
                    _nameController.clear();
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                child: Text("Save"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
