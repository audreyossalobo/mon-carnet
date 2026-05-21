import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/routes/app_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF6FF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingL,
              vertical: AppDimensions.paddingXL,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                _buildLogo(),
                const SizedBox(height: AppDimensions.paddingXL),
                _buildCard(context),
                const SizedBox(height: AppDimensions.paddingXL),
                _buildFeatures(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─── LOGO ─────────────────────────────────────────────────
  Widget _buildLogo() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const Icon(Icons.favorite, color: AppColors.white, size: 40),
        ),
        const SizedBox(height: AppDimensions.paddingM),
        const Text(
          'MediCare+',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: AppDimensions.paddingXS),
        const Text(
          'Votre carnet m\u00e9dical \u00e9lectronique',
          style: TextStyle(
            fontSize: AppDimensions.fontM,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  // ─── CARD ─────────────────────────────────────────────────
  Widget _buildCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.paddingL),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXL),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Bouton Se connecter
          SizedBox(
            width: double.infinity,
            height: AppDimensions.buttonHeight,
            child: ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                ),
              ),
              icon: const Icon(
                Icons.person_outline,
                color: AppColors.white,
                size: 20,
              ),
              label: const Text(
                'Se connecter',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: AppDimensions.fontM,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.paddingM),
          // Bouton Créer un compte
          SizedBox(
            width: double.infinity,
            height: AppDimensions.buttonHeight,
            child: OutlinedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.register),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary, width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                ),
              ),
              child: const Text(
                'Cr\u00e9er un compte',
                style: TextStyle(
                  fontSize: AppDimensions.fontM,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.paddingM),
          // Accès sécurisé
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.lock_outline,
                size: AppDimensions.iconS,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 6),
              const Text(
                'Acc\u00e8s s\u00e9curis\u00e9 et confidentiel',
                style: TextStyle(
                  fontSize: AppDimensions.fontS,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ─── FEATURES ─────────────────────────────────────────────
  Widget _buildFeatures() {
    final features = [
      {
        'icon': Icons.book_outlined,
        'label': 'Carnet\nm\u00e9dical',
        'color': AppColors.primary,
        'bgColor': AppColors.primaryLight,
      },
      {
        'icon': Icons.calendar_today_outlined,
        'label': 'Rendez-\nvous',
        'color': const Color(0xFF7C3AED),
        'bgColor': const Color(0xFFF5F3FF),
      },
      {
        'icon': Icons.medication_outlined,
        'label': 'Prescrip-\ntions',
        'color': const Color(0xFFEC4899),
        'bgColor': const Color(0xFFFDF2F8),
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: features.map((feature) {
        return Column(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: feature['bgColor'] as Color,
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              ),
              child: Icon(
                feature['icon'] as IconData,
                color: feature['color'] as Color,
                size: AppDimensions.iconM,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingS),
            Text(
              feature['label'] as String,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: AppDimensions.fontXS,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}
