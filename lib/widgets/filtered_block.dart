import 'package:flutter/material.dart';

import '../theme.dart';

class FilteredBlock extends StatelessWidget {
  const FilteredBlock({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
  });

  final TextEditingController controller;
  final String label;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: AppColors.white)),
        SizedBox(
          width: 170.0,
          child: TextField(
            autofocus: true,
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              isDense: true,
              hintText: hint,
              hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.secondaryText),
              filled: true,
              fillColor: AppColors.white,
              border: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
