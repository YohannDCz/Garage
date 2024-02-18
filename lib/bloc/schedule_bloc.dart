import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../model/schedules_model.dart';
import '../service/schedules_service.dart';

part 'schedule_event.dart';
part 'schedule_state.dart';

class SchedulesBloc extends Bloc<SchedulesEvent, SchedulesState> {
  SchedulesBloc({required this.schedulesService}) : super(SchedulesInitial()) {
    on<GetSchedules>((event, emit) async {
      emit(SchedulesLoading());
      try {
        var schedules = await schedulesService.getSchedules();
        emit(SchedulesFetchReady(schedules));
      } catch (e) {
        debugPrint('Erreur lors de la récupération des horaires: $e');
        emit(SchedulesError());
      }
    });
    on<UpdateSchedules>((event, emit) async {
      try {
        await schedulesService.updateSchedules(event.schedules);
        var schedules = await schedulesService.getSchedules();
        emit(SchedulesFetchReady(schedules));
      } catch (e) {
        debugPrint('Erreur lors de la mise à jour des horaires: $e');
        emit(SchedulesError());
      }
    });
  }

  SchedulesService schedulesService;
}
