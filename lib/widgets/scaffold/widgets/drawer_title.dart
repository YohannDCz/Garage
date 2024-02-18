import 'package:flutter/material.dart';

import '../../../theme.dart';

class DrawerTitle extends StatelessWidget {
  const DrawerTitle({
    super.key,
    required this.label,
    required this.route,
  });

  final String label;
  final String route;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64),
        child: InkWell(
          onTap: () {
            Navigator.pop(context); // Close the drawer
            Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
          },
          child: Text(
            label,
            style: TextStyles.headlineLarge.copyWith(color: AppColors.alternate, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
