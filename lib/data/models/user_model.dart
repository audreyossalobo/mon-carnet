class UserModel {
  final int? id;
  final String nom;
  final String prenom;
  final String email;
  final String motDePasse;
  final String role; // 'patient' ou 'medecin'
  final String? telephone;
  final DateTime createdAt;

  UserModel({
    this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.motDePasse,
    required this.role,
    this.telephone,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'mot_de_passe': motDePasse,
      'role': role,
      'telephone': telephone,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int?,
      nom: map['nom'] as String,
      prenom: map['prenom'] as String,
      email: map['email'] as String,
      motDePasse: map['mot_de_passe'] as String,
      role: map['role'] as String,
      telephone: map['telephone'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  UserModel copyWith({
    int? id,
    String? nom,
    String? prenom,
    String? email,
    String? motDePasse,
    String? role,
    String? telephone,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      prenom: prenom ?? this.prenom,
      email: email ?? this.email,
      motDePasse: motDePasse ?? this.motDePasse,
      role: role ?? this.role,
      telephone: telephone ?? this.telephone,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}