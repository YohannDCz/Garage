import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/authentication_bloc.dart';
import '../model/user_model.dart';
import '../service/auth_service.dart';
import '../service/validator_service.dart';
import '../theme.dart';
import '../widgets/dialog.dart';
import '../widgets/spinner.dart';
import '../widgets/value_listener.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _obscureText = true;
  bool _obscureConfirmText = true;
  bool _obscureAdminKeyText = true;
  bool isAdmin = false;
  bool isLoading = false;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final adminKeyController = TextEditingController();
  final globalKey = GlobalKey<FormState>();
  final globalKey1 = GlobalKey<FormState>();

  late final ValueListenableBuilder<bool> loginListener;

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

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmText = !_obscureConfirmText;
    });
  }

  void _toggleAdminKeyVisibility() {
    setState(() {
      _obscureAdminKeyText = !_obscureAdminKeyText;
    });
  }

  @override
  Widget build(BuildContext context) {
    ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(99.0),
      ),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
    );

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
                                  'S\'inscrire',
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
                                hintText: 'Adresse email',
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
                            height16,
                            TextFormField(
                              controller: confirmPasswordController,
                              validator: (value) => ValidatorService.validateConfirmPassword(passwordController.text, confirmPasswordController.text),
                              obscureText: _obscureConfirmText,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                                prefixIcon: Icon(Icons.lock, color: AppColors.secondaryText),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureConfirmText ? Icons.visibility : Icons.visibility_off,
                                    color: AppColors.secondaryText,
                                  ),
                                  onPressed: _toggleConfirmPasswordVisibility,
                                ),
                                hintText: 'Confirmer le mot de passe',
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
                            Visibility(
                              visible: isAdmin,
                              child: TextFormField(
                                controller: adminKeyController,
                                obscureText: _obscureAdminKeyText,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                                  prefixIcon: Icon(Icons.lock, color: AppColors.secondaryText),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureAdminKeyText ? Icons.visibility : Icons.visibility_off,
                                      color: AppColors.secondaryText,
                                    ),
                                    onPressed: _toggleAdminKeyVisibility,
                                  ),
                                  hintText: 'Veuillez entrer la clef administrateur',
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
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamedAndRemoveUntil('/signin', (route) => false);
                                  },
                                  child: Text(
                                    'Déjà inscrit ?',
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.white, decoration: TextDecoration.underline),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isAdmin = !isAdmin;
                                    });
                                  },
                                  child: Text(
                                    isAdmin ? 'Retour' : 'Administrateur ?',
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.white, decoration: TextDecoration.underline),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 200.0,
                              height: 48.0,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    setState(() => isLoading = true);
                                    if (globalKey.currentState!.validate()) {
                                      try {
                                        BlocProvider.of<AuthenticationBloc>(context)
                                            .add(EmailAndPasswordSignUp(user: AppUser(email: emailController.text, password: passwordController.text), key: adminKeyController.text));
                                      } catch (e) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => const CustomDialog(
                                            title: "Echec d'authentification",
                                            message: "Les données sont incorrectes, veuillez réessayez",
                                          ),
                                        );
                                      }
                                    }
                                    setState(() => isLoading = false);
                                  },
                                  style: buttonStyle,
                                  child: isLoading ? const Spinner() : Text('Valider', style: TextStyle(color: AppColors.white))),
                            ),
                            const ValueListener(),
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
                                  'S\'inscrire',
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
                                hintText: 'Adresse email',
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
                            height16,
                            TextFormField(
                              controller: confirmPasswordController,
                              validator: (value) => ValidatorService.validateConfirmPassword(passwordController.text, confirmPasswordController.text),
                              obscureText: _obscureConfirmText,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                                prefixIcon: Icon(Icons.lock, color: AppColors.secondaryText),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscureConfirmText ? Icons.visibility : Icons.visibility_off,
                                    color: AppColors.secondaryText,
                                  ),
                                  onPressed: _toggleConfirmPasswordVisibility,
                                ),
                                hintText: 'Confirmer le mot de passe',
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
                            Visibility(
                              visible: isAdmin,
                              child: TextFormField(
                                controller: adminKeyController,
                                obscureText: _obscureAdminKeyText,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                                  prefixIcon: Icon(Icons.lock, color: AppColors.secondaryText),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureAdminKeyText ? Icons.visibility : Icons.visibility_off,
                                      color: AppColors.secondaryText,
                                    ),
                                    onPressed: _toggleAdminKeyVisibility,
                                  ),
                                  hintText: 'Veuillez entrer la clef administrateur',
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
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamedAndRemoveUntil('/signin', (route) => false);
                                  },
                                  child: Text(
                                    'Déjà inscrit ?',
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.white, decoration: TextDecoration.underline),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isAdmin = !isAdmin;
                                    });
                                  },
                                  child: Text(
                                    isAdmin ? 'Retour' : 'Administrateur ?',
                                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.white, decoration: TextDecoration.underline),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 200.0,
                              height: 48.0,
                              child: ElevatedButton(
                                  onPressed: () async {
                                    setState(() => isLoading = true);
                                    // print("OK");
                                    if (globalKey.currentState!.validate()) {
                                      try {
                                        BlocProvider.of<AuthenticationBloc>(context)
                                            .add(EmailAndPasswordSignUp(user: AppUser(email: emailController.text, password: passwordController.text), key: adminKeyController.text));
                                      } catch (e) {
                                        showDialog(
                                          context: context,
                                          builder: (context) => const CustomDialog(
                                            title: "Echec d'authentification",
                                            message: "Les données sont incorrectes, veuillez réessayez",
                                          ),
                                        );
                                      }
                                    }
                                    setState(() => isLoading = false);
                                  },
                                  style: buttonStyle,
                                  child: isLoading ? const Spinner() : Text('Valider', style: TextStyle(color: AppColors.white))),
                            ),
                            const ValueListener()
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
