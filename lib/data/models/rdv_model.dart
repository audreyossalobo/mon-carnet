class RdvModel {
  final int? id;
  final int patientId;
  final int medecinId;
  final DateTime dateHeure;
  final String motif;
  final String statut; // 'en_attente', 'confirme', 'termine', 'annule'
  final String? notes;
  final DateTime createdAt;

  RdvModel({
    this.id,
    required this.patientId,
    required this.medecinId,
    required this.dateHeure,
    required this.motif,
    required this.statut,
    this.notes,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patient_id': patientId,
      'medecin_id': medecinId,
      'date_heure': dateHeure.toIso8601String(),
      'motif': motif,
      'statut': statut,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory RdvModel.fromMap(Map<String, dynamic> map) {
    return RdvModel(
      id: map['id'] as int?,
      patientId: map['patient_id'] as int,
      medecinId: map['medecin_id'] as int,
      dateHeure: DateTime.parse(map['date_heure'] as String),
      motif: map['motif'] as String,
      statut: map['statut'] as String,
      notes: map['notes'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  RdvModel copyWith({
    int? id,
    int? patientId,
    int? medecinId,
    DateTime? dateHeure,
    String? motif,
    String? statut,
    String? notes,
    DateTime? createdAt,
  }) {
    return RdvModel(
      id: id ?? this.id,
      patientId: patientId ?? this.patientId,
      medecinId: medecinId ?? this.medecinId,
      dateHeure: dateHeure ?? this.dateHeure,
      motif: motif ?? this.motif,
      statut: statut ?? this.statut,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}