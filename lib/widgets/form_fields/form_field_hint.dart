import 'package:flutter/material.dart';
import '../../theme.dart';

class FormFieldHint extends StatelessWidget {
  const FormFieldHint({
    super.key,
    required this.nameController,
    required this.hint,
    this.validator,
    this.maxLines = 1,
  });

  final TextEditingController nameController;
  final String hint;
  final String? Function(String?)? validator;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      validator: validator,
      maxLines: maxLines,
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        isDense: true,
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.secondaryText),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: AppColors.secondaryText, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: AppColors.secondaryText, width: 2.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: AppColors.primary, width: 2.0),
        ),
      ),
    );
  }
}
