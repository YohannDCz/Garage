import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import '../model/email_model.dart';

class EmailService {
  final snackbarStreamController = StreamController<String>.broadcast();
  Stream<String> get snackbarStream => snackbarStreamController.stream;

  Future<void> recordEmail(Email mail) async {
    var uuid = const Uuid(); // produit une instance de la classe Uuid
    String id = uuid.v4(); // Génère un id unique

    var mailToInsert = {
      'id': id,
      'address': mail.address,
      'name': mail.name,
      'phone': mail.phone,
      'message': mail.message,
      'created_at': DateTime.now().toString(),
    };

    try {
      await Supabase.instance.client.rest.from('mails').upsert([mailToInsert]);
      snackbarStreamController.add('Email envoyé avec succès.');
    } catch (e) {
      debugPrint("$e");
      snackbarStreamController.add('Email non envoyé.');
      return;
    }
  }

  Future<void> sendEmail(Email mail) async {
    final smtpServer = SmtpServer('smtp.gmail.com', username: 'YohannDCz@gmail.com', password: 'ddlq vgdt bbzq hopt');
    // Créer un message
    final message = Message()
      ..from = Address(mail.address)
      ..recipients.add("YohannDCz@gmail.com")
      ..subject = 'Nouveau message de ${mail.name} (${mail.address})'
      ..text = '${mail.message}\nVous pouvez le/la contacter au ${mail.phone}.';

    try {
      final sendReport = await send(message, smtpServer);
      debugPrint('Message sent: $sendReport');
    } on MailerException catch (e) {
      debugPrint('Message not sent: $e');
    }
  }
}
