part of 'schedule_bloc.dart';

sealed class SchedulesEvent extends Equatable {
  const SchedulesEvent();

  @override
  List<Object> get props => [];
}

class GetSchedules extends SchedulesEvent {
  const GetSchedules();

  @override
  List<Object> get props => [];
}

class UpdateSchedules extends SchedulesEvent {
  const UpdateSchedules(this.schedules);

  final SchedulesModel schedules;

  @override
  List<Object> get props => [schedules];
}
