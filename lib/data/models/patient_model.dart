class PatientModel {
  final int? id;
  final int userId;
  final String? dateNaissance;
  final String? sexe;
  final String? adresse;
  final String? groupeSanguin;
  final String? allergies;
  final String? antecedents;

  PatientModel({
    this.id,
    required this.userId,
    this.dateNaissance,
    this.sexe,
    this.adresse,
    this.groupeSanguin,
    this.allergies,
    this.antecedents,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'date_naissance': dateNaissance,
      'sexe': sexe,
      'adresse': adresse,
      'groupe_sanguin': groupeSanguin,
      'allergies': allergies,
      'antecedents': antecedents,
    };
  }

  factory PatientModel.fromMap(Map<String, dynamic> map) {
    return PatientModel(
      id: map['id'] as int?,
      userId: map['user_id'] as int,
      dateNaissance: map['date_naissance'] as String?,
      sexe: map['sexe'] as String?,
      adresse: map['adresse'] as String?,
      groupeSanguin: map['groupe_sanguin'] as String?,
      allergies: map['allergies'] as String?,
      antecedents: map['antecedents'] as String?,
    );
  }
}