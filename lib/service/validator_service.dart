import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_service.dart';

class ValidatorService {
  static String? validateRate(String? value) {
    if (value == null || value.isEmpty) {
      return "Ce champ ne peut pas être vide";
    } else if (int.tryParse(value) == null) {
      return "Ce champ doit être un nombre entier";
    } else if (int.parse(value) < 0 || int.parse(value) > 5) {
      return "La note doit être comprise entre 0 et 5";
    } else {
      return null;
    }
  }

  static String? validateLabel(String? value) {
    return value!.isEmpty ? "Ce champ ne peut pas être vide" : null;
  }

  static String? validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Ce champ ne peut pas être vide";
    } else if (int.tryParse(value) == null) {
      return "Ce champ doit être un nombre entier";
    } else {
      return null;
    }
  }

  static String? validateEmail(String? email) {
    var emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z\d-]+(\.[a-zA-Z\d-]+)*\.[a-zA-Z\d-]+$');

    return email!.isEmpty
        ? "Veuillez rentrer une adresse"
        : !emailRegex.hasMatch(email)
            ? "Votre e-mail n'est pas valide"
            : null;
  }

  static String? validatePassword(String? password, BuildContext context) {
    var incorrectPassword = context.read<AuthenticationService>().incorrectPassword;
    return incorrectPassword
        ? "Le mot de passe est incorrect"
        : password!.length < 8
            ? "Doit contenir au moins 8 charactères"
            : null;
  }

  static String? validatePassword2(String? password) {
    return password!.length < 8 ? "Doit contenir au moins 8 charactères" : null;
  }

  static String? validateConfirmPassword(String? password, String? confirmPassword) {
    return confirmPassword != password ? "Les mots de passe sont différents" : null;
  }

  static String? validateName(String? name) {
    return name!.isEmpty ? "Le nom ne peut pas être vide" : null;
  }

  static String? validatePhone(String? phone) {
    return phone!.isEmpty
        ? "Le numéro de téléphone ne peut pas être vide"
        : phone.length < 10
            ? "Veuillez rentrer 10 chiffres"
            : null;
  }

  static String? validateEmail2(String? email) {
    var emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z\d-]+(\.[a-zA-Z\d-]+)*\.[a-zA-Z\d-]+$');

    return email!.isEmpty
        ? "Veuillez rentrer une adresse email."
        : emailRegex.hasMatch(email)
            ? null
            : "Votre e-mail n'est pas valide";
  }

  static String? validateMessage(String? message) {
    return message!.isEmpty ? "Le message ne peut pas être vide" : null;
  }

  static String? validateBirthdate(String? birthdate) {
    int day;
    int month;
    int year;

    if (birthdate == null || birthdate.isEmpty) {
      return "La date de naissance ne peut pas être vide";
    } else if (birthdate.length != 10) {
      return "La date de naissance doit être au format JJ/MM/AAAA";
    }

    day = int.parse(birthdate.substring(0, 2));
    month = int.parse(birthdate.substring(3, 5));
    year = int.parse(birthdate.substring(6, 10));

    if (birthdate.isEmpty) {
      return "La date de naissance ne peut pas être vide";
    } else if (birthdate.length != 10) {
      return "La date de naissance doit être au format JJ/MM/AAAA";
    } else if (day < 1 || day > 31) {
      return "Le jour doit être compris entre 1 et 31";
    } else if (month < 1 || month > 12) {
      return "Le mois doit être compris entre 1 et 12";
    } else if (year < 1900 || year > DateTime.now().year) {
      return "L'année doit être comprise entre 1900 et ${DateTime.now().year}";
    } else {
      return null;
    }
  }
}
