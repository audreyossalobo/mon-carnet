class ConsultationModel {
  final int? id;
  final int patientId;
  final int medecinId;
  final int? rdvId;
  final DateTime dateHeure;
  final String motif;
  final String? diagnostic;
  final String? notes;
  final String? ordonnance;
  final DateTime createdAt;

  ConsultationModel({
    this.id,
    required this.patientId,
    required this.medecinId,
    this.rdvId,
    required this.dateHeure,
    required this.motif,
    this.diagnostic,
    this.notes,
    this.ordonnance,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'patient_id': patientId,
      'medecin_id': medecinId,
      'rdv_id': rdvId,
      'date_heure': dateHeure.toIso8601String(),
      'motif': motif,
      'diagnostic': diagnostic,
      'notes': notes,
      'ordonnance': ordonnance,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory ConsultationModel.fromMap(Map<String, dynamic> map) {
    return ConsultationModel(
      id: map['id'] as int?,
      patientId: map['patient_id'] as int,
      medecinId: map['medecin_id'] as int,
      rdvId: map['rdv_id'] as int?,
      dateHeure: DateTime.parse(map['date_heure'] as String),
      motif: map['motif'] as String,
      diagnostic: map['diagnostic'] as String?,
      notes: map['notes'] as String?,
      ordonnance: map['ordonnance'] as String?,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }
}