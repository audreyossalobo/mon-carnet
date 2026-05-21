import '../database/database_helper.dart';
import '../models/rdv_model.dart';

class RdvRepository {
  final DatabaseHelper _db = DatabaseHelper.instance;

  // ─── CREER UN RDV ─────────────────────────────────────────
  Future<RdvModel> createRdv(RdvModel rdv) async {
    final id = await _db.insert(
      DatabaseHelper.tableRdv,
      rdv.toMap(),
    );
    return rdv.copyWith(id: id);
  }

  // ─── RDV PAR PATIENT ──────────────────────────────────────
  Future<List<RdvModel>> getRdvByPatient(int patientId) async {
    final results = await _db.queryWhere(
      DatabaseHelper.tableRdv,
      where: 'patient_id = ?',
      whereArgs: [patientId],
      orderBy: 'date_heure DESC',
    );
    return results.map((e) => RdvModel.fromMap(e)).toList();
  }

  // ─── RDV A VENIR PAR PATIENT ──────────────────────────────
  Future<List<RdvModel>> getRdvAVenir(int patientId) async {
    final now = DateTime.now().toIso8601String();
    final results = await _db.queryWhere(
      DatabaseHelper.tableRdv,
      where: 'patient_id = ? AND date_heure > ? AND statut != ?',
      whereArgs: [patientId, now, 'annule'],
      orderBy: 'date_heure ASC',
    );
    return results.map((e) => RdvModel.fromMap(e)).toList();
  }

  // ─── RDV PAR MEDECIN ──────────────────────────────────────
  Future<List<RdvModel>> getRdvByMedecin(int medecinId) async {
    final results = await _db.queryWhere(
      DatabaseHelper.tableRdv,
      where: 'medecin_id = ?',
      whereArgs: [medecinId],
      orderBy: 'date_heure DESC',
    );
    return results.map((e) => RdvModel.fromMap(e)).toList();
  }

  // ─── RDV AUJOURD'HUI PAR MEDECIN ─────────────────────────
  Future<List<Map<String, dynamic>>> getRdvAujourdhuiMedecin(
      int medecinId) async {
    final today = DateTime.now();
    final debutJour =
        DateTime(today.year, today.month, today.day).toIso8601String();
    final finJour = DateTime(today.year, today.month, today.day, 23, 59)
        .toIso8601String();

    return await _db.rawQuery('''
      SELECT 
        r.*,
        u.nom,
        u.prenom
      FROM ${DatabaseHelper.tableRdv} r
      INNER JOIN ${DatabaseHelper.tablePatients} p ON r.patient_id = p.id
      INNER JOIN ${DatabaseHelper.tableUsers} u ON p.user_id = u.id
      WHERE r.medecin_id = ? 
        AND r.date_heure BETWEEN ? AND ?
      ORDER BY r.date_heure ASC
    ''', [medecinId, debutJour, finJour]);
  }

  // ─── METTRE A JOUR STATUT RDV ─────────────────────────────
  Future<bool> updateStatutRdv(int rdvId, String statut) async {
    final rowsAffected = await _db.update(
      DatabaseHelper.tableRdv,
      {'statut': statut},
      where: 'id = ?',
      whereArgs: [rdvId],
    );
    return rowsAffected > 0;
  }

  // ─── ANNULER UN RDV ───────────────────────────────────────
  Future<bool> annulerRdv(int rdvId) async {
    return await updateStatutRdv(rdvId, 'annule');
  }

  // ─── SUPPRIMER UN RDV ─────────────────────────────────────
  Future<bool> deleteRdv(int rdvId) async {
    final rowsAffected = await _db.delete(
      DatabaseHelper.tableRdv,
      where: 'id = ?',
      whereArgs: [rdvId],
    );
    return rowsAffected > 0;
  }

  // ─── RDV AVEC INFOS MEDECIN ───────────────────────────────
  Future<List<Map<String, dynamic>>> getRdvWithMedecinInfo(
      int patientId) async {
    return await _db.rawQuery('''
      SELECT 
        r.*,
        u.nom AS medecin_nom,
        u.prenom AS medecin_prenom,
        m.specialite
      FROM ${DatabaseHelper.tableRdv} r
      INNER JOIN ${DatabaseHelper.tableMedecins} m ON r.medecin_id = m.id
      INNER JOIN ${DatabaseHelper.tableUsers} u ON m.user_id = u.id
      WHERE r.patient_id = ?
      ORDER BY r.date_heure DESC
    ''', [patientId]);
  }
}