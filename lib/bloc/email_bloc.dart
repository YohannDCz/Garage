import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../model/email_model.dart';
import '../service/email_service.dart';

part 'email_event.dart';
part 'email_state.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  EmailBloc({required this.emailService}) : super(EmailInitial()) {
    on<EmailSendReady>((event, emit) async {
      emit(EmailLoading());
      try {
        await emailService.recordEmail(event.email);
        await emailService.sendEmail(event.email);
      } catch (e) {
        emit(EmailInitial());
        debugPrint("error");
      }
    });
  }
  EmailService emailService;
}
