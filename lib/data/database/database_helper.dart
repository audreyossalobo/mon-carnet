// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;

  static const String _dbName = 'medicare.db';
  static const int _dbVersion = 1;

  // ─── NOMS DES TABLES ──────────────────────────────────────
  static const String tableUsers = 'users';
  static const String tablePatients = 'patients';
  static const String tableMedecins = 'medecins';
  static const String tableRdv = 'rdv';
  static const String tableTraitements = 'traitements';
  static const String tableConsultations = 'consultations';
  static const String tableNotifications = 'notifications';

  // ─── INSTANCE DB ──────────────────────────────────────────
  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _dbName);

    return await openDatabase(
      path,
      version: _dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onConfigure: _onConfigure,
    );
  }

  // ─── CONFIGURATION ────────────────────────────────────────
  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  // ─── CREATION DES TABLES ──────────────────────────────────
  Future<void> _onCreate(Database db, int version) async {
    await _createTableUsers(db);
    await _createTablePatients(db);
    await _createTableMedecins(db);
    await _createTableRdv(db);
    await _createTableTraitements(db);
    await _createTableConsultations(db);
    await _createTableNotifications(db);
    await _insertDemoData(db);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Pour les futures migrations
  }

  // ─── TABLE USERS ──────────────────────────────────────────
  Future<void> _createTableUsers(Database db) async {
    await db.execute('''
      CREATE TABLE $tableUsers (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT NOT NULL,
        prenom TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        mot_de_passe TEXT NOT NULL,
        role TEXT NOT NULL CHECK(role IN ('patient', 'medecin')),
        telephone TEXT,
        created_at TEXT NOT NULL
      )
    ''');
  }

  // ─── TABLE PATIENTS ───────────────────────────────────────
  Future<void> _createTablePatients(Database db) async {
    await db.execute('''
      CREATE TABLE $tablePatients (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        date_naissance TEXT,
        sexe TEXT CHECK(sexe IN ('M', 'F')),
        adresse TEXT,
        groupe_sanguin TEXT,
        allergies TEXT,
        antecedents TEXT,
        FOREIGN KEY (user_id) REFERENCES $tableUsers(id) ON DELETE CASCADE
      )
    ''');
  }

  // ─── TABLE MEDECINS ───────────────────────────────────────
  Future<void> _createTableMedecins(Database db) async {
    await db.execute('''
      CREATE TABLE $tableMedecins (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        specialite TEXT NOT NULL,
        numero_ordre TEXT,
        hopital TEXT,
        horaires TEXT,
        FOREIGN KEY (user_id) REFERENCES $tableUsers(id) ON DELETE CASCADE
      )
    ''');
  }

  // ─── TABLE RDV ────────────────────────────────────────────
  Future<void> _createTableRdv(Database db) async {
    await db.execute('''
      CREATE TABLE $tableRdv (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        patient_id INTEGER NOT NULL,
        medecin_id INTEGER NOT NULL,
        date_heure TEXT NOT NULL,
        motif TEXT NOT NULL,
        statut TEXT NOT NULL DEFAULT 'en_attente'
          CHECK(statut IN ('en_attente', 'confirme', 'termine', 'annule')),
        notes TEXT,
        created_at TEXT NOT NULL,
        FOREIGN KEY (patient_id) REFERENCES $tablePatients(id) ON DELETE CASCADE,
        FOREIGN KEY (medecin_id) REFERENCES $tableMedecins(id) ON DELETE CASCADE
      )
    ''');
  }

  // ─── TABLE TRAITEMENTS ────────────────────────────────────
  Future<void> _createTableTraitements(Database db) async {
    await db.execute('''
      CREATE TABLE $tableTraitements (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        patient_id INTEGER NOT NULL,
        medecin_id INTEGER NOT NULL,
        nom TEXT NOT NULL,
        dosage TEXT NOT NULL,
        frequence TEXT NOT NULL,
        duree TEXT NOT NULL,
        date_debut TEXT NOT NULL,
        date_fin TEXT NOT NULL,
        instructions TEXT,
        actif INTEGER NOT NULL DEFAULT 1,
        FOREIGN KEY (patient_id) REFERENCES $tablePatients(id) ON DELETE CASCADE,
        FOREIGN KEY (medecin_id) REFERENCES $tableMedecins(id) ON DELETE CASCADE
      )
    ''');
  }

  // ─── TABLE CONSULTATIONS ──────────────────────────────────
  Future<void> _createTableConsultations(Database db) async {
    await db.execute('''
      CREATE TABLE $tableConsultations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        patient_id INTEGER NOT NULL,
        medecin_id INTEGER NOT NULL,
        rdv_id INTEGER,
        date_heure TEXT NOT NULL,
        motif TEXT NOT NULL,
        diagnostic TEXT,
        notes TEXT,
        ordonnance TEXT,
        created_at TEXT NOT NULL,
        FOREIGN KEY (patient_id) REFERENCES $tablePatients(id) ON DELETE CASCADE,
        FOREIGN KEY (medecin_id) REFERENCES $tableMedecins(id) ON DELETE CASCADE,
        FOREIGN KEY (rdv_id) REFERENCES $tableRdv(id) ON DELETE SET NULL
      )
    ''');
  }

  // ─── TABLE NOTIFICATIONS ──────────────────────────────────
  Future<void> _createTableNotifications(Database db) async {
    await db.execute('''
      CREATE TABLE $tableNotifications (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER NOT NULL,
        titre TEXT NOT NULL,
        message TEXT NOT NULL,
        type TEXT NOT NULL,
        lu INTEGER NOT NULL DEFAULT 0,
        created_at TEXT NOT NULL,
        FOREIGN KEY (user_id) REFERENCES $tableUsers(id) ON DELETE CASCADE
      )
    ''');
  }

  // ─── DONNEES DE DEMO ──────────────────────────────────────
  Future<void> _insertDemoData(Database db) async {
    final now = DateTime.now().toIso8601String();

    // Users
    await db.insert(tableUsers, {
      'nom': 'Dupont',
      'prenom': 'Jean',
      'email': 'patient@test.com',
      'mot_de_passe': 'password123',
      'role': 'patient',
      'telephone': '+237 677 123 456',
      'created_at': now,
    });

    await db.insert(tableUsers, {
      'nom': 'Martin',
      'prenom': 'Jean',
      'email': 'medecin@test.com',
      'mot_de_passe': 'password123',
      'role': 'medecin',
      'telephone': '+237 699 987 654',
      'created_at': now,
    });

    // Patient
    await db.insert(tablePatients, {
      'user_id': 1,
      'date_naissance': '1980-05-15',
      'sexe': 'M',
      'adresse': 'Yaoundé, Cameroun',
      'groupe_sanguin': 'A+',
      'allergies': 'Pénicilline',
      'antecedents': 'Hypertension',
    });

    // Medecin
    await db.insert(tableMedecins, {
      'user_id': 2,
      'specialite': 'Généraliste',
      'numero_ordre': 'CM-2024-001',
      'hopital': 'Hôpital Central de Yaoundé',
      'horaires': 'Lun-Ven 08:00-17:00',
    });

    // RDV
    await db.insert(tableRdv, {
      'patient_id': 1,
      'medecin_id': 1,
      'date_heure': DateTime.now()
          .add(const Duration(days: 5))
          .toIso8601String(),
      'motif': 'Contrôle annuel',
      'statut': 'confirme',
      'created_at': now,
    });

    await db.insert(tableRdv, {
      'patient_id': 1,
      'medecin_id': 1,
      'date_heure': DateTime.now()
          .add(const Duration(days: 12))
          .toIso8601String(),
      'motif': 'Bilan sanguin',
      'statut': 'en_attente',
      'created_at': now,
    });

    // Traitements
    await db.insert(tableTraitements, {
      'patient_id': 1,
      'medecin_id': 1,
      'nom': 'Paracétamol',
      'dosage': '500mg',
      'frequence': '3x/jour',
      'duree': '7 jours',
      'date_debut': DateTime.now().toIso8601String(),
      'date_fin': DateTime.now()
          .add(const Duration(days: 7))
          .toIso8601String(),
      'instructions': 'À prendre après les repas',
      'actif': 1,
    });

    await db.insert(tableTraitements, {
      'patient_id': 1,
      'medecin_id': 1,
      'nom': 'Vitamine D',
      'dosage': '1000 UI',
      'frequence': '1x/jour',
      'duree': '30 jours',
      'date_debut': DateTime.now().toIso8601String(),
      'date_fin': DateTime.now()
          .add(const Duration(days: 30))
          .toIso8601String(),
      'instructions': 'À prendre le matin',
      'actif': 1,
    });

    // Consultations
    await db.insert(tableConsultations, {
      'patient_id': 1,
      'medecin_id': 1,
      'date_heure': DateTime.now()
          .subtract(const Duration(days: 15))
          .toIso8601String(),
      'motif': 'Contrôle annuel',
      'diagnostic': 'Bonne santé générale',
      'notes': 'Renouvellement ordonnance Vitamine D',
      'created_at': now,
    });

    await db.insert(tableConsultations, {
      'patient_id': 1,
      'medecin_id': 1,
      'date_heure': DateTime.now()
          .subtract(const Duration(days: 40))
          .toIso8601String(),
      'motif': 'Grippe',
      'diagnostic': 'Grippe saisonnière',
      'notes': 'Repos recommandé, Paracétamol prescrit',
      'created_at': now,
    });

    // Notifications
    await db.insert(tableNotifications, {
      'user_id': 1,
      'titre': 'Rappel RDV',
      'message': 'Vous avez un rendez-vous demain à 14h30.',
      'type': 'rdv',
      'lu': 0,
      'created_at': now,
    });

    await db.insert(tableNotifications, {
      'user_id': 1,
      'titre': 'Rappel Traitement',
      'message': 'N\'oubliez pas de prendre votre Paracétamol.',
      'type': 'traitement',
      'lu': 0,
      'created_at': now,
    });
  }

  // ─── METHODES GENERIQUES CRUD ─────────────────────────────
  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> queryAll(String table) async {
    final db = await database;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryWhere(
    String table, {
    required String where,
    required List<dynamic> whereArgs,
    String? orderBy,
  }) async {
    final db = await database;
    return await db.query(
      table,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
    );
  }

  Future<int> update(
    String table,
    Map<String, dynamic> data, {
    required String where,
    required List<dynamic> whereArgs,
  }) async {
    final db = await database;
    return await db.update(
      table,
      data,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<int> delete(
    String table, {
    required String where,
    required List<dynamic> whereArgs,
  }) async {
    final db = await database;
    return await db.delete(
      table,
      where: where,
      whereArgs: whereArgs,
    );
  }

  Future<List<Map<String, dynamic>>> rawQuery(
    String sql, [
    List<dynamic>? arguments,
  ]) async {
    final db = await database;
    return await db.rawQuery(sql, arguments);
  }

  Future<void> closeDatabase() async {
    final db = await database;
    await db.close();
  }
}