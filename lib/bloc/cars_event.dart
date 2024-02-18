part of 'cars_bloc.dart';

sealed class CarsEvent extends Equatable {
  const CarsEvent();

  @override
  List<Object?> get props => [];
}

class GetInitialCars extends CarsEvent {}

class CarReady extends CarsEvent {
  const CarReady({required this.cars});

  final List<Car> cars;

  @override
  List<Object> get props => [cars];
}

class NewCar extends CarsEvent {
  const NewCar({required this.car});

  final Car car;

  @override
  List<Object> get props => [car];
}

class FilteredCars extends CarsEvent {
  const FilteredCars({this.minYear, this.maxYear, this.minKilometers, this.maxKilometers, this.minPrice, this.maxPrice});

  final int? minYear;
  final int? maxYear;
  final int? minKilometers;
  final int? maxKilometers;
  final int? minPrice;
  final int? maxPrice;

  @override
  List<Object?> get props => [minYear, maxYear, minKilometers, maxKilometers, minPrice, maxPrice];
}
