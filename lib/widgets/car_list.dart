// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/cars_bloc.dart';
import 'car_card.dart';

class CarList extends StatefulWidget {
  const CarList({super.key});

  @override
  State<CarList> createState() => _CarListState();
}

class _CarListState extends State<CarList> {
  @override
  initState() {
    BlocProvider.of<CarsBloc>(context).add(GetInitialCars());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 228,
      child: BlocBuilder<CarsBloc, CarsState>(
        builder: (context, state) {
          if (state is CarFetchReady) {
            return LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth < 410) {
                  return ListView.builder(
                    itemCount: state.cars.length,
                    itemBuilder: (context, index) {
                      var car = state.cars[index];
                      return CarCard(car: car);
                    },
                  );
                } else {
                  return Wrap(
                    direction: Axis.horizontal,
                    spacing: 8.0, // Espace entre les cartes horizontalement
                    runSpacing: 8.0, // Espace entre les cartes verticalement
                    children: List.generate(state.cars.length, (index) {
                      var car = state.cars[index];
                      return CarCard(car: car);
                    }),
                  );
                }
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
