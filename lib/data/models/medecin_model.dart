class MedecinModel {
  final int? id;
  final int userId;
  final String specialite;
  final String? numeroOrdre;
  final String? hopital;
  final String? horaires;

  MedecinModel({
    this.id,
    required this.userId,
    required this.specialite,
    this.numeroOrdre,
    this.hopital,
    this.horaires,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'specialite': specialite,
      'numero_ordre': numeroOrdre,
      'hopital': hopital,
      'horaires': horaires,
    };
  }

  factory MedecinModel.fromMap(Map<String, dynamic> map) {
    return MedecinModel(
      id: map['id'] as int?,
      userId: map['user_id'] as int,
      specialite: map['specialite'] as String,
      numeroOrdre: map['numero_ordre'] as String?,
      hopital: map['hopital'] as String?,
      horaires: map['horaires'] as String?,
    );
  }
}