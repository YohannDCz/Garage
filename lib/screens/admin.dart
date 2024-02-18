import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../service/auth_service.dart';
import '../theme.dart';
import '../widgets/custom_form.dart';
import '../widgets/scaffold/appbar.dart';
import '../widgets/scaffold/drawer.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  final nameController = TextEditingController();
  final birthdateController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordcontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: MyAppBar(scaffoldKey: scaffoldKey),
      drawer: const MyDrawer(),
      body: StreamBuilder<String>(
        stream: context.read<AuthenticationService>().snackbarStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(snapshot.data!), backgroundColor: AppColors.primaryText));
            });
          }
          // Le reste de votre interface utilisateur va ici
          return SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - kToolbarHeight - MediaQuery.of(context).padding.top,
              decoration: BoxDecoration(gradient: AppColors.gradient),
              child: SafeArea(
                child: CustomForm(
                  formKey: _formKey,
                  nameController: nameController,
                  birthdateController: birthdateController,
                  emailController: emailController,
                  passwordController: passwordController,
                  confirmPasswordcontroller: confirmPasswordcontroller,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
