import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

class RdvBookingScreen extends StatefulWidget {
  const RdvBookingScreen({super.key});

  @override
  State<RdvBookingScreen> createState() => _RdvBookingScreenState();
}

class _RdvBookingScreenState extends State<RdvBookingScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  int? _selectedMedecin;
  DateTime _selectedDate = DateTime(2026, 2, 25);
  String? _selectedCreneau;

  final List<Map<String, dynamic>> _medecins = [
    {
      'nom': 'Dr. Martin',
      'specialite': 'M\u00e9decin g\u00e9n\u00e9raliste',
      'disponible': true,
    },
    {'nom': 'Dr. Dubois', 'specialite': 'Cardiologue', 'disponible': true},
    {'nom': 'Dr. Legrand', 'specialite': 'Dermatologue', 'disponible': false},
  ];

  final List<String> _creneaux = [
    '09:00',
    '09:30',
    '10:00',
    '10:30',
    '11:00',
    '14:00',
    '14:30',
    '15:00',
    '15:30',
    '16:00',
  ];

  List<Map<String, dynamic>> get _medecinsFiltres {
    if (_searchQuery.isEmpty) return _medecins;
    return _medecins
        .where(
          (m) =>
              m['nom'].toString().toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ) ||
              m['specialite'].toString().toLowerCase().contains(
                _searchQuery.toLowerCase(),
              ),
        )
        .toList();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: AppColors.primary),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF6FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.paddingM),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBackButton(context),
              const SizedBox(height: AppDimensions.paddingL),
              _buildTitle(),
              const SizedBox(height: AppDimensions.paddingL),
              _buildBookingForm(context),
            ],
          ),
        ),
      ),
    );
  }

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

  Widget _buildTitle() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rendez-vous',
          style: TextStyle(
            fontSize: AppDimensions.fontXXL,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
        Text(
          'G\u00e9rez vos consultations',
          style: TextStyle(
            fontSize: AppDimensions.fontS,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildBookingForm(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        border: Border(top: BorderSide(color: AppColors.primary, width: 3)),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Prendre un rendez-vous',
            style: TextStyle(
              fontSize: AppDimensions.fontM,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingM),
          // Recherche médecin
          const Text(
            'Rechercher un m\u00e9decin',
            style: TextStyle(
              fontSize: AppDimensions.fontS,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingS),
          TextField(
            controller: _searchController,
            onChanged: (value) => setState(() => _searchQuery = value),
            decoration: InputDecoration(
              hintText: 'Nom, sp\u00e9cialit\u00e9...',
              prefixIcon: const Icon(
                Icons.search,
                color: AppColors.textSecondary,
              ),
              filled: true,
              fillColor: AppColors.background,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 2,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.paddingM),
          const Text(
            'Choisissez votre m\u00e9decin',
            style: TextStyle(
              fontSize: AppDimensions.fontS,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingS),
          ..._medecinsFiltres.asMap().entries.map((entry) {
            final index = entry.key;
            final medecin = entry.value;
            final isSelected = _selectedMedecin == index;
            final disponible = medecin['disponible'] as bool;
            return GestureDetector(
              onTap: disponible
                  ? () => setState(() => _selectedMedecin = index)
                  : null,
              child: Container(
                margin: const EdgeInsets.only(bottom: AppDimensions.paddingS),
                padding: const EdgeInsets.all(AppDimensions.paddingM),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryLight
                      : AppColors.background,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  border: Border.all(
                    color: isSelected ? AppColors.primary : AppColors.divider,
                    width: isSelected ? 2 : 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.primaryLight,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.person,
                        color: isSelected ? AppColors.white : AppColors.primary,
                        size: AppDimensions.iconM,
                      ),
                    ),
                    const SizedBox(width: AppDimensions.paddingM),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            medecin['nom'] as String,
                            style: TextStyle(
                              fontSize: AppDimensions.fontM,
                              fontWeight: FontWeight.w600,
                              color: disponible
                                  ? AppColors.textPrimary
                                  : AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            medecin['specialite'] as String,
                            style: const TextStyle(
                              fontSize: AppDimensions.fontS,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!disponible)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingS,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF2F2),
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusFull,
                          ),
                        ),
                        child: const Text(
                          'Indisponible',
                          style: TextStyle(
                            fontSize: AppDimensions.fontXS,
                            color: AppColors.error,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: AppDimensions.paddingM),
          // Date
          Row(
            children: [
              const Text(
                'Date',
                style: TextStyle(
                  fontSize: AppDimensions.fontS,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
              const Text(' *', style: TextStyle(color: AppColors.error)),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingS),
          GestureDetector(
            onTap: _selectDate,
            child: Container(
              padding: const EdgeInsets.all(AppDimensions.paddingM),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                border: Border.all(color: AppColors.divider),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    color: AppColors.primary,
                    size: 18,
                  ),
                  const SizedBox(width: AppDimensions.paddingS),
                  Text(
                    '${_selectedDate.day.toString().padLeft(2, '0')}/${_selectedDate.month.toString().padLeft(2, '0')}/${_selectedDate.year}',
                    style: const TextStyle(
                      fontSize: AppDimensions.fontM,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: _selectDate,
                    child: const Icon(
                      Icons.calendar_month,
                      color: AppColors.primary,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppDimensions.paddingM),
          // Créneaux
          Row(
            children: [
              const Text(
                'Choisissez un cr\u00e9neau',
                style: TextStyle(
                  fontSize: AppDimensions.fontS,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
              const Text(' *', style: TextStyle(color: AppColors.error)),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingS),
          Wrap(
            spacing: AppDimensions.paddingS,
            runSpacing: AppDimensions.paddingS,
            children: _creneaux.map((creneau) {
              final isSelected = _selectedCreneau == creneau;
              return GestureDetector(
                onTap: () => setState(() => _selectedCreneau = creneau),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingM,
                    vertical: AppDimensions.paddingS,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.background,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                    border: Border.all(
                      color: isSelected ? AppColors.primary : AppColors.divider,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 14,
                        color: isSelected
                            ? AppColors.white
                            : AppColors.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        creneau,
                        style: TextStyle(
                          fontSize: AppDimensions.fontS,
                          color: isSelected
                              ? AppColors.white
                              : AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: AppDimensions.paddingL),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _onConfirmer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusM,
                      ),
                    ),
                    minimumSize: const Size(
                      double.infinity,
                      AppDimensions.buttonHeight,
                    ),
                  ),
                  child: const Text(
                    'Confirmer le rendez-vous',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(width: AppDimensions.paddingS),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.textPrimary,
                  side: const BorderSide(color: AppColors.divider),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  ),
                  minimumSize: const Size(0, AppDimensions.buttonHeight),
                ),
                child: const Text('Annuler'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onConfirmer() {
    if (_selectedMedecin == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Veuillez s\u00e9lectionner un m\u00e9decin'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    if (_selectedCreneau == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Veuillez s\u00e9lectionner un cr\u00e9neau'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: const BoxDecoration(
                color: AppColors.secondaryLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: AppColors.secondary,
                size: 36,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingM),
            const Text(
              'RDV confirm\u00e9 !',
              style: TextStyle(
                fontSize: AppDimensions.fontL,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: AppDimensions.paddingS),
            Text(
              'Votre rendez-vous avec ${_medecins[_selectedMedecin!]['nom']} le ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year} \u00e0 $_selectedCreneau a \u00e9t\u00e9 confirm\u00e9.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: AppDimensions.fontS,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        actions: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Retour'),
            ),
          ),
        ],
      ),
    );
  }
}
