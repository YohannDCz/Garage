import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../model/service_model.dart';

class ServicesService {
  final snackbarStreamController = StreamController<String>.broadcast();
  Stream<String> get snackbarStream => snackbarStreamController.stream;

  Future<Map<String, List<Service>>> getServices() async {
    Map<String, List<Service>> services = {};
    PostgrestList response;

    try {
      response = await Supabase.instance.client.from('services').select().filter('category', 'eq', 'carrosserie');
      final carosserie = response.map((e) => Service.fromMap(e)).toList();

      response = await Supabase.instance.client.from('services').select().filter('category', 'eq', 'reparation');
      final reparation = response.map((e) => Service.fromMap(e)).toList();

      response = await Supabase.instance.client.from('services').select().filter('category', 'eq', 'entretien');
      final entretien = response.map((e) => Service.fromMap(e)).toList();

      response = await Supabase.instance.client.from('services').select().filter('category', 'eq', 'controle');
      final controle = response.map((e) => Service.fromMap(e)).toList();

      services = {"carrosserie": carosserie, "reparation": reparation, "entretien": entretien, "controle": controle};

      return services;
    } catch (e) {
      debugPrint('Erreur lors de la récupération des services : $e');
      rethrow;
    }
  }

  Future<void> updateService(Service service) async {
    var serviceToUpdate = {
      'id': service.id,
      'category': service.category,
      'label': service.label,
      'description': service.description,
      'image': service.image,
      'created_at': service.created_at?.toIso8601String(),
    };

    /// Performe la requete d'insertion
    try {
      await Supabase.instance.client.rest.from('services').upsert([serviceToUpdate]);
      snackbarStreamController.add('Modification du service avec succès.');
    } catch (e) {
      snackbarStreamController.add('Impossible de mettre à jour ce service.');
      debugPrint('$e');
      return;
    }
  }
}
