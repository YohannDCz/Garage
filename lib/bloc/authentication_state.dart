part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthSuccess extends AuthenticationState {}

class AuthFailed extends AuthenticationState {}

class AuthLoading extends AuthenticationState {}

class Deauthenticated extends AuthenticationState {}
