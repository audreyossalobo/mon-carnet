import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';
import '../../../core/constants/app_strings.dart';
import '../../widgets/common/custom_card.dart';

class ConsultationsScreen extends StatefulWidget {
  const ConsultationsScreen({super.key});

  @override
  State<ConsultationsScreen> createState() => _ConsultationsScreenState();
}

class _ConsultationsScreenState extends State<ConsultationsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<Map<String, dynamic>> _consultations = [
    {
      'motif': 'ContrÃ´le annuel',
      'medecin': 'Dr. Martin',
      'specialite': 'GÃ©nÃ©raliste',
      'date': '15 Jan 2026',
      'heure': '09:00',
      'diagnostic': 'Bonne santÃ© gÃ©nÃ©rale',
      'notes': 'Renouvellement ordonnance Vitamine D',
      'statut': 'termine',
    },
    {
      'motif': 'Grippe',
      'medecin': 'Dr. Dubois',
      'specialite': 'PÃ©diatre',
      'date': '03 DÃ©c 2025',
      'heure': '11:30',
      'diagnostic': 'Grippe saisonniÃ¨re',
      'notes': 'Repos recommandÃ©, ParacÃ©tamol prescrit',
      'statut': 'termine',
    },
    {
      'motif': 'Douleurs dorsales',
      'medecin': 'Dr. Bernard',
      'specialite': 'Dermatologue',
      'date': '20 Nov 2025',
      'heure': '15:00',
      'diagnostic': 'Contracture musculaire',
      'notes': 'SÃ©ances de kinÃ©sithÃ©rapie recommandÃ©es',
      'statut': 'termine',
    },
    {
      'motif': 'Bilan sanguin',
      'medecin': 'Dr. Legrand',
      'specialite': 'Cardiologue',
      'date': '05 Oct 2025',
      'heure': '08:30',
      'diagnostic': 'RÃ©sultats normaux',
      'notes': 'LÃ©gÃ¨re carence en Vitamine D dÃ©tectÃ©e',
      'statut': 'termine',
    },
  ];

  List<Map<String, dynamic>> get _consultationsFiltrees {
    if (_searchQuery.isEmpty) return _consultations;
    return _consultations.where((c) {
      return c['motif'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          c['medecin'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          c['diagnostic'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.consultationsRecentes),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingM),
            child: _buildSearchBar(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingM,
            ),
            child: _buildStats(),
          ),
          const SizedBox(height: AppDimensions.paddingM),
          Expanded(
            child: _consultationsFiltrees.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingM,
                    ),
                    itemCount: _consultationsFiltrees.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          bottom: AppDimensions.paddingM,
                        ),
                        child: _buildConsultationItem(
                          _consultationsFiltrees[index],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // â”€â”€â”€ SEARCH BAR â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      onChanged: (value) => setState(() => _searchQuery = value),
      decoration: InputDecoration(
        hintText: 'Rechercher une consultation...',
        prefixIcon: const Icon(Icons.search, color: AppColors.textSecondary),
        suffixIcon: _searchQuery.isNotEmpty
            ? GestureDetector(
                onTap: () {
                  _searchController.clear();
                  setState(() => _searchQuery = '');
                },
                child: const Icon(Icons.clear, color: AppColors.textSecondary),
              )
            : null,
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
      ),
    );
  }

  // â”€â”€â”€ STATS â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildStats() {
    return Row(
      children: [
        _buildStatCard(
          value: _consultations.length.toString(),
          label: 'Total',
          color: AppColors.primary,
          bgColor: AppColors.primaryLight,
        ),
        const SizedBox(width: AppDimensions.paddingS),
        _buildStatCard(
          value: _consultations
              .where((c) => c['statut'] == 'termine')
              .length
              .toString(),
          label: 'TerminÃ©es',
          color: AppColors.secondary,
          bgColor: AppColors.secondaryLight,
        ),
        const SizedBox(width: AppDimensions.paddingS),
        _buildStatCard(
          value: _consultations
              .map((c) => c['medecin'])
              .toSet()
              .length
              .toString(),
          label: 'MÃ©decins',
          color: AppColors.warning,
          bgColor: const Color(0xFFFFFBEB),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String value,
    required String label,
    required Color color,
    required Color bgColor,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.paddingM,
          horizontal: AppDimensions.paddingS,
        ),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: AppDimensions.fontXL,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                fontSize: AppDimensions.fontXS,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // â”€â”€â”€ CONSULTATION ITEM â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  Widget _buildConsultationItem(Map<String, dynamic> consultation) {
    return CustomCard(
      onTap: () => _showConsultationDetail(consultation),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
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
                      consultation['motif'] as String,
                      style: const TextStyle(
                        fontSize: AppDimensions.fontM,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      '${consultation['medecin']} â€¢ ${consultation['specialite']}',
                      style: const TextStyle(
                        fontSize: AppDimensions.fontS,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: AppDimensions.iconS,
                color: AppColors.textSecondary,
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingM),
          const Divider(color: AppColors.divider, height: 1),
          const SizedBox(height: AppDimensions.paddingM),
          Row(
            children: [
              _buildInfoChip(
                icon: Icons.calendar_today,
                label: consultation['date'] as String,
              ),
              const SizedBox(width: AppDimensions.paddingM),
              _buildInfoChip(
                icon: Icons.access_time,
                label: consultation['heure'] as String,
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingS),
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
                  Icons.medical_information_outlined,
                  size: AppDimensions.iconS,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: AppDimensions.paddingS),
                Expanded(
                  child: Text(
                    consultation['diagnostic'] as String,
                    style: const TextStyle(
                      fontSize: AppDimensions.fontS,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip({required IconData icon, required String label}) {
    return Row(
      children: [
        Icon(icon, size: AppDimensions.iconS, color: AppColors.textSecondary),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: AppDimensions.fontS,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  // â”€â”€â”€ DETAIL MODAL â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
  void _showConsultationDetail(Map<String, dynamic> consultation) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusXL),
        ),
      ),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        expand: false,
        builder: (_, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.all(AppDimensions.paddingL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.divider,
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusFull,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingL),
                Text(
                  consultation['motif'] as String,
                  style: const TextStyle(
                    fontSize: AppDimensions.fontXL,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingS),
                Text(
                  '${consultation['medecin']} â€¢ ${consultation['date']} Ã  ${consultation['heure']}',
                  style: const TextStyle(
                    fontSize: AppDimensions.fontS,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingL),
                _buildDetailSection(
                  titre: 'Diagnostic',
                  contenu: consultation['diagnostic'] as String,
                  icon: Icons.medical_information_outlined,
                  color: AppColors.primary,
                ),
                const SizedBox(height: AppDimensions.paddingM),
                _buildDetailSection(
                  titre: 'Notes',
                  contenu: consultation['notes'] as String,
                  icon: Icons.notes_outlined,
                  color: AppColors.secondary,
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
          );
        },
      ),
    );
  }

  Widget _buildDetailSection({
    required String titre,
    required String contenu,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: AppDimensions.iconS, color: color),
              const SizedBox(width: AppDimensions.paddingS),
              Text(
                titre,
                style: TextStyle(
                  fontSize: AppDimensions.fontS,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingS),
          Text(
            contenu,
            style: const TextStyle(
              fontSize: AppDimensions.fontM,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  // â”€â”€â”€ EMPTY STATE â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€
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
              Icons.history,
              color: AppColors.primary,
              size: 40,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingM),
          const Text(
            'Aucune consultation',
            style: TextStyle(
              fontSize: AppDimensions.fontL,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingS),
          const Text(
            'Vos consultations apparaÃ®tront ici',
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
