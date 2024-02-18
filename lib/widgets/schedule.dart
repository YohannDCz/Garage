import 'package:flutter/material.dart';

class Schedule extends StatelessWidget {
  const Schedule({
    super.key,
    required this.readOnly,
    required this.controller,
    required this.label,
  });

  final bool readOnly;
  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: SizedBox(
        width: 100,
        height: 30,
        child: TextField(
          readOnly: readOnly,
          decoration: InputDecoration(hintText: label, hintStyle: Theme.of(context).textTheme.bodyMedium, border: const UnderlineInputBorder(borderSide: BorderSide.none)),
          controller: controller,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
