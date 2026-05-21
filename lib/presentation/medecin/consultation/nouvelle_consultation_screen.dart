import 'package:flutter/material.dart';
import 'package:mon_app/core/constants/app_colors.dart';
import 'package:mon_app/core/constants/app_dimensions.dart';

class NouvelleConsultationScreen extends StatefulWidget {
  const NouvelleConsultationScreen({super.key});

  @override
  State<NouvelleConsultationScreen> createState() =>
      _NouvelleConsultationScreenState();
}

class _NouvelleConsultationScreenState
    extends State<NouvelleConsultationScreen> {
  final _patientController = TextEditingController();
  final _dateController = TextEditingController();
  final _heureController = TextEditingController();
  final _motifController = TextEditingController();
  final _diagnosticController = TextEditingController();
  final _examensController = TextEditingController();
  final _traitementController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _patientController.dispose();
    _dateController.dispose();
    _heureController.dispose();
    _motifController.dispose();
    _diagnosticController.dispose();
    _examensController.dispose();
    _traitementController.dispose();
    _notesController.dispose();
    super.dispose();
  }

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
              _buildForm(context),
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
          'Nouvelle consultation',
          style: TextStyle(
            fontSize: AppDimensions.fontXXL,
            fontWeight: FontWeight.w800,
            color: Color(0xFF14532D),
          ),
        ),
        SizedBox(height: 4),
        Text(
          'Enregistrer les d\u00e9tails de la consultation',
          style: TextStyle(
            fontSize: AppDimensions.fontS,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildForm(BuildContext context) {
    return Column(
      children: [
        // Informations de consultation
        _buildSection(
          headerColor: const Color(0xFFECFDF5),
          headerIcon: Icons.description_outlined,
          headerIconColor: const Color(0xFF16A34A),
          headerTitle: 'Informations de consultation',
          headerTitleColor: const Color(0xFF14532D),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRequiredField(
                'Patient',
                _patientController,
                'Nom du patient',
                Icons.person_outline,
              ),
              const SizedBox(height: AppDimensions.paddingM),
              Row(
                children: [
                  Expanded(child: _buildDateField()),
                  const SizedBox(width: AppDimensions.paddingM),
                  Expanded(child: _buildTimeField()),
                ],
              ),
              const SizedBox(height: AppDimensions.paddingM),
              _buildRequiredLabel('Motif de consultation'),
              const SizedBox(height: AppDimensions.paddingS),
              TextField(
                controller: _motifController,
                decoration: _inputDecoration(
                  'Ex: Contr\u00f4le annuel, douleur abdominale...',
                ),
              ),
              const SizedBox(height: AppDimensions.paddingM),
              const Text(
                'Diagnostic',
                style: TextStyle(
                  fontSize: AppDimensions.fontS,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppDimensions.paddingS),
              TextField(
                controller: _diagnosticController,
                maxLines: 3,
                decoration: _inputDecoration('Description du diagnostic...'),
              ),
              const SizedBox(height: AppDimensions.paddingM),
              const Text(
                'Examens r\u00e9alis\u00e9s',
                style: TextStyle(
                  fontSize: AppDimensions.fontS,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppDimensions.paddingS),
              TextField(
                controller: _examensController,
                maxLines: 3,
                decoration: _inputDecoration(
                  'Examens cliniques, tests effectu\u00e9s...',
                ),
              ),
              const SizedBox(height: AppDimensions.paddingM),
              const Text(
                'Traitement recommand\u00e9',
                style: TextStyle(
                  fontSize: AppDimensions.fontS,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppDimensions.paddingS),
              TextField(
                controller: _traitementController,
                maxLines: 3,
                decoration: _inputDecoration(
                  'M\u00e9dicaments, recommandations...',
                ),
              ),
              const SizedBox(height: AppDimensions.paddingM),
              const Text(
                'Notes compl\u00e9mentaires',
                style: TextStyle(
                  fontSize: AppDimensions.fontS,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppDimensions.paddingS),
              TextField(
                controller: _notesController,
                maxLines: 3,
                decoration: _inputDecoration('Autres observations...'),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppDimensions.paddingL),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: _onEnregistrer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF16A34A),
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
                  'Enregistrer',
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

  Widget _buildRequiredField(
    String label,
    TextEditingController controller,
    String hint,
    IconData icon,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRequiredLabel(label),
        const SizedBox(height: AppDimensions.paddingS),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Icon(icon, color: AppColors.textSecondary),
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
              borderSide: const BorderSide(color: Color(0xFF16A34A), width: 2),
            ),
          ),
        ),
      ],
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

  Widget _buildDateField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRequiredLabel('Date'),
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
                    primary: Color(0xFF16A34A),
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
                  color: Color(0xFF16A34A),
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
    );
  }

  Widget _buildTimeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRequiredLabel('Heure'),
        const SizedBox(height: AppDimensions.paddingS),
        GestureDetector(
          onTap: () async {
            final picked = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              builder: (context, child) => Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: Color(0xFF16A34A),
                  ),
                ),
                child: child!,
              ),
            );
            if (picked != null) {
              _heureController.text =
                  '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
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
                  Icons.access_time,
                  color: Color(0xFF16A34A),
                  size: 18,
                ),
                const SizedBox(width: AppDimensions.paddingS),
                Text(
                  _heureController.text.isEmpty
                      ? '--:--'
                      : _heureController.text,
                  style: TextStyle(
                    fontSize: AppDimensions.fontM,
                    color: _heureController.text.isEmpty
                        ? AppColors.textHint
                        : AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.access_time,
                  color: AppColors.textSecondary,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
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
        borderSide: const BorderSide(color: Color(0xFF16A34A), width: 2),
      ),
    );
  }

  void _onEnregistrer() {
    if (_patientController.text.isEmpty || _motifController.text.isEmpty) {
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
        content: const Text('Consultation enregistr\u00e9e avec succ\u00e8s !'),
        backgroundColor: const Color(0xFF16A34A),
        behavior: SnackBarBehavior.floating,
      ),
    );
    Navigator.pop(context);
  }
}
