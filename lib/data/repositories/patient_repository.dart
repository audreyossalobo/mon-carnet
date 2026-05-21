import 'package:mon_app/data/models/patient_model.dart';

import '../database/database_helper.dart';

class PatientRepository {
  final DatabaseHelper _db = DatabaseHelper.instance;

  // ─── RECUPERER PATIENT PAR USER ID ───────────────────────
  Future<PatientModel?> getPatientByUserId(int userId) async {
    final results = await _db.queryWhere(
      DatabaseHelper.tablePatients,
      where: 'user_id = ?',
      whereArgs: [userId],
    );

    if (results.isEmpty) return null;
    return PatientModel.fromMap(results.first);
  }

  // ─── RECUPERER TOUS LES PATIENTS ─────────────────────────
  Future<List<PatientModel>> getAllPatients() async {
    final results = await _db.queryAll(DatabaseHelper.tablePatients);
    return results.map((e) => PatientModel.fromMap(e)).toList();
  }

  // ─── METTRE A JOUR PROFIL PATIENT ────────────────────────
  Future<bool> updatePatient(PatientModel patient) async {
    final rowsAffected = await _db.update(
      DatabaseHelper.tablePatients,
      patient.toMap(),
      where: 'id = ?',
      whereArgs: [patient.id],
    );
    return rowsAffected > 0;
  }

  // ─── RECUPERER PATIENT AVEC INFOS USER ───────────────────
  Future<List<Map<String, dynamic>>> getPatientsWithUserInfo() async {
    return await _db.rawQuery('''
      SELECT 
        p.*,
        u.nom,
        u.prenom,
        u.email,
        u.telephone
      FROM ${DatabaseHelper.tablePatients} p
      INNER JOIN ${DatabaseHelper.tableUsers} u ON p.user_id = u.id
    ''');
  }
}