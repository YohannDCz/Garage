part of 'cars_bloc.dart';

sealed class CarsState extends Equatable {
  const CarsState();
  @override
  List<Object> get props => [];
}

class CarsInitial extends CarsState {
  const CarsInitial({this.cars = const []});

  final List<Car> cars;

  @override
  List<Object> get props => [cars];
}

final class CarLoading extends CarsState {}

final class CarFetchReady extends CarsState {
  const CarFetchReady({required this.cars});

  final List<Car> cars;

  @override
  List<Object> get props => [cars];
}

final class CarFetchError extends CarsState {
  const CarFetchError({required this.error});

  final String error;

  @override
  List<Object> get props => [error];
}
