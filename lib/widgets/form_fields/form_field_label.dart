import 'package:flutter/material.dart';

import 'form_field_hint.dart';

class FormFieldLabel extends StatelessWidget {
  const FormFieldLabel({
    super.key,
    required this.label,
    required this.controller,
    required this.hint,
    this.validator,
    this.maxLines = 1,
  });

  final String label;
  final TextEditingController controller;
  final String hint;
  final String? Function(String? p1)? validator;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(label, style: Theme.of(context).textTheme.titleMedium),
        ),
        FormFieldHint(nameController: controller, hint: hint, validator: validator, maxLines: maxLines),
      ],
    );
  }
}
