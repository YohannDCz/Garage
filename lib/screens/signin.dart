import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/authentication_bloc.dart';
import '../model/user_model.dart';
import '../service/auth_service.dart';
import '../service/validator_service.dart';
import '../theme.dart';
import '../widgets/dialog.dart';
import '../widgets/value_listener.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool _obscureText = true;
  bool isLoading = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final globalKey = GlobalKey<FormState>();

  late final ValueListenableBuilder<bool> loginListener;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    loginListener = ValueListenableBuilder<bool>(
      valueListenable: AuthenticationService().isLoggedIn,
      builder: (context, isLoggedIn, _) {
        if (isLoggedIn) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed('/home');
          });
        }
        return const SizedBox.shrink(); // Retournez votre widget SignIn ici
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: context.read<AuthenticationService>().snackbarStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(snapshot.data!), backgroundColor: AppColors.error));
          });
        }
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(gradient: AppColors.gradient),
            child: SafeArea(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 1000) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 450.0),
                      child: Form(
                        key: globalKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Se connecter',
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.white, fontSize: 24.0),
                                ),
                              ),
                            ),
                            height16,
                            TextFormField(
                              controller: emailController,
                              validator: ValidatorService.validateEmail,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                                prefixIcon: Icon(Icons.email, color: AppColors.secondaryText),
                                hintText: 'Adresse Email',
                                hintStyle: Theme.of(context).textTheme.bodyMedium,
                                errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(99.0),
                                ),
                                filled: true,
                                fillColor: AppColors.white,
                              ),
                            ),
                            height16,
                            TextFormField(
                              controller: passwordController,
                              validator: (value) => ValidatorService.validatePassword(value, context),
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                                prefixIcon: Icon(Icons.lock, color: AppColors.secondaryText),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureText ? Icons.visibility : Icons.visibility_off,
                                    color: AppColors.secondaryText,
                                  ),
                                  onPressed: _togglePasswordVisibility,
                                ),
                                hintText: 'Mot de passe',
                                hintStyle: Theme.of(context).textTheme.bodyMedium,
                                errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(99.0),
                                ),
                                filled: true,
                                fillColor: AppColors.white,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil('/signup', (route) => false);
                                },
                                child: Text(
                                  'S\'inscrire',
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.white, decoration: TextDecoration.underline),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 200.0,
                              height: 48.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  isLoading = true;
                                  if (globalKey.currentState!.validate()) {
                                    try {
                                      BlocProvider.of<AuthenticationBloc>(context).add(EmailAndPasswordLogin(user: AppUser(email: emailController.text, password: passwordController.text)));
                                    } catch (e) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => GestureDetector(
                                          onTap: () {},
                                          child: const CustomDialog(
                                            title: "Echec d'authentification",
                                            message: "Les données sont incorrectes, veuillez réessayez",
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                  isLoading = false;
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(99.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                ),
                                child: isLoading
                                    ? Center(
                                        child: SizedBox(
                                        width: 32,
                                        height: 32,
                                        child: CircularProgressIndicator(
                                          color: AppColors.white,
                                        ),
                                      ))
                                    : Text(
                                        'Valider',
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.white),
                                      ),
                              ),
                            ),
                            const ValueListener()
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: Form(
                        key: globalKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Se connecter',
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.white, fontSize: 24.0),
                                ),
                              ),
                            ),
                            height16,
                            TextFormField(
                              controller: emailController,
                              validator: ValidatorService.validateEmail,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                                prefixIcon: Icon(Icons.email, color: AppColors.secondaryText),
                                hintText: 'Adresse Email',
                                hintStyle: Theme.of(context).textTheme.bodyMedium,
                                errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(99.0),
                                ),
                                filled: true,
                                fillColor: AppColors.white,
                              ),
                            ),
                            height16,
                            TextFormField(
                              controller: passwordController,
                              validator: (value) => ValidatorService.validatePassword(value, context),
                              obscureText: _obscureText,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                                prefixIcon: Icon(Icons.lock, color: AppColors.secondaryText),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureText ? Icons.visibility : Icons.visibility_off,
                                    color: AppColors.secondaryText,
                                  ),
                                  onPressed: _togglePasswordVisibility,
                                ),
                                hintText: 'Mot de passe',
                                hintStyle: Theme.of(context).textTheme.bodyMedium,
                                errorStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.white),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(99.0),
                                ),
                                filled: true,
                                fillColor: AppColors.white,
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil('/signup', (route) => false);
                                },
                                child: Text(
                                  'S\'inscrire',
                                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.white, decoration: TextDecoration.underline),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 200.0,
                              height: 48.0,
                              child: ElevatedButton(
                                onPressed: () {
                                  isLoading = true;
                                  if (globalKey.currentState!.validate()) {
                                    try {
                                      BlocProvider.of<AuthenticationBloc>(context).add(EmailAndPasswordLogin(user: AppUser(email: emailController.text, password: passwordController.text)));
                                    } catch (e) {
                                      showDialog(
                                        context: context,
                                        builder: (context) => GestureDetector(
                                          onTap: () {},
                                          child: const CustomDialog(
                                            title: "Echec d'authentification",
                                            message: "Les données sont incorrectes, veuillez réessayez",
                                          ),
                                        ),
                                      );
                                    }
                                  }
                                  isLoading = false;
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(99.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                ),
                                child: isLoading
                                    ? Center(
                                        child: SizedBox(
                                        width: 32,
                                        height: 32,
                                        child: CircularProgressIndicator(
                                          color: AppColors.white,
                                        ),
                                      ))
                                    : Text(
                                        'Valider',
                                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.white),
                                      ),
                              ),
                            ),
                            const ValueListener(),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
