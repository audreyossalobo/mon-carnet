import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/routes/app_routes.dart';

class MedecinDashboardScreen extends StatefulWidget {
  const MedecinDashboardScreen({super.key});

  @override
  State<MedecinDashboardScreen> createState() => _MedecinDashboardScreenState();
}

class _MedecinDashboardScreenState extends State<MedecinDashboardScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _rdvAujourdhui = [
    {'patient': 'Marie Martin', 'heure': '09:00', 'motif': 'Contr\u00f4le'},
    {
      'patient': 'Pierre Dubois',
      'heure': '10:30',
      'motif': 'Premi\u00e8re consultation',
    },
    {
      'patient': 'Sophie Bernard',
      'heure': '14:00',
      'motif': 'Renouvellement ordonnance',
    },
  ];

  final List<Map<String, dynamic>> _patientsRecents = [
    {
      'nom': 'Jean Dupont',
      'dernierVisite': '15 Jan 2026',
      'statut': 'Suivi r\u00e9gulier',
    },
    {
      'nom': 'Marie Lefevre',
      'dernierVisite': '10 Jan 2026',
      'statut': 'Traitement en cours',
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FFFE),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildHeader(),
              Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildActionsRapides(context),
                    const SizedBox(height: AppDimensions.paddingM),
                    _buildSearchBar(),
                    const SizedBox(height: AppDimensions.paddingM),
                    _buildRdvAujourdhui(context),
                    const SizedBox(height: AppDimensions.paddingM),
                    _buildPatientsRecents(context),
                    const SizedBox(height: AppDimensions.paddingM),
                    _buildActiviteSemaine(),
                    const SizedBox(height: AppDimensions.paddingL),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── HEADER ───────────────────────────────────────────────
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      color: AppColors.primary,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  color: AppColors.white,
                  size: AppDimensions.iconL,
                ),
              ),
              const SizedBox(width: AppDimensions.paddingM),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. Martin',
                      style: TextStyle(
                        fontSize: AppDimensions.fontL,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                    Text(
                      'M\u00e9decin G\u00e9n\u00e9raliste',
                      style: TextStyle(
                        fontSize: AppDimensions.fontS,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingM),
          Row(
            children: [
              Expanded(
                child: _buildStatCard('128', 'Patients', Icons.people_outline),
              ),
              const SizedBox(width: AppDimensions.paddingS),
              Expanded(
                child: _buildStatCard(
                  '3',
                  'RDV aujourd\'hui',
                  Icons.calendar_today_outlined,
                ),
              ),
              const SizedBox(width: AppDimensions.paddingS),
              Expanded(
                child: _buildStatCard(
                  '5',
                  'Notifications',
                  Icons.notifications_outlined,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.white, size: AppDimensions.iconM),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: AppDimensions.fontXXL,
              fontWeight: FontWeight.w800,
              color: AppColors.white,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              fontSize: AppDimensions.fontXS,
              color: AppColors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ─── ACTIONS RAPIDES ──────────────────────────────────────
  Widget _buildActionsRapides(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Actions rapides',
            style: TextStyle(
              fontSize: AppDimensions.fontL,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingM),
          Row(
            children: [
              Expanded(
                child: _buildActionBtn(
                  icon: Icons.add,
                  label: 'Nouvelle consultation',
                  bgColor: AppColors.primary,
                  textColor: AppColors.white,
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.nouvelleConsultation,
                  ),
                ),
              ),
              const SizedBox(width: AppDimensions.paddingS),
              Expanded(
                child: _buildActionBtn(
                  icon: Icons.medication_outlined,
                  label: 'Prescrire',
                  bgColor: AppColors.primary,
                  textColor: AppColors.white,
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.nouvellePrescription,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingS),
          Row(
            children: [
              Expanded(
                child: _buildActionBtn(
                  icon: Icons.calendar_today_outlined,
                  label: 'Planning',
                  bgColor: AppColors.surface,
                  textColor: AppColors.primary,
                  borderColor: AppColors.primary,
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.medecinAgenda),
                ),
              ),
              const SizedBox(width: AppDimensions.paddingS),
              Expanded(
                child: _buildActionBtnWithBadge(
                  icon: Icons.people_outline,
                  label: 'Mes Patients',
                  bgColor: AppColors.surface,
                  textColor: AppColors.primary,
                  borderColor: AppColors.primary,
                  badge: 0,
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.medecinPatients),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingS),
          Row(
            children: [
              Expanded(
                child: _buildActionBtn(
                  icon: Icons.notifications_outlined,
                  label: 'Notifications',
                  bgColor: AppColors.surface,
                  textColor: AppColors.textPrimary,
                  borderColor: AppColors.divider,
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRoutes.medecinNotifications,
                  ),
                ),
              ),
              const SizedBox(width: AppDimensions.paddingS),
              Expanded(
                child: _buildActionBtn(
                  icon: Icons.search,
                  label: 'Rechercher patient',
                  bgColor: AppColors.surface,
                  textColor: AppColors.textPrimary,
                  borderColor: AppColors.divider,
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.medecinPatients),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionBtn({
    required IconData icon,
    required String label,
    required Color bgColor,
    required Color textColor,
    Color? borderColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          border: borderColor != null ? Border.all(color: borderColor) : null,
        ),
        child: Column(
          children: [
            Icon(icon, color: textColor, size: AppDimensions.iconM),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: AppDimensions.fontS,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionBtnWithBadge({
    required IconData icon,
    required String label,
    required Color bgColor,
    required Color textColor,
    Color? borderColor,
    required int badge,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          border: borderColor != null ? Border.all(color: borderColor) : null,
        ),
        child: Column(
          children: [
            Icon(icon, color: textColor, size: AppDimensions.iconM),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: AppDimensions.fontS,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            if (badge > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.error,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
                ),
                child: Text(
                  '$badge',
                  style: const TextStyle(
                    fontSize: 10,
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ─── SEARCH BAR ───────────────────────────────────────────
  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Rechercher un patient...',
        prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // ─── RDV AUJOURD'HUI ──────────────────────────────────────
  Widget _buildRdvAujourdhui(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Rendez-vous d\'aujourd\'hui',
                style: TextStyle(
                  fontSize: AppDimensions.fontM,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingS,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
                ),
                child: Text(
                  '${_rdvAujourdhui.length} RDV',
                  style: const TextStyle(
                    fontSize: AppDimensions.fontXS,
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingM),
          ..._rdvAujourdhui.map((rdv) => _buildRdvItem(rdv, context)),
        ],
      ),
    );
  }

  Widget _buildRdvItem(Map<String, dynamic> rdv, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingS),
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: const Border(
          left: BorderSide(color: AppColors.primary, width: 4),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.access_time,
              color: AppColors.white,
              size: AppDimensions.iconM,
            ),
          ),
          const SizedBox(width: AppDimensions.paddingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  rdv['patient'] as String,
                  style: const TextStyle(
                    fontSize: AppDimensions.fontM,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  '${rdv['heure']} \u2022 ${rdv['motif']}',
                  style: const TextStyle(
                    fontSize: AppDimensions.fontS,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          OutlinedButton.icon(
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.medecinPatients),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textPrimary,
              side: const BorderSide(color: AppColors.divider),
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingS,
                vertical: 4,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              ),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            icon: const Icon(Icons.description_outlined, size: 16),
            label: const Text(
              'Dossier',
              style: TextStyle(fontSize: AppDimensions.fontS),
            ),
          ),
        ],
      ),
    );
  }

  // ─── PATIENTS RECENTS ─────────────────────────────────────
  Widget _buildPatientsRecents(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Patients r\u00e9cents',
            style: TextStyle(
              fontSize: AppDimensions.fontM,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingM),
          ..._patientsRecents.map(
            (patient) => _buildPatientItem(patient, context),
          ),
        ],
      ),
    );
  }

  Widget _buildPatientItem(Map<String, dynamic> patient, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingS),
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              color: AppColors.primary,
              size: AppDimensions.iconM,
            ),
          ),
          const SizedBox(width: AppDimensions.paddingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patient['nom'] as String,
                  style: const TextStyle(
                    fontSize: AppDimensions.fontM,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  'Derni\u00e8re visite: ${patient['dernierVisite']}',
                  style: const TextStyle(
                    fontSize: AppDimensions.fontS,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  patient['statut'] as String,
                  style: const TextStyle(
                    fontSize: AppDimensions.fontS,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () =>
                Navigator.pushNamed(context, AppRoutes.medecinPatients),
            icon: const Icon(
              Icons.description_outlined,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // ─── ACTIVITE SEMAINE ─────────────────────────────────────
  Widget _buildActiviteSemaine() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Activit\u00e9 cette semaine',
            style: TextStyle(
              fontSize: AppDimensions.fontM,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingM),
          _buildActiviteRow('Consultations', '24'),
          const Divider(color: AppColors.divider),
          _buildActiviteRow('Prescriptions', '18'),
          const Divider(color: AppColors.divider),
          _buildActiviteRow('Nouveaux patients', '3'),
        ],
      ),
    );
  }

  Widget _buildActiviteRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingS),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: AppDimensions.fontM,
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: AppDimensions.fontM,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
