import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => _DocumentsScreenState();
}

class _DocumentsScreenState extends State<DocumentsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String _selectedFilter = 'Tous';

  final List<Map<String, dynamic>> _documents = [
    {
      'titre': 'R\u00e9sultats anal...',
      'medecin': 'Dr. Martin',
      'date': '15 F\u00e9v 2026',
      'type': 'Analyses',
      'taille': '245 KB',
      'icon': Icons.show_chart,
      'couleur': const Color(0xFF3B82F6),
      'couleurBg': const Color(0xFFEFF6FF),
    },
    {
      'titre': 'Radiographie ...',
      'medecin': 'Dr. Legrand',
      'date': '10 F\u00e9v 2026',
      'type': 'Imagerie',
      'taille': '1.2 MB',
      'icon': Icons.image_outlined,
      'couleur': const Color(0xFF8B5CF6),
      'couleurBg': const Color(0xFFF5F3FF),
    },
    {
      'titre': 'Ordonnance p...',
      'medecin': 'Dr. Martin',
      'date': '05 F\u00e9v 2026',
      'type': 'Ordonnances',
      'taille': '128 KB',
      'icon': Icons.medication_outlined,
      'couleur': const Color(0xFF10B981),
      'couleurBg': const Color(0xFFECFDF5),
    },
    {
      'titre': 'Compte-rendu...',
      'medecin': 'Dr. Martin',
      'date': '15 Jan 2026',
      'type': 'Comptes-rendus',
      'taille': '156 KB',
      'icon': Icons.description_outlined,
      'couleur': const Color(0xFFF97316),
      'couleurBg': const Color(0xFFFFF7ED),
    },
    {
      'titre': 'Certificat m\u00e9d...',
      'medecin': 'Dr. Dubois',
      'date': '10 Jan 2026',
      'type': 'Certificats',
      'taille': '98 KB',
      'icon': Icons.article_outlined,
      'couleur': const Color(0xFF6B7280),
      'couleurBg': AppColors.background,
    },
    {
      'titre': 'IRM c\u00e9r\u00e9brale',
      'medecin': 'Dr. Bernard',
      'date': '20 D\u00e9c 2025',
      'type': 'Imagerie',
      'taille': '3.5 MB',
      'icon': Icons.image_outlined,
      'couleur': const Color(0xFF8B5CF6),
      'couleurBg': const Color(0xFFF5F3FF),
    },
    {
      'titre': '\u00c9lectrocardiog...',
      'medecin': 'Dr. Martin',
      'date': '15 D\u00e9c 2025',
      'type': 'Analyses',
      'taille': '320 KB',
      'icon': Icons.monitor_heart_outlined,
      'couleur': const Color(0xFFEF4444),
      'couleurBg': const Color(0xFFFEF2F2),
    },
    {
      'titre': 'Ordonnance vi...',
      'medecin': 'Dr. Martin',
      'date': '03 D\u00e9c 2025',
      'type': 'Ordonnances',
      'taille': '102 KB',
      'icon': Icons.medication_outlined,
      'couleur': const Color(0xFF10B981),
      'couleurBg': const Color(0xFFECFDF5),
    },
  ];

  final List<String> _filters = [
    'Tous',
    'Analyses',
    'Imagerie',
    'Ordonnances',
    'Comptes-rendus',
    'Certificats',
  ];

  List<Map<String, dynamic>> get _documentsFiltres {
    return _documents.where((doc) {
      final matchFilter =
          _selectedFilter == 'Tous' || doc['type'] == _selectedFilter;
      final matchSearch =
          _searchQuery.isEmpty ||
          doc['titre'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          doc['medecin'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );
      return matchFilter && matchSearch;
    }).toList();
  }

  Map<String, int> get _counts {
    final counts = <String, int>{'Tous': _documents.length};
    for (final f in _filters.skip(1)) {
      counts[f] = _documents.where((d) => d['type'] == f).length;
    }
    return counts;
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
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppDimensions.paddingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSearchBar(),
                    const SizedBox(height: AppDimensions.paddingM),
                    _buildFilterSection(),
                    const SizedBox(height: AppDimensions.paddingM),
                    _buildDocumentsList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: const BoxDecoration(color: AppColors.primary),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.white,
                  size: AppDimensions.iconS,
                ),
              ),
              const SizedBox(width: AppDimensions.paddingS),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mes Documents',
                      style: TextStyle(
                        fontSize: AppDimensions.fontL,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                    Text(
                      'Carnet m\u00e9dical \u00e9lectronique',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: AppDimensions.fontS,
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
              _buildStatHeader('8', 'Documents'),
              _buildStatHeader('2', 'Analyses'),
              _buildStatHeader('2', 'Imagerie'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatHeader(String value, String label) {
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

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      onChanged: (value) => setState(() => _searchQuery = value),
      decoration: InputDecoration(
        hintText: 'Rechercher un document...',
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
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusM),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.filter_list,
                color: AppColors.textSecondary,
                size: AppDimensions.iconS,
              ),
              SizedBox(width: 4),
              Text(
                'Filtrer par type',
                style: TextStyle(
                  fontSize: AppDimensions.fontM,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.paddingM),
          Wrap(
            spacing: AppDimensions.paddingS,
            runSpacing: AppDimensions.paddingS,
            children: _filters.map((filter) {
              final isSelected = _selectedFilter == filter;
              final count = _counts[filter] ?? 0;
              return GestureDetector(
                onTap: () => setState(() => _selectedFilter = filter),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingM,
                    vertical: AppDimensions.paddingXS,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.background,
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusFull,
                    ),
                  ),
                  child: Text(
                    count > 0 ? '$filter $count' : filter,
                    style: TextStyle(
                      fontSize: AppDimensions.fontS,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? AppColors.white
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentsList() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${_documentsFiltres.length} documents',
            style: const TextStyle(
              fontSize: AppDimensions.fontM,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimensions.paddingM),
          ..._documentsFiltres.map((doc) => _buildDocumentItem(doc)),
        ],
      ),
    );
  }

  Widget _buildDocumentItem(Map<String, dynamic> doc) {
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
              color: doc['couleurBg'] as Color,
              borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            ),
            child: Icon(
              doc['icon'] as IconData,
              color: doc['couleur'] as Color,
              size: AppDimensions.iconM,
            ),
          ),
          const SizedBox(width: AppDimensions.paddingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doc['titre'] as String,
                  style: const TextStyle(
                    fontSize: AppDimensions.fontM,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  '${doc['medecin']} \u2022 ${doc['date']}',
                  style: const TextStyle(
                    fontSize: AppDimensions.fontXS,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    _buildTypeBadge(doc['type'] as String),
                    const SizedBox(width: AppDimensions.paddingS),
                    Text(
                      doc['taille'] as String,
                      style: const TextStyle(
                        fontSize: AppDimensions.fontXS,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.visibility_outlined,
              color: AppColors.textSecondary,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.download_outlined,
              color: AppColors.textSecondary,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildTypeBadge(String type) {
    Color color;
    switch (type) {
      case 'Analyses':
        color = const Color(0xFF3B82F6);
        break;
      case 'Imagerie':
        color = const Color(0xFF8B5CF6);
        break;
      case 'Ordonnances':
        color = const Color(0xFF10B981);
        break;
      case 'Comptes-rendus':
        color = const Color(0xFFF97316);
        break;
      case 'Certificats':
        color = const Color(0xFF6B7280);
        break;
      default:
        color = AppColors.primary;
    }
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingS,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
      ),
      child: Text(
        type,
        style: const TextStyle(
          fontSize: AppDimensions.fontXS,
          color: AppColors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
