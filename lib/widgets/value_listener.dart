import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../service/auth_service.dart';

class ValueListener extends StatelessWidget {
  const ValueListener({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: context.read<AuthenticationService>().isLoggedIn,
      builder: (context, isLoggedIn, child) {
        if (isLoggedIn) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
          });
        }
        return Container(); // Retourne un widget vide car nous n'avons pas besoin de construire quoi que ce soit ici
      },
    );
  }
}
