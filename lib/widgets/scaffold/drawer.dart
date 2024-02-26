import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/authentication_bloc.dart';
import '../../service/auth_service.dart';
import '../../theme.dart';
import 'widgets/drawer_title.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Future onPressed() async {
      try {
        BlocProvider.of<AuthenticationBloc>(context).add(Logout());
      } catch (e) {
        debugPrint('Erreur lors de la déconnexion : $e');
      }
      Navigator.of(context).pop();
    }

    return Drawer(
      backgroundColor: AppColors.primary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              height64,
              Image.asset('assets/logo_garage.png', width: 209, height: 71),
              height32,
              const DrawerTitle(label: 'Accueil', route: "/home"),
              height32,
              const DrawerTitle(label: 'Services', route: "/services"),
              height32,
              const DrawerTitle(label: 'Occasions', route: "/cars"),
              height32,
              const DrawerTitle(label: 'À propos', route: "/about"),
              height32,

              /// If the user is logged in and is an employee, we display the employee menu
              /// If the user is logged in and is an admin, we display the admin menu
              Visibility(
                visible: context.read<AuthenticationService>().isLoggedIn.value && context.read<AuthenticationService>().typeOfLoggedUser == 'employee',
                replacement: Visibility(
                  visible: context.read<AuthenticationService>().isLoggedIn.value && context.read<AuthenticationService>().typeOfLoggedUser == 'admin',
                  child: const DrawerTitle(label: 'Admin', route: "/admin"),
                ),
                child: const DrawerTitle(label: 'Employé', route: "/employee"),
              ),
            ],
          ),

          /// I put this here to redirect the user to the login page if he is not logged in
          /// It is here because of the spacing of the different elements
          // ValueListenableBuilder(
          //   valueListenable: context.read<AuthenticationService>().isLoggedIn,
          //   builder: (context, isLoggedIn, child) {
          //     if (!isLoggedIn) {
          //       WidgetsBinding.instance.addPostFrameCallback((_) {
          //         Navigator.of(context).pushNamedAndRemoveUntil('/signin', (route) => false);
          //       });
          //     }
          //     return Container();
          //   },
          // ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: onPressed,
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Icon(Icons.logout),
                width8,
                const Text('Deconnexion'),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
