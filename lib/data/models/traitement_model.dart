class TraitementModel {
  final int? id;
  final int patientId;
  final int medecinId;
  final String nom;
  final String dosage;
  final String frequence;
  final String duree;
  final DateTime dateDebut;
  final DateTime dateFin;
  final String? instructions;
  final bool actif;

  TraitementModel({
    this.id,
    required this.patientId,
    required this.medecinId,
    required this.nom,
    required this.dosage,
    required this.frequence,
    required this.duree,
    required this.dateDebut,
    required this.dateFin,
    this.instructions,
    required this.actif,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patient_id': patientId,
      'medecin_id': medecinId,
      'nom': nom,
      'dosage': dosage,
      'frequence': frequence,
      'duree': duree,
      'date_debut': dateDebut.toIso8601String(),
      'date_fin': dateFin.toIso8601String(),
      'instructions': instructions,
      'actif': actif ? 1 : 0,
    };
  }

  factory TraitementModel.fromMap(Map<String, dynamic> map) {
    return TraitementModel(
      id: map['id'] as int?,
      patientId: map['patient_id'] as int,
      medecinId: map['medecin_id'] as int,
      nom: map['nom'] as String,
      dosage: map['dosage'] as String,
      frequence: map['frequence'] as String,
      duree: map['duree'] as String,
      dateDebut: DateTime.parse(map['date_debut'] as String),
      dateFin: DateTime.parse(map['date_fin'] as String),
      instructions: map['instructions'] as String?,
      actif: map['actif'] == 1,
    );
  }
}