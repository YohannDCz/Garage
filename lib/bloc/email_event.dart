part of 'email_bloc.dart';

sealed class EmailEvent extends Equatable {
  const EmailEvent();

  @override
  List<Object> get props => [];
}

class EmailSendReady extends EmailEvent {
  const EmailSendReady({required this.email});

  final Email email;

  @override
  List<Object> get props => [email];
}
