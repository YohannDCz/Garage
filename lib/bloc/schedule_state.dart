part of 'schedule_bloc.dart';

sealed class SchedulesState extends Equatable {
  const SchedulesState();

  @override
  List<Object> get props => [];
}

final class SchedulesInitial extends SchedulesState {}

final class SchedulesLoading extends SchedulesState {}

final class SchedulesError extends SchedulesState {}

final class SchedulesFetchReady extends SchedulesState {
  const SchedulesFetchReady(this.schedules);

  final SchedulesModel schedules;

  @override
  List<Object> get props => [schedules];
}
