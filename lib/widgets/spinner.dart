// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import '../theme.dart';

class Spinner extends StatelessWidget {
  const Spinner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: 24.0, height: 24.0, child: CircularProgressIndicator(color: AppColors.white));
  }
}
