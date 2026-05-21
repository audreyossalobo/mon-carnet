import 'package:mon_app/data/models/patient_model.dart';
import 'package:mon_app/data/models/user_model.dart';

import '../database/database_helper.dart';
import '../models/medecin_model.dart';

class AuthRepository {
  final DatabaseHelper _db = DatabaseHelper.instance;

  // ─── CONNEXION ────────────────────────────────────────────
  Future<UserModel?> login(String email, String motDePasse) async {
    final results = await _db.queryWhere(
      DatabaseHelper.tableUsers,
      where: 'email = ? AND mot_de_passe = ?',
      whereArgs: [email, motDePasse],
    );

    if (results.isEmpty) return null;
    return UserModel.fromMap(results.first);
  }

  // ─── INSCRIPTION ──────────────────────────────────────────
  Future<UserModel?> register({
    required String nom,
    required String prenom,
    required String email,
    required String motDePasse,
    required String role,
    String? telephone,
  }) async {
    // Vérifier si email existe déjà
    final existing = await _db.queryWhere(
      DatabaseHelper.tableUsers,
      where: 'email = ?',
      whereArgs: [email],
    );

    if (existing.isNotEmpty) return null;

    final user = UserModel(
      nom: nom,
      prenom: prenom,
      email: email,
      motDePasse: motDePasse,
      role: role,
      telephone: telephone,
      createdAt: DateTime.now(),
    );

    final userId = await _db.insert(
      DatabaseHelper.tableUsers,
      user.toMap(),
    );

    // Créer profil patient ou médecin
    if (role == 'patient') {
      await _db.insert(
        DatabaseHelper.tablePatients,
        PatientModel(userId: userId).toMap(),
      );
    } else {
      await _db.insert(
        DatabaseHelper.tableMedecins,
        MedecinModel(
          userId: userId,
          specialite: 'Généraliste',
        ).toMap(),
      );
    }

    return user.copyWith(id: userId);
  }

  // ─── RECUPERER USER PAR ID ────────────────────────────────
  Future<UserModel?> getUserById(int id) async {
    final results = await _db.queryWhere(
      DatabaseHelper.tableUsers,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isEmpty) return null;
    return UserModel.fromMap(results.first);
  }

  // ─── VERIFIER EMAIL EXISTE ────────────────────────────────
  Future<bool> emailExists(String email) async {
    final results = await _db.queryWhere(
      DatabaseHelper.tableUsers,
      where: 'email = ?',
      whereArgs: [email],
    );
    return results.isNotEmpty;
  }
}