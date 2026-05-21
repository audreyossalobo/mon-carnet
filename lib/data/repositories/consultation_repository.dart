import '../database/database_helper.dart';
import '../models/consultation_model.dart';

class ConsultationRepository {
  final DatabaseHelper _db = DatabaseHelper.instance;

  // ─── CREER UNE CONSULTATION ───────────────────────────────
  Future<ConsultationModel> createConsultation(
      ConsultationModel consultation) async {
    final id = await _db.insert(
      DatabaseHelper.tableConsultations,
      consultation.toMap(),
    );
    return ConsultationModel.fromMap(
        {...consultation.toMap(), 'id': id});
  }

  // ─── CONSULTATIONS PAR PATIENT ────────────────────────────
  Future<List<ConsultationModel>> getConsultationsByPatient(
      int patientId) async {
    final results = await _db.queryWhere(
      DatabaseHelper.tableConsultations,
      where: 'patient_id = ?',
      whereArgs: [patientId],
      orderBy: 'date_heure DESC',
    );
    return results.map((e) => ConsultationModel.fromMap(e)).toList();
  }

  // ─── CONSULTATIONS PAR MEDECIN ────────────────────────────
  Future<List<ConsultationModel>> getConsultationsByMedecin(
      int medecinId) async {
    final results = await _db.queryWhere(
      DatabaseHelper.tableConsultations,
      where: 'medecin_id = ?',
      whereArgs: [medecinId],
      orderBy: 'date_heure DESC',
    );
    return results.map((e) => ConsultationModel.fromMap(e)).toList();
  }

  // ─── CONSULTATIONS AVEC INFOS MEDECIN ────────────────────
  Future<List<Map<String, dynamic>>> getConsultationsWithMedecinInfo(
      int patientId) async {
    return await _db.rawQuery('''
      SELECT 
        c.*,
        u.nom AS medecin_nom,
        u.prenom AS medecin_prenom,
        m.specialite
      FROM ${DatabaseHelper.tableConsultations} c
      INNER JOIN ${DatabaseHelper.tableMedecins} m ON c.medecin_id = m.id
      INNER JOIN ${DatabaseHelper.tableUsers} u ON m.user_id = u.id
      WHERE c.patient_id = ?
      ORDER BY c.date_heure DESC
    ''', [patientId]);
  }

  // ─── METTRE A JOUR CONSULTATION ───────────────────────────
  Future<bool> updateConsultation(ConsultationModel consultation) async {
    final rowsAffected = await _db.update(
      DatabaseHelper.tableConsultations,
      consultation.toMap(),
      where: 'id = ?',
      whereArgs: [consultation.id],
    );
    return rowsAffected > 0;
  }
}