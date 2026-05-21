import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

class NouvellePrescriptionScreen extends StatefulWidget {
  const NouvellePrescriptionScreen({super.key});

  @override
  State<NouvellePrescriptionScreen> createState() =>
      _NouvellePrescriptionScreenState();
}

class _NouvellePrescriptionScreenState
    extends State<NouvellePrescriptionScreen> {
  final _patientController = TextEditingController();
  final _dateController = TextEditingController();
  final _notesController = TextEditingController();

  final List<Map<String, dynamic>> _medicaments = [
    {
      'nom': TextEditingController(),
      'dosage': TextEditingController(),
      'frequence': null,
      'duree': null,
      'instructions': TextEditingController(),
    },
  ];

  final List<String> _frequences = [
    '1x/jour',
    '2x/jour',
    '3x/jour',
    '4x/jour',
    'Selon besoin',
  ];
  final List<String> _durees = [
    '3 jours',
    '5 jours',
    '7 jours',
    '14 jours',
    '30 jours',
    '3 mois',
    '6 mois',
  ];

  @override
  void dispose() {
    _patientController.dispose();
    _dateController.dispose();
    _notesController.dispose();
    for (var med in _medicaments) {
      (med['nom'] as TextEditingController).dispose();
      (med['dosage'] as TextEditingController).dispose();
      (med['instructions'] as TextEditingController).dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8FF),
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
              _buildInfoGenerales(),
              const SizedBox(height: AppDimensions.paddingM),
              _buildMedicamentsSection(),
              const SizedBox(height: AppDimensions.paddingM),
              _buildNotesSection(),
              const SizedBox(height: AppDimensions.paddingL),
              _buildButtons(context),
              const SizedBox(height: AppDimensions.paddingL),
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

  Widget _buildHeader() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Nouvelle prescription',
          style: TextStyle(
            fontSize: AppDimensions.fontXXL,
            fontWeight: FontWeight.w800,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Cr\u00e9er une ordonnance pour un patient',
          style: TextStyle(
            fontSize: AppDimensions.fontS,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoGenerales() {
    return _buildSection(
      headerColor: const Color(0xFFEFF6FF),
      headerIcon: Icons.person_outline,
      headerIconColor: AppColors.primary,
      headerTitle: 'Informations g\u00e9n\u00e9rales',
      headerTitleColor: AppColors.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildRequiredLabel('Patient'),
          const SizedBox(height: AppDimensions.paddingS),
          TextField(
            controller: _patientController,
            decoration: _inputDecoration(
              'Nom du patient',
              Icons.person_outline,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingM),
          _buildRequiredLabel('Date de prescription'),
          const SizedBox(height: AppDimensions.paddingS),
          GestureDetector(
            onTap: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                builder: (context, child) => Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: AppColors.primary,
                    ),
                  ),
                  child: child!,
                ),
              );
              if (picked != null) {
                _dateController.text =
                    '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
                setState(() {});
              }
            },
            child: Container(
              padding: const EdgeInsets.all(AppDimensions.paddingM),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
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
                    _dateController.text.isEmpty
                        ? 'jj/mm/aaaa'
                        : _dateController.text,
                    style: TextStyle(
                      fontSize: AppDimensions.fontM,
                      color: _dateController.text.isEmpty
                          ? AppColors.textHint
                          : AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.calendar_month,
                    color: AppColors.textSecondary,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicamentsSection() {
    return _buildSection(
      headerColor: const Color(0xFFF5F3FF),
      headerIcon: Icons.medication_outlined,
      headerIconColor: const Color(0xFF7C3AED),
      headerTitle: 'M\u00e9dicaments prescrits',
      headerTitleColor: const Color(0xFF5B21B6),
      headerAction: GestureDetector(
        onTap: () {
          setState(() {
            _medicaments.add({
              'nom': TextEditingController(),
              'dosage': TextEditingController(),
              'frequence': null,
              'duree': null,
              'instructions': TextEditingController(),
            });
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingM,
            vertical: AppDimensions.paddingXS,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF7C3AED),
            borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.add, color: Colors.white, size: 16),
              SizedBox(width: 4),
              Text(
                'Ajouter',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: AppDimensions.fontS,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
      child: Column(
        children: List.generate(_medicaments.length, (index) {
          final med = _medicaments[index];
          return Container(
            margin: const EdgeInsets.only(bottom: AppDimensions.paddingM),
            padding: const EdgeInsets.all(AppDimensions.paddingM),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              border: Border.all(color: AppColors.divider),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'M\u00e9dicament ${index + 1}',
                      style: const TextStyle(
                        fontSize: AppDimensions.fontM,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF7C3AED),
                      ),
                    ),
                    if (index > 0)
                      GestureDetector(
                        onTap: () =>
                            setState(() => _medicaments.removeAt(index)),
                        child: const Icon(
                          Icons.delete_outline,
                          color: AppColors.error,
                          size: AppDimensions.iconM,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: AppDimensions.paddingM),
                _buildRequiredLabel('Nom du m\u00e9dicament'),
                const SizedBox(height: AppDimensions.paddingS),
                TextField(
                  controller: med['nom'] as TextEditingController,
                  decoration: _inputDecoration('Ex: Parac\u00e9tamol', null),
                ),
                const SizedBox(height: AppDimensions.paddingM),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRequiredLabel('Dosage'),
                          const SizedBox(height: AppDimensions.paddingS),
                          TextField(
                            controller: med['dosage'] as TextEditingController,
                            decoration: _inputDecoration('Ex: 500mg', null),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: AppDimensions.paddingM),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRequiredLabel('Fr\u00e9quence'),
                          const SizedBox(height: AppDimensions.paddingS),
                          _buildDropdown(
                            value: med['frequence'] as String?,
                            hint: 'Choisir',
                            items: _frequences,
                            onChanged: (value) =>
                                setState(() => med['frequence'] = value),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.paddingM),
                _buildRequiredLabel('Dur\u00e9e du traitement'),
                const SizedBox(height: AppDimensions.paddingS),
                _buildDropdown(
                  value: med['duree'] as String?,
                  hint: 'Choisir',
                  items: _durees,
                  onChanged: (value) => setState(() => med['duree'] = value),
                ),
                const SizedBox(height: AppDimensions.paddingM),
                const Text(
                  'Instructions particuli\u00e8res',
                  style: TextStyle(
                    fontSize: AppDimensions.fontS,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: AppDimensions.paddingS),
                TextField(
                  controller: med['instructions'] as TextEditingController,
                  maxLines: 2,
                  decoration: _inputDecoration(
                    'Ex: \u00c0 prendre pendant les repas',
                    null,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildNotesSection() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Notes compl\u00e9mentaires',
            style: TextStyle(
              fontSize: AppDimensions.fontM,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingM),
          TextField(
            controller: _notesController,
            maxLines: 4,
            decoration: _inputDecoration(
              'Recommandations, pr\u00e9cautions...',
              null,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: _onCreer,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              ),
              minimumSize: const Size(
                double.infinity,
                AppDimensions.buttonHeight,
              ),
            ),
            icon: const Icon(Icons.save_outlined, color: Colors.white),
            label: const Text(
              'Cr\u00e9er la prescription',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: AppDimensions.fontM,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppDimensions.paddingM),
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.textPrimary,
              side: const BorderSide(color: AppColors.divider),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
              ),
              minimumSize: const Size(
                double.infinity,
                AppDimensions.buttonHeight,
              ),
            ),
            child: const Text(
              'Annuler',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: AppDimensions.fontM,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSection({
    required Color headerColor,
    required IconData headerIcon,
    required Color headerIconColor,
    required String headerTitle,
    required Color headerTitleColor,
    required Widget child,
    Widget? headerAction,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
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
                Icon(
                  headerIcon,
                  color: headerIconColor,
                  size: AppDimensions.iconM,
                ),
                const SizedBox(width: AppDimensions.paddingS),
                Expanded(
                  child: Text(
                    headerTitle,
                    style: TextStyle(
                      fontSize: AppDimensions.fontM,
                      fontWeight: FontWeight.w600,
                      color: headerTitleColor,
                    ),
                  ),
                ),
                // ignore: use_null_aware_elements
                if (headerAction != null) headerAction,
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

  Widget _buildRequiredLabel(String label) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: AppDimensions.fontS,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
          ),
        ),
        const Text(' *', style: TextStyle(color: AppColors.error)),
      ],
    );
  }

  Widget _buildDropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(
            hint,
            style: const TextStyle(
              color: AppColors.textHint,
              fontSize: AppDimensions.fontM,
            ),
          ),
          isExpanded: true,
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData? icon) {
    return InputDecoration(
      hintText: hint,
      prefixIcon: icon != null
          ? Icon(icon, color: AppColors.textSecondary)
          : null,
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
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
    );
  }

  void _onCreer() {
    if (_patientController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Veuillez remplir les champs obligatoires'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Prescription cr\u00e9\u00e9e avec succ\u00e8s !'),
        backgroundColor: AppColors.secondary,
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.pop(context);
  }
}
