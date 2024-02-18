import 'package:flutter/material.dart';

import '../service/validator_service.dart';
import '../theme.dart';

class FormFieldAdmin extends StatelessWidget {
  const FormFieldAdmin({
    super.key,
    required this.text,
    required this.controller,
    required this.hint,
    this.validator,
    this.password,
    this.confirmPassword,
  });

  final String text;
  final TextEditingController controller;
  final String hint;
  final String? Function(String?)? validator;
  final String? password;
  final String? confirmPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        height16,
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.white),
            ),
          ),
        ),
        height4,
        TextFormField(
          controller: controller,
          validator: validator ?? (value) => ValidatorService.validateConfirmPassword(password!.trim(), confirmPassword!.trim()),
          decoration: InputDecoration(
            errorStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.white),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            isDense: true,
            hintText: hint,
            hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.secondaryText),
            filled: true,
            fillColor: AppColors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(99.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
