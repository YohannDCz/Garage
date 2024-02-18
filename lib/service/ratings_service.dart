import 'dart:async';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../model/rating_model.dart';

class RatingsService {
  final snackbarStreamController = StreamController<String>.broadcast();
  Stream<String> get snackbarStream => snackbarStreamController.stream;

  Future<List<Rating>> getRatings() async {
    final List<Map<String, dynamic>> response;
    List<Rating> ratings = [];

    try {
      response = await Supabase.instance.client.from('ratings').select().order('created_at', ascending: false);
      ratings = response.map((e) => Rating.fromMap(e)).toList();
    } catch (e) {
      debugPrint('Erreur lors de la récupération des voitures : $e');
    }

    return ratings;
  }

  Future<void> addRating(Rating rating) async {
    var uuid = const Uuid(); // produit une instance de la classe Uuid
    String id = uuid.v4(); // Génère un id unique

    var ratingToInsert = {
      'id': id,
      'title': rating.title,
      'rate': rating.rate,
      'comment': rating.comment,
      'validated': false,
      'deleted': false,
      'created_at': DateTime.now().toString(),
    };

    try {
      await Supabase.instance.client.rest.from('ratings').upsert([ratingToInsert]);
      snackbarStreamController.add('Témoignage ajoutée avec succès.');
    } catch (e) {
      snackbarStreamController.add('Impossible d\'ajouter votre témoignage.');
      debugPrint("$e");
      return;
    }
  }

  Future<void> updateRating(String id, {bool? deleted, bool? validated}) async {
    try {
      await Supabase.instance.client.from('ratings').update({
        if (deleted != null) 'deleted': deleted,
        if (validated != null) 'validated': validated,
      }).eq('id', id);
      snackbarStreamController.add('Témoignage mis à jour avec succès.');
    } catch (e) {
      snackbarStreamController.add('Impossible de mettre à jour le témoignage.');
      debugPrint("Erreur lors de l'update du rating: $e");
      return;
    }
  }
}
