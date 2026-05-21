import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../widgets/common/custom_card.dart';

class TraitementsScreen extends StatefulWidget {
  const TraitementsScreen({super.key});

  @override
  State<TraitementsScreen> createState() => _TraitementsScreenState();
}

class _TraitementsScreenState extends State<TraitementsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _traitementsEnCours = [
    {
      'nom': 'Paracétamol',
      'dosage': '500mg',
      'frequence': '3x/jour',
      'duree': '7 jours',
      'dateDebut': '10 Jan 2026',
      'dateFin': '17 Jan 2026',
      'medecin': 'Dr. Martin',
      'instructions': 'À prendre après les repas',
      'priseAujourdhui': [true, true, false],
      'couleur': AppColors.primary,
      'couleurBg': AppColors.primaryLight,
    },
    {
      'nom': 'Vitamine D',
      'dosage': '1000 UI',
      'frequence': '1x/jour',
      'duree': '30 jours',
      'dateDebut': '01 Jan 2026',
      'dateFin': '31 Jan 2026',
      'medecin': 'Dr. Legrand',
      'instructions': 'À prendre le matin',
      'priseAujourdhui': [true],
      'couleur': AppColors.secondary,
      'couleurBg': AppColors.secondaryLight,
    },
  ];

  final List<Map<String, dynamic>> _traitementsTermines = [
    {
      'nom': 'Amoxicilline',
      'dosage': '1g',
      'frequence': '2x/jour',
      'duree': '5 jours',
      'dateDebut': '01 Déc 2025',
      'dateFin': '06 Déc 2025',
      'medecin': 'Dr. Dubois',
      'instructions': 'À prendre avec un grand verre d\'eau',
      'priseAujourdhui': [],
      'couleur': AppColors.textSecondary,
      'couleurBg': AppColors.background,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.traitements),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          tabs: const [
            Tab(text: 'En cours'),
            Tab(text: 'Terminés'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTraitementsList(_traitementsEnCours, enCours: true),
          _buildTraitementsList(_traitementsTermines, enCours: false),
        ],
      ),
    );
  }

  // ─── LISTE ────────────────────────────────────────────────
  Widget _buildTraitementsList(
    List<Map<String, dynamic>> liste, {
    required bool enCours,
  }) {
    if (liste.isEmpty) return _buildEmptyState();

    return ListView.builder(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      itemCount: liste.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppDimensions.paddingM),
          child: _buildTraitementItem(liste[index], enCours: enCours),
        );
      },
    );
  }

  // ─── TRAITEMENT ITEM ──────────────────────────────────────
  Widget _buildTraitementItem(
    Map<String, dynamic> traitement, {
    required bool enCours,
  }) {
    final List<bool> prises = List<bool>.from(
      traitement['priseAujourdhui'] as List,
    );
    final int prisesEffectuees = prises.where((p) => p).length;
    final int totalPrises = prises.length;

    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // En-tête
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: traitement['couleurBg'] as Color,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                ),
                child: Icon(
                  Icons.medication_outlined,
                  color: traitement['couleur'] as Color,
                  size: AppDimensions.iconM,
                ),
              ),
              const SizedBox(width: AppDimensions.paddingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      traitement['nom'] as String,
                      style: const TextStyle(
                        fontSize: AppDimensions.fontM,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      '${traitement['dosage']} • ${traitement['frequence']}',
                      style: const TextStyle(
                        fontSize: AppDimensions.fontS,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (enCours)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingS,
                    vertical: AppDimensions.paddingXS,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.secondaryLight,
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusFull,
                    ),
                  ),
                  child: const Text(
                    'En cours',
                    style: TextStyle(
                      fontSize: AppDimensions.fontXS,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondary,
                    ),
                  ),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingS,
                    vertical: AppDimensions.paddingXS,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusFull,
                    ),
                  ),
                  child: const Text(
                    'Terminé',
                    style: TextStyle(
                      fontSize: AppDimensions.fontXS,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: AppDimensions.paddingM),
          const Divider(color: AppColors.divider, height: 1),
          const SizedBox(height: AppDimensions.paddingM),

          // Infos
          Row(
            children: [
              _buildInfoItem(
                icon: Icons.calendar_today,
                label: 'Début',
                value: traitement['dateDebut'] as String,
              ),
              const SizedBox(width: AppDimensions.paddingM),
              _buildInfoItem(
                icon: Icons.event,
                label: 'Fin',
                value: traitement['dateFin'] as String,
              ),
              const SizedBox(width: AppDimensions.paddingM),
              _buildInfoItem(
                icon: Icons.timelapse,
                label: 'Durée',
                value: traitement['duree'] as String,
              ),
            ],
          ),

          const SizedBox(height: AppDimensions.paddingM),

          // Instructions
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppDimensions.paddingS),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  size: AppDimensions.iconS,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: AppDimensions.paddingS),
                Expanded(
                  child: Text(
                    traitement['instructions'] as String,
                    style: const TextStyle(
                      fontSize: AppDimensions.fontS,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Suivi des prises (seulement si en cours)
          if (enCours && prises.isNotEmpty) ...[
            const SizedBox(height: AppDimensions.paddingM),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Prises aujourd\'hui : $prisesEffectuees/$totalPrises',
                  style: const TextStyle(
                    fontSize: AppDimensions.fontS,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimensions.paddingS),
            Row(
              children: List.generate(prises.length, (i) {
                return Padding(
                  padding: const EdgeInsets.only(right: AppDimensions.paddingS),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        prises[i] = !prises[i];
                        traitement['priseAujourdhui'] = prises;
                      });
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: prises[i]
                            ? AppColors.secondary
                            : AppColors.background,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: prises[i]
                              ? AppColors.secondary
                              : AppColors.divider,
                        ),
                      ),
                      child: Icon(
                        prises[i] ? Icons.check : Icons.close,
                        size: AppDimensions.iconS,
                        color: prises[i]
                            ? AppColors.white
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: AppDimensions.paddingS),
            ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
              child: LinearProgressIndicator(
                value: totalPrises > 0 ? prisesEffectuees / totalPrises : 0,
                backgroundColor: AppColors.divider,
                color: AppColors.secondary,
                minHeight: 6,
              ),
            ),
          ],

          const SizedBox(height: AppDimensions.paddingS),

          // Prescrit par
          Row(
            children: [
              const Icon(
                Icons.person_outline,
                size: AppDimensions.iconS,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                'Prescrit par ${traitement['medecin']}',
                style: const TextStyle(
                  fontSize: AppDimensions.fontXS,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: AppDimensions.iconS,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: const TextStyle(
                  fontSize: AppDimensions.fontXS,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(
              fontSize: AppDimensions.fontS,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  // ─── EMPTY STATE ──────────────────────────────────────────
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.secondaryLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.medication_outlined,
              color: AppColors.secondary,
              size: 40,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingM),
          const Text(
            'Aucun traitement',
            style: TextStyle(
              fontSize: AppDimensions.fontL,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingS),
          const Text(
            'Vos traitements apparaîtront ici',
            style: TextStyle(
              fontSize: AppDimensions.fontS,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
