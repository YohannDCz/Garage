import 'package:flutter/material.dart';

import '../../theme.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, required this.scaffoldKey});

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.red), // Changez la couleur ici
        onPressed: () {
          scaffoldKey.currentState?.openDrawer();
        },
      ),
      title: Padding(
        padding: const EdgeInsets.only(right: 72.0, top: 8.0),
        child: Image.asset('assets/logo_garage.png', width: 303, height: 54),
      ),
      backgroundColor: AppColors.primary,
    );
  }
}
