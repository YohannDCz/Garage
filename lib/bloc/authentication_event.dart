// ignore_for_file: public_member_api_docs,
part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent {}

class ReAuthenticate extends AuthenticationEvent {}

class Logout extends AuthenticationEvent {}

class EmployeeSignUp extends AuthenticationEvent {
  EmployeeSignUp({
    required this.user,
  });
  final CustomUser user;
}

class EmailAndPasswordLogin extends AuthenticationEvent {
  EmailAndPasswordLogin({
    required this.user,
  });
  final AppUser user;
}

class EmailAndPasswordSignUp extends AuthenticationEvent {
  EmailAndPasswordSignUp({required this.user, this.key});
  final AppUser user;
  final String? key;
}
