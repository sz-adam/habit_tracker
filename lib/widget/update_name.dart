import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../riverpod/name_provider.dart';

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
                child: TextField(
                  controller: _nameController,
                  style: TextStyle(
                    color: theme.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: InputDecoration(
                    hintText: "Enter your name...",
                    hintStyle: TextStyle(color: theme.primaryColor),
                    prefixIcon: Icon(Icons.person, color: theme.primaryColor),
                    filled: true,
                    fillColor: theme.scaffoldBackgroundColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: theme.primaryColor,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  final enteredName = _nameController.text;
                  if (enteredName.isNotEmpty) {
                    ref.read(userNameProvider.notifier).state = enteredName;
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
