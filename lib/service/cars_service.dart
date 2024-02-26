import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../model/car_model.dart';

class CarsService {
  final snackbarStreamController = StreamController<String>.broadcast();
  Stream<String> get snackbarStream => snackbarStreamController.stream;

  Future<List<Car>> getCars() async {
    final List<Map<String, dynamic>> response;
    List<Car> cars = [];

    try {
      response = await Supabase.instance.client.from('cars').select().order('created_at', ascending: false);
      cars = response.map((e) => Car.fromMap(e)).toList();
    } catch (e) {
      debugPrint('Erreur lors de la récupération des voitures : $e');
    }

    return cars;
  }

  Future<Car?> getCar(String id) async {
    final Map<String, dynamic> response;
    try {
      response = await Supabase.instance.client.from('cars').select().eq('id', id).single();
      if (response.isNotEmpty) {
        return Car.fromMap(response);
      }
    } catch (e) {
      debugPrint('Erreur lors de la récupération de la voiture : $e');
    }
    return null;
  }

  Future<void> addCar(Car car) async {
    var uuid = const Uuid(); // produit une instance de la classe Uuid
    String id = uuid.v4(); // Génère un id unique

    var carToInsert = {
      'id': id,
      'type': car.type,
      'model': car.model,
      'price': car.price,
      'year': car.year,
      'kilometers': car.kilometers,
      'image': car.image,
      'equipments': car.equipments,
      'created_at': DateTime.now().toString(),
    };

    try {
      await Supabase.instance.client.rest.from('cars').upsert([carToInsert]);
      snackbarStreamController.add('Voiture ajoutée avec succès.');
    } catch (e) {
      snackbarStreamController.add('Impossible d\'ajouter cette voiture.');
      return;
    }
  }

  Future<void> updateCar(Car car) async {
    var carToUpdate = {
      'id': car.id,
      'type': car.type,
      'model': car.model,
      'price': car.price,
      'year': car.year,
      'kilometers': car.kilometers,
      'image': car.image,
      'equipments': car.equipments,
      'created_at': car.created_at,
    };

    /// Performe la requete d'insertion
    try {
      await Supabase.instance.client.rest.from('cars').upsert([carToUpdate]);
      snackbarStreamController.add('Modification de la voiture avec succès.');
    } catch (e) {
      snackbarStreamController.add('Impossible de mettre à jour cette voiture.');
      return;
    }
  }

  Future<void> deleteCar(String id) async {
    /// Performe la requete de deletion
    await Supabase.instance.client.rest.from('cars').delete().eq('id', id);
  }

  List<Car> filterCars(List<Car> cars,
      {required int minPrice,
      required int maxPrice,
      required int minYear,
      required int maxYear,
      required int minKilometers,
      required int maxKilometers}) {
    return cars.where((car) {
      bool matchesPrice = (minPrice == 0 || car.price >= minPrice) && (maxPrice == 0 || car.price <= maxPrice);
      bool matchesYear = (minYear == 0 || car.year >= minYear) && (maxYear == 0 || car.year <= maxYear);
      bool matchesKilometers = (minKilometers == 0 || car.kilometers >= minKilometers) &&
          (maxKilometers == 0 || car.kilometers <= maxKilometers);
      return matchesPrice && matchesYear && matchesKilometers;
    }).toList();
  }
}
