import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/routes/app_routes.dart';

class RdvListScreen extends StatefulWidget {
  const RdvListScreen({super.key});

  @override
  State<RdvListScreen> createState() => _RdvListScreenState();
}

class _RdvListScreenState extends State<RdvListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _rdvAVenir = [
    {
      'medecin': 'Dr. Martin',
      'specialite': 'M\u00e9decin g\u00e9n\u00e9raliste',
      'jour': '05',
      'mois': 'F\u00e9v',
      'heure': '14:30',
      'lieu': 'Cabinet Centre-Ville',
      'statut': 'confirme',
    },
    {
      'medecin': 'Dr. Legrand',
      'specialite': 'Dermatologue',
      'jour': '12',
      'mois': 'F\u00e9v',
      'heure': '10:00',
      'lieu': 'Clinique Saint-Jean',
      'statut': 'confirme',
    },
  ];

  final List<Map<String, dynamic>> _rdvPasses = [
    {
      'medecin': 'Dr. Martin',
      'specialite': 'M\u00e9decin g\u00e9n\u00e9raliste',
      'jour': '15',
      'mois': 'Jan',
      'heure': '09:00',
      'motif': 'Contr\u00f4le annuel',
      'statut': 'termine',
    },
    {
      'medecin': 'Dr. Dubois',
      'specialite': 'Cardiologue',
      'jour': '03',
      'mois': 'D\u00e9c',
      'heure': '15:30',
      'motif': 'Consultation cardiaque',
      'statut': 'termine',
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
      backgroundColor: const Color(0xFFEFF6FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEFF6FF),
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
        ),
        leadingWidth: 40,
        title: const Text(
          'Retour',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: AppDimensions.fontM,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppDimensions.paddingM),
            child: ElevatedButton.icon(
              onPressed: () =>
                  Navigator.pushNamed(context, AppRoutes.rdvBooking),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingM,
                  vertical: AppDimensions.paddingS,
                ),
              ),
              icon: const Icon(Icons.add, color: AppColors.white, size: 18),
              label: const Text(
                'Nouveau RDV',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: AppDimensions.fontS,
                ),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingM,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Rendez-vous',
                  style: TextStyle(
                    fontSize: AppDimensions.fontXXL,
                    fontWeight: FontWeight.w800,
                    color: AppColors.primary,
                  ),
                ),
                const Text(
                  'G\u00e9rez vos consultations',
                  style: TextStyle(
                    fontSize: AppDimensions.fontS,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingS),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.divider,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusM,
                      ),
                    ),
                    labelColor: AppColors.textPrimary,
                    unselectedLabelColor: AppColors.textSecondary,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: AppDimensions.fontS,
                    ),
                    tabs: const [
                      Tab(text: '\u00c0 venir'),
                      Tab(text: 'Pass\u00e9s'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildAVenirList(), _buildPassesList()],
      ),
    );
  }

  // ─── À VENIR ──────────────────────────────────────────────
  Widget _buildAVenirList() {
    if (_rdvAVenir.isEmpty) return _buildEmptyState();
    return ListView.builder(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      itemCount: _rdvAVenir.length,
      itemBuilder: (context, index) => _buildRdvAVenirCard(_rdvAVenir[index]),
    );
  }

  Widget _buildRdvAVenirCard(Map<String, dynamic> rdv) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingM),
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  rdv['mois'] as String,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: AppDimensions.fontXS,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  rdv['jour'] as String,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: AppDimensions.fontL,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppDimensions.paddingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rdv['medecin'] as String,
                  style: const TextStyle(
                    fontSize: AppDimensions.fontM,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  rdv['specialite'] as String,
                  style: const TextStyle(
                    fontSize: AppDimensions.fontS,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      rdv['heure'] as String,
                      style: const TextStyle(
                        fontSize: AppDimensions.fontS,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: AppDimensions.paddingS),
                    const Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        rdv['lieu'] as String,
                        style: const TextStyle(
                          fontSize: AppDimensions.fontS,
                          color: AppColors.textSecondary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.paddingS),
                Row(
                  children: [
                    OutlinedButton(
                      onPressed: () => _onAnnuler(rdv),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.error,
                        side: const BorderSide(color: AppColors.error),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingM,
                          vertical: 4,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusM,
                          ),
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'Annuler',
                        style: TextStyle(fontSize: AppDimensions.fontS),
                      ),
                    ),
                    const SizedBox(width: AppDimensions.paddingS),
                    OutlinedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, AppRoutes.rdvBooking),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textPrimary,
                        side: const BorderSide(color: AppColors.divider),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingM,
                          vertical: 4,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusM,
                          ),
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'Modifier',
                        style: TextStyle(fontSize: AppDimensions.fontS),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── PASSÉS ───────────────────────────────────────────────
  Widget _buildPassesList() {
    if (_rdvPasses.isEmpty) return _buildEmptyState();
    return ListView.builder(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      itemCount: _rdvPasses.length,
      itemBuilder: (context, index) => _buildRdvPasseCard(_rdvPasses[index]),
    );
  }

  Widget _buildRdvPasseCard(Map<String, dynamic> rdv) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingM),
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              border: Border.all(color: AppColors.divider),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  rdv['mois'] as String,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: AppDimensions.fontXS,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  rdv['jour'] as String,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: AppDimensions.fontL,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppDimensions.paddingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rdv['medecin'] as String,
                  style: const TextStyle(
                    fontSize: AppDimensions.fontM,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  rdv['specialite'] as String,
                  style: const TextStyle(
                    fontSize: AppDimensions.fontS,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 14,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      rdv['heure'] as String,
                      style: const TextStyle(
                        fontSize: AppDimensions.fontS,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: AppDimensions.paddingS),
                    Text(
                      rdv['motif'] as String,
                      style: const TextStyle(
                        fontSize: AppDimensions.fontS,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.paddingS),
                OutlinedButton(
                  onPressed: () => _showCompteRendu(rdv),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.textPrimary,
                    side: const BorderSide(color: AppColors.divider),
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingM,
                      vertical: 4,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusM,
                      ),
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text(
                    'Voir le compte-rendu',
                    style: TextStyle(fontSize: AppDimensions.fontS),
                  ),
                ),
              ],
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
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.calendar_today,
              color: AppColors.primary,
              size: 40,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingM),
          const Text(
            'Aucun rendez-vous',
            style: TextStyle(
              fontSize: AppDimensions.fontL,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingS),
          const Text(
            'Prenez votre premier rendez-vous',
            style: TextStyle(
              fontSize: AppDimensions.fontS,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // ─── ACTIONS ──────────────────────────────────────────────
  void _onAnnuler(Map<String, dynamic> rdv) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        ),
        title: const Text('Annuler le RDV ?'),
        content: Text(
          'Voulez-vous annuler votre rendez-vous avec ${rdv['medecin']} ?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Non'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() => _rdvAVenir.remove(rdv));
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Oui, annuler'),
          ),
        ],
      ),
    );
  }

  void _showCompteRendu(Map<String, dynamic> rdv) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusXL),
        ),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.paddingL),
            Text(
              'Compte-rendu - ${rdv['medecin']}',
              style: const TextStyle(
                fontSize: AppDimensions.fontXL,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingS),
            Text(
              '${rdv['jour']} ${rdv['mois']} \u2022 ${rdv['heure']} \u2022 ${rdv['motif']}',
              style: const TextStyle(
                fontSize: AppDimensions.fontS,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingL),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppDimensions.paddingM),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              ),
              child: const Text(
                'Aucune anomalie d\u00e9tect\u00e9e. Patient en bonne sant\u00e9 g\u00e9n\u00e9rale.',
                style: TextStyle(
                  fontSize: AppDimensions.fontM,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: AppDimensions.paddingL),
            SizedBox(
              width: double.infinity,
              height: AppDimensions.buttonHeight,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Fermer'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
