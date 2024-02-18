import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../model/car_model.dart';
import '../service/cars_service.dart';

part 'cars_event.dart';
part 'cars_state.dart';

class CarsBloc extends Bloc<CarsEvent, CarsState> {
  CarsBloc({required this.carService}) : super(const CarsInitial(cars: [])) {
    on<GetInitialCars>((event, emit) async {
      emit(CarLoading());
      try {
        _cars = await carService.getCars();
        add(CarReady(cars: _cars));
      } catch (e) {
        emit(const CarsInitial());
        debugPrint("error");
      }
    });
    on<CarReady>((event, emit) async {
      emit(CarFetchReady(cars: event.cars));
    });

    on<NewCar>((event, emit) async {
      try {
        await carService.addCar(event.car);
      } catch (e) {
        emit(const CarsInitial());
        debugPrint("error");
      }
    });

    on<FilteredCars>((event, emit) async {
      emit(CarLoading());
      try {
        _cars = await carService.getCars();
        _cars = carService.filterCars(
          _cars,
          minYear: event.minYear ?? 1950,
          maxYear: event.maxYear ?? 2024,
          minKilometers: event.minKilometers ?? 0,
          maxKilometers: event.maxKilometers ?? 1000000,
          minPrice: event.minPrice ?? 0,
          maxPrice: event.maxPrice ?? 1000000,
        );
        add(CarReady(cars: _cars));
      } catch (e) {
        emit(const CarsInitial());
        debugPrint("error");
      }
    });
  }
  CarsService carService;
  List<Car> _cars = <Car>[];
}
