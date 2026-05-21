import '../database/database_helper.dart';
import '../models/traitement_model.dart';

class TraitementRepository {
  final DatabaseHelper _db = DatabaseHelper.instance;

  // ─── CREER UN TRAITEMENT ──────────────────────────────────
  Future<TraitementModel> createTraitement(TraitementModel traitement) async {
    final id = await _db.insert(
      DatabaseHelper.tableTraitements,
      traitement.toMap(),
    );
    return TraitementModel.fromMap({...traitement.toMap(), 'id': id});
  }

  // ─── TRAITEMENTS ACTIFS PAR PATIENT ──────────────────────
  Future<List<TraitementModel>> getTraitementsActifs(int patientId) async {
    final results = await _db.queryWhere(
      DatabaseHelper.tableTraitements,
      where: 'patient_id = ? AND actif = 1',
      whereArgs: [patientId],
      orderBy: 'date_debut DESC',
    );
    return results.map((e) => TraitementModel.fromMap(e)).toList();
  }

  // ─── TOUS LES TRAITEMENTS PAR PATIENT ────────────────────
  Future<List<TraitementModel>> getAllTraitements(int patientId) async {
    final results = await _db.queryWhere(
      DatabaseHelper.tableTraitements,
      where: 'patient_id = ?',
      whereArgs: [patientId],
      orderBy: 'date_debut DESC',
    );
    return results.map((e) => TraitementModel.fromMap(e)).toList();
  }

  // ─── TERMINER UN TRAITEMENT ───────────────────────────────
  Future<bool> terminerTraitement(int traitementId) async {
    final rowsAffected = await _db.update(
      DatabaseHelper.tableTraitements,
      {'actif': 0},
      where: 'id = ?',
      whereArgs: [traitementId],
    );
    return rowsAffected > 0;
  }

  // ─── TRAITEMENTS AVEC INFOS MEDECIN ──────────────────────
  Future<List<Map<String, dynamic>>> getTraitementsWithMedecinInfo(
      int patientId) async {
    return await _db.rawQuery('''
      SELECT 
        t.*,
        u.nom AS medecin_nom,
        u.prenom AS medecin_prenom,
        m.specialite
      FROM ${DatabaseHelper.tableTraitements} t
      INNER JOIN ${DatabaseHelper.tableMedecins} m ON t.medecin_id = m.id
      INNER JOIN ${DatabaseHelper.tableUsers} u ON m.user_id = u.id
      WHERE t.patient_id = ?
      ORDER BY t.date_debut DESC
    ''', [patientId]);
  }
}