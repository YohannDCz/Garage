part of 'email_bloc.dart';

sealed class EmailState extends Equatable {
  const EmailState();

  @override
  List<Object> get props => [];
}

final class EmailInitial extends EmailState {}

final class EmailLoading extends EmailState {}

final class EmailError extends EmailState {}
