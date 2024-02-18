// ignore_for_file: unnecessary_final

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../service/auth_service.dart';
import '../model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required this.authenticationService}) : super(AuthenticationInitial()) {
    on<EmailAndPasswordLogin>((event, emit) async {
      emit(AuthLoading());

      try {
        await authenticationService.login(event.user);
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailed());
      }
    });

    on<EmailAndPasswordSignUp>((event, emit) async {
      emit(AuthLoading());

      try {
        final response = await authenticationService.emailAndPasswordSignUp(event.user, event.key);
        if (response.user == null) {
          throw SupabaseRealtimeError();
        }
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailed());
      }
    });

    on<EmployeeSignUp>((event, emit) async {
      emit(AuthLoading());

      try {
        final response = await authenticationService.employeeSignUp(event.user);
        if (response.user == null) {
          throw SupabaseRealtimeError();
        }
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailed());
      }
    });

    on<ReAuthenticate>((event, emit) async {
      emit(AuthenticationInitial());
    });

    on<Logout>((event, emit) async {
      emit(AuthLoading());

      try {
        await authenticationService.logout();
        emit(Deauthenticated());
      } catch (e) {
        emit(AuthFailed());
      }
    });
  }
  final AuthenticationService authenticationService;
}
