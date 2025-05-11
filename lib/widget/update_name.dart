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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Change name",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _nameController,
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w600,
                ),
                decoration: InputDecoration(
                  hintText: "Enter your name...",
                  prefixIcon: Icon(Icons.person, color: Colors.deepPurple),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
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
              child: Text("Save"),
            ),
          ],
        ),
      ],
    );
  }
}
