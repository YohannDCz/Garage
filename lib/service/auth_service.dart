import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../model/user_model.dart';

class AuthenticationService {
  dynamic accessToken;
  ValueNotifier<bool> isLoggedIn = ValueNotifier(false);
  Future<bool> emailUsed = Future.value(false);
  bool incorrectPassword = false;
  String typeOfLoggedUser = 'user';

  /// Crée un stream controller pour afficher des snackbars d'erreur
  /// lorsque l'email est utilisé lors d'une inscription
  final snackbarStreamController = StreamController<String>.broadcast();
  Stream<String> get snackbarStream => snackbarStreamController.stream;

  Future<AppUser?> login(AppUser user) async {
    // Récupère l'utilisateur de la table 'users' en fonction de l'e-mail
    PostgrestMap response;

    try {
      response = await Supabase.instance.client.from('users').select().eq('email', user.email.toLowerCase()).single();
    } catch (e) {
      debugPrint('Erreur lors de la récupération de l\'utilisateur : $e');
      snackbarStreamController.add('Erreur ou alors l\'email n\'est pas utilisé.');

      return null;
    }

    var bytes = utf8.encode(user.password); // Encode en utf8
    var digest = sha256.convert(bytes); // Hash en sha256

    // Compare le mot de passe fourni avec le mot de passe stocké
    if (digest.toString() == response['password']) {
      isLoggedIn.value = true;
      typeOfLoggedUser = response['type'];

      // Si les mots de passe correspondent, renvoie l'utilisateur
      return AppUser(
        email: response['email'],
        password: response['password'],
      );
    } else {
      snackbarStreamController.add('Mauvais mot de passe.');
      return null;
    }
  }

  Future logout() async {
    isLoggedIn.value = false;
  }

  Future emailAndPasswordSignUp(AppUser user, String? key) async {
    var bytes = utf8.encode(user.password); // Encode le mot de passe en utf8
    var digest = sha256.convert(bytes); // Hash en sha256
    var uuid = const Uuid(); // produit une instance de la classe Uuid
    String id = uuid.v4(); // Génère un id unique

    final response = await Supabase.instance.client.from('users').select().eq('email', user.email);

    bool isAdmin = false;
    if (key != null) {
      isAdmin = await verifyKeyAdmin(key);
    }

    var userToInsert = {
      'id': id,
      'email': user.email.toLowerCase(),
      'password': digest.toString(),
      'created_at': DateTime.now().toIso8601String(),
      'type': isAdmin ? 'admin' : 'user',
    };

    /// Performe la requete d'insertion
    if (response.isEmpty) {
      try {
        await Supabase.instance.client.from('users').upsert([userToInsert]);
        isLoggedIn.value = true;
        typeOfLoggedUser = isAdmin ? 'admin' : 'user';
      } catch (e) {
        debugPrint('Erreur lors de l\'exécution de upsert: $e');
      }
    } else {
      snackbarStreamController.add('Cet email est déjà utilisé.');
    }
  }

  Future employeeSignUp(CustomUser user) async {
    var bytes = utf8.encode(user.password); // Encode le mot de passe en utf8
    var digest = sha256.convert(bytes); // Hash en sha256

    var uuid = const Uuid(); // produit une instance de la classe Uuid
    String id = uuid.v4(); // Génère un id unique

    final response = await Supabase.instance.client.from('users').select().eq('email', user.email);

    var userToInsert = {
      'id': id,
      'email': user.email,
      'password': digest.toString(),
      'created_at': DateTime.now().toIso8601String(),
      'type': 'employee',
      'name': user.name,
      'birthdate': user.birthdate?.toUtc().toIso8601String(),
    };

    /// Performe la requete d'insertion
    if (response.isEmpty) {
      try {
        await Supabase.instance.client.from('users').upsert([userToInsert]);
        snackbarStreamController.add('La création de l\'email est un succès.');
      } catch (e) {
        debugPrint('Erreur lors de l\'exécution de upsert: $e');
      }
    } else {
      snackbarStreamController.add('Cet email est déjà utilisé.');
    }

    return null;
  }

  Future<bool> verifyKeyAdmin(String key) async {
    var response = [];

    try {
      response = await Supabase.instance.client.from('adminkey').select();
    } catch (e) {
      debugPrint('Erreur lors de la récupération de l\'admin : $e');
      return false;
    }

    var bytes = utf8.encode(key); // Encode en utf8
    var digest = sha256.convert(bytes); // Hash en sha256

    // Compare le mot de passe fourni avec le mot de passe stocké
    if (digest.toString() == response[0]['key']) {
      return true;
    } else {
      return false;
    }
  }
}
