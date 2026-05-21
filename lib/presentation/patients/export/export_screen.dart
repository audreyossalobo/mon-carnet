import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

class ExportScreen extends StatefulWidget {
  const ExportScreen({super.key});

  @override
  State<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends State<ExportScreen> {
  String _formatSelectionne = 'PDF';
  bool _qrCodeGenere = false;

  final List<Map<String, dynamic>> _contenus = [
    {
      'titre': 'Consultations',
      'description': 'Historique des consultations m\u00e9dicales',
      'selectionne': true,
    },
    {
      'titre': 'Prescriptions',
      'description': 'Ordonnances et traitements prescrits',
      'selectionne': true,
    },
    {
      'titre': 'Analyses m\u00e9dicales',
      'description': 'R\u00e9sultats des examens et analyses',
      'selectionne': true,
    },
    {
      'titre': 'Vaccinations',
      'description': 'Carnet de vaccination',
      'selectionne': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0FAF4),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.paddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBackButton(context),
              const SizedBox(height: AppDimensions.paddingM),
              _buildHeader(),
              const SizedBox(height: AppDimensions.paddingM),
              _buildFormatSection(),
              const SizedBox(height: AppDimensions.paddingM),
              _buildContenuSection(),
              const SizedBox(height: AppDimensions.paddingM),
              _buildActionsSection(),
              const SizedBox(height: AppDimensions.paddingM),
              _buildPartageRapideSection(),
              const SizedBox(height: AppDimensions.paddingL),
            ],
          ),
        ),
      ),
    );
  }

  // ─── BACK BUTTON ──────────────────────────────────────────
  Widget _buildBackButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.arrow_back_ios,
            size: AppDimensions.iconS,
            color: AppColors.textPrimary,
          ),
          SizedBox(width: 4),
          Text(
            'Retour',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: AppDimensions.fontM,
            ),
          ),
        ],
      ),
    );
  }

  // ─── HEADER ───────────────────────────────────────────────
  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Exportation du carnet',
          style: TextStyle(
            fontSize: AppDimensions.fontXXL,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1B4332),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'T\u00e9l\u00e9chargez ou partagez votre dossier m\u00e9dical',
          style: TextStyle(
            fontSize: AppDimensions.fontM,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  // ─── FORMAT SECTION ───────────────────────────────────────
  Widget _buildFormatSection() {
    return _buildCard(
      headerColor: const Color(0xFFECFDF5),
      headerIcon: Icons.description_outlined,
      headerIconColor: const Color(0xFF059669),
      headerTitle: 'Format d\'exportation',
      headerTitleColor: const Color(0xFF065F46),
      child: Column(
        children: [
          const SizedBox(height: AppDimensions.paddingM),
          _buildFormatOption(
            label: 'PDF',
            description: 'Document universel, facile \u00e0 imprimer',
            isSelected: _formatSelectionne == 'PDF',
            onTap: () => setState(() => _formatSelectionne = 'PDF'),
          ),
          const SizedBox(height: AppDimensions.paddingS),
          _buildFormatOption(
            label: 'JSON',
            description: 'Format structur\u00e9 pour importation',
            isSelected: _formatSelectionne == 'JSON',
            onTap: () => setState(() => _formatSelectionne = 'JSON'),
          ),
        ],
      ),
    );
  }

  Widget _buildFormatOption({
    required String label,
    required String description,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF059669)
                : AppColors.divider,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF059669)
                      : AppColors.divider,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF059669),
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: AppDimensions.paddingM),
            Text(
              label,
              style: const TextStyle(
                fontSize: AppDimensions.fontM,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: AppDimensions.paddingS),
            Text(
              description,
              style: TextStyle(
                fontSize: AppDimensions.fontS,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── CONTENU SECTION ──────────────────────────────────────
  Widget _buildContenuSection() {
    return _buildCard(
      headerColor: const Color(0xFFEEF2FF),
      headerIcon: Icons.list_outlined,
      headerIconColor: const Color(0xFF4F46E5),
      headerTitle: 'Contenu \u00e0 inclure',
      headerTitleColor: const Color(0xFF3730A3),
      child: Column(
        children: [
          const SizedBox(height: AppDimensions.paddingM),
          ...List.generate(_contenus.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(
                  bottom: AppDimensions.paddingS),
              child: _buildContenuItem(index),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildContenuItem(int index) {
    final item = _contenus[index];
    final bool selectionne = item['selectionne'] as bool;

    return GestureDetector(
      onTap: () {
        setState(() {
          _contenus[index]['selectionne'] = !selectionne;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(AppDimensions.paddingM),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: selectionne
                    ? AppColors.textPrimary
                    : AppColors.surface,
                borderRadius:
                    BorderRadius.circular(AppDimensions.radiusS),
                border: Border.all(
                  color: selectionne
                      ? AppColors.textPrimary
                      : AppColors.divider,
                  width: 2,
                ),
              ),
              child: selectionne
                  ? const Icon(
                      Icons.check,
                      color: AppColors.white,
                      size: 16,
                    )
                  : null,
            ),
            const SizedBox(width: AppDimensions.paddingM),
            Text(
              item['titre'] as String,
              style: const TextStyle(
                fontSize: AppDimensions.fontM,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: AppDimensions.paddingS),
            Text(
              item['description'] as String,
              style: TextStyle(
                fontSize: AppDimensions.fontS,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ─── ACTIONS SECTION ──────────────────────────────────────
  Widget _buildActionsSection() {
    return _buildCard(
      headerColor: const Color(0xFFF5F3FF),
      headerIcon: Icons.download_outlined,
      headerIconColor: const Color(0xFF7C3AED),
      headerTitle: 'Actions',
      headerTitleColor: const Color(0xFF5B21B6),
      child: Column(
        children: [
          const SizedBox(height: AppDimensions.paddingM),
          // Télécharger
          SizedBox(
            width: double.infinity,
            height: AppDimensions.buttonHeight,
            child: ElevatedButton.icon(
              onPressed: _onTelecharger,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF059669),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusM),
                ),
              ),
              icon: const Icon(
                Icons.download_outlined,
                color: AppColors.white,
              ),
              label: const Text(
                'T\u00e9l\u00e9charger le carnet',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: AppDimensions.fontM,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.paddingS),
          // Envoyer par email
          SizedBox(
            width: double.infinity,
            height: AppDimensions.buttonHeight,
            child: OutlinedButton.icon(
              onPressed: _onEnvoyerEmail,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                    color: Color(0xFF3B82F6), width: 2),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusM),
                ),
              ),
              icon: const Icon(
                Icons.email_outlined,
                color: Color(0xFF3B82F6),
              ),
              label: const Text(
                'Envoyer par email',
                style: TextStyle(
                  color: Color(0xFF3B82F6),
                  fontSize: AppDimensions.fontM,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.paddingS),
          // Imprimer
          SizedBox(
            width: double.infinity,
            height: AppDimensions.buttonHeight,
            child: OutlinedButton.icon(
              onPressed: _onImprimer,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.divider),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusM),
                ),
              ),
              icon: const Icon(
                Icons.print_outlined,
                color: AppColors.textPrimary,
              ),
              label: const Text(
                'Imprimer',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: AppDimensions.fontM,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ─── PARTAGE RAPIDE SECTION ───────────────────────────────
  Widget _buildPartageRapideSection() {
    return _buildCard(
      headerColor: const Color(0xFFFAF5FF),
      headerIcon: Icons.qr_code_2,
      headerIconColor: const Color(0xFF7C3AED),
      headerTitle: 'Partage rapide',
      headerTitleColor: const Color(0xFF5B21B6),
      child: Column(
        children: [
          const SizedBox(height: AppDimensions.paddingM),
          Text(
            'G\u00e9n\u00e9rez un QR Code pour partager rapidement votre carnet m\u00e9dical avec un professionnel de sant\u00e9',
            style: TextStyle(
              fontSize: AppDimensions.fontS,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimensions.paddingM),
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius:
                  BorderRadius.circular(AppDimensions.radiusM),
              border: Border.all(
                color: AppColors.divider,
                style: BorderStyle.solid,
              ),
            ),
            child: _qrCodeGenere
                ? const Icon(
                    Icons.qr_code_2,
                    size: 100,
                    color: AppColors.textPrimary,
                  )
                : Icon(
                    Icons.qr_code_2,
                    size: 60,
                    color: Colors.grey.shade400,
                  ),
          ),
          const SizedBox(height: AppDimensions.paddingM),
          SizedBox(
            width: double.infinity,
            height: AppDimensions.buttonHeight,
            child: ElevatedButton.icon(
              onPressed: _onGenererQRCode,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7C3AED),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppDimensions.radiusM),
                ),
              ),
              icon: const Icon(
                Icons.qr_code_2,
                color: AppColors.white,
              ),
              label: const Text(
                'G\u00e9n\u00e9rer le QR Code',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: AppDimensions.fontM,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.paddingS),
          Text(
            'Le QR Code sera valide pendant 24 heures',
            style: TextStyle(
              fontSize: AppDimensions.fontXS,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  // ─── CARD HELPER ──────────────────────────────────────────
  Widget _buildCard({
    required Color headerColor,
    required IconData headerIcon,
    required Color headerIconColor,
    required String headerTitle,
    required Color headerTitleColor,
    required Widget child,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingM,
              vertical: AppDimensions.paddingS,
            ),
            decoration: BoxDecoration(
              color: headerColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppDimensions.radiusL),
                topRight: Radius.circular(AppDimensions.radiusL),
              ),
            ),
            child: Row(
              children: [
                Icon(headerIcon,
                    color: headerIconColor,
                    size: AppDimensions.iconM),
                const SizedBox(width: AppDimensions.paddingS),
                Text(
                  headerTitle,
                  style: TextStyle(
                    fontSize: AppDimensions.fontM,
                    fontWeight: FontWeight.w600,
                    color: headerTitleColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingM),
            child: child,
          ),
        ],
      ),
    );
  }

  // ─── ACTIONS ──────────────────────────────────────────────
  void _onTelecharger() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'T\u00e9l\u00e9chargement en $_formatSelectionne en cours...'),
        backgroundColor: const Color(0xFF059669),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
      ),
    );
  }

  void _onEnvoyerEmail() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Envoi par email en cours...'),
        backgroundColor: const Color(0xFF3B82F6),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
      ),
    );
  }

  void _onImprimer() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Impression en cours...'),
        backgroundColor: AppColors.textPrimary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
      ),
    );
  }

  void _onGenererQRCode() {
    setState(() => _qrCodeGenere = true);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            const Text('QR Code g\u00e9n\u00e9r\u00e9 avec succ\u00e8s !'),
        backgroundColor: const Color(0xFF7C3AED),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
      ),
    );
  }
}