import 'package:flutter/material.dart';
import '../theme.dart';

class BigTitle extends StatelessWidget {
  const BigTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 68.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Text(
          title,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                color: AppColors.white,
                fontSize: 36.0,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}
