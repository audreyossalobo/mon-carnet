import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/routes/app_routes.dart';
import '../../widgets/common/custom_card.dart';
import '../../widgets/patient/rdv_card.dart';
import '../../widgets/patient/traitement_card.dart';
import '../../widgets/patient/consultation_card.dart';

class PatientDashboardScreen extends StatelessWidget {
  const PatientDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingM,
            vertical: AppDimensions.paddingM,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: AppDimensions.paddingM),
              _buildActionsRapides(context),
              const SizedBox(height: AppDimensions.paddingM),
              _buildProchainsRdv(context),
              const SizedBox(height: AppDimensions.paddingM),
              _buildTraitementsEnCours(),
              const SizedBox(height: AppDimensions.paddingM),
              _buildConsultationsRecentes(),
              const SizedBox(height: AppDimensions.paddingL),
            ],
          ),
        ),
      ),
    );
  }

  // HEADER
  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
      ),
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
                      'Jean Dupont',
                      style: TextStyle(
                        fontSize: AppDimensions.fontL,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                    Text(
                      AppStrings.patient,
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStat('12', AppStrings.consultations),
              _buildStatDivider(),
              _buildStat('2', AppStrings.traitements),
              _buildStatDivider(),
              _buildStat('2', 'RDV a venir'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: AppDimensions.fontXL,
            fontWeight: FontWeight.w700,
            color: AppColors.white,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: AppDimensions.fontXS,
            color: AppColors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildStatDivider() {
    return Container(
      height: 30,
      width: 1,
      color: AppColors.white.withValues(alpha: 0.3),
    );
  }

  // ACTIONS RAPIDES
  Widget _buildActionsRapides(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.actionsRapides,
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
                child: _buildActionButton(
                  icon: Icons.calendar_today,
                  label: AppStrings.prendreRdv,
                  isPrimary: true,
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.rdvBooking),
                ),
              ),
              const SizedBox(width: AppDimensions.paddingS),
              Expanded(
                child: _buildActionButtonWithBadge(
                  icon: Icons.notifications_outlined,
                  label: AppStrings.notifications,
                  badge: 3,
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.notifications),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingS),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  icon: Icons.download_outlined,
                  label: AppStrings.exporter,
                  isPrimary: false,
                  onTap: () => Navigator.pushNamed(context, AppRoutes.export),
                ),
              ),
              const SizedBox(width: AppDimensions.paddingS),
              Expanded(
                child: _buildActionButton(
                  icon: Icons.folder_outlined,
                  label: AppStrings.documents,
                  isPrimary: false,
                  onTap: () =>
                      Navigator.pushNamed(context, AppRoutes.documents),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required bool isPrimary,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
        decoration: BoxDecoration(
          color: isPrimary ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          border: Border.all(
            color: isPrimary ? AppColors.primary : AppColors.divider,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isPrimary ? AppColors.white : AppColors.textPrimary,
              size: AppDimensions.iconM,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: AppDimensions.fontS,
                fontWeight: FontWeight.w500,
                color: isPrimary ? AppColors.white : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtonWithBadge({
    required IconData icon,
    required String label,
    required int badge,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppDimensions.paddingM),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          border: Border.all(color: AppColors.primary),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  icon,
                  color: AppColors.textPrimary,
                  size: AppDimensions.iconM,
                ),
                Positioned(
                  top: -6,
                  right: -6,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: AppColors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        badge.toString(),
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppColors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: AppDimensions.fontS,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // PROCHAINS RDV
  Widget _buildProchainsRdv(BuildContext context) {
    return CustomCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                AppStrings.prochainsRdv,
                style: TextStyle(
                  fontSize: AppDimensions.fontL,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, AppRoutes.rdvList),
                child: const Text(
                  AppStrings.voirTout,
                  style: TextStyle(
                    fontSize: AppDimensions.fontS,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingM),
          const RdvCard(
            doctorName: 'Dr. Martin',
            dateTime: '05 juin 2026 14:30',
          ),
          const SizedBox(height: AppDimensions.paddingS),
          const RdvCard(
            doctorName: 'Dr. Legrand',
            dateTime: '12 fev 2026  10:00',
          ),
        ],
      ),
    );
  }

  // TRAITEMENTS EN COURS
  Widget _buildTraitementsEnCours() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.traitementsEnCours,
            style: TextStyle(
              fontSize: AppDimensions.fontL,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingM),
          const TraitementCard(nom: 'Paracetamol', dosage: '500ml 3x/jour'),
          const SizedBox(height: AppDimensions.paddingS),
          const TraitementCard(nom: 'Vitamine D', dosage: '1000 UI 1x/jour'),
        ],
      ),
    );
  }

  // CONSULTATIONS RECENTES
  Widget _buildConsultationsRecentes() {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.consultationsRecentes,
            style: TextStyle(
              fontSize: AppDimensions.fontL,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingM),
          const ConsultationCard(
            motif: 'Controle annuel',
            medecin: 'Dr. Martin',
            date: '15 Jan 2026',
          ),
          const SizedBox(height: AppDimensions.paddingS),
          const ConsultationCard(
            motif: 'Grippe',
            medecin: 'Dr. Dubois',
            date: '03 Dec 2025',
          ),
        ],
      ),
    );
  }
}
