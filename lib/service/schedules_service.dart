import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../model/schedules_model.dart';

class SchedulesService {
  Future<SchedulesModel> getSchedules() async {
    PostgrestList response;
    try {
      response = await Supabase.instance.client.from('schedules').select();
      return response.map((e) => SchedulesModel.fromMap(e)).first;
    } catch (e) {
      debugPrint('Erreur lors de la récupération des schedules : $e');
      rethrow;
    }
  }

  Future<void> updateSchedules(SchedulesModel schedule) async {
    var scheduleToInsert = {
      'id': 0,
      'monday': schedule.monday,
      'tuesday': schedule.tuesday,
      'wednesday': schedule.wednesday,
      'friday': schedule.friday,
      'saturday': schedule.saturday,
      'sunday': schedule.sunday,
    };

    try {
      await Supabase.instance.client.rest.from('schedules').upsert([scheduleToInsert]);
    } catch (e) {
      debugPrint('Impossible d\'ajouter ce schedule : $e');
      rethrow;
    }
  }
}
