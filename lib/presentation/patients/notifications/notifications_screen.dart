import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_dimensions.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _nonLues = 3;

  final List<Map<String, dynamic>> _medicaments = [
    {
      'nom': 'Parac\u00e9tamol 500mg',
      'heure': '08:00',
      'prioritaire': true,
      'pris': false,
    },
    {
      'nom': 'Vitamine D 1000 UI',
      'heure': '12:00',
      'prioritaire': false,
      'pris': true,
    },
    {
      'nom': 'Parac\u00e9tamol 500mg',
      'heure': '20:00',
      'prioritaire': true,
      'pris': false,
    },
  ];

  final List<Map<String, dynamic>> _rdvNotifs = [
    {
      'medecin': 'Dr. Martin',
      'date': '05 F\u00e9v 2026 \u00e0 14h30',
      'delai': 'Dans 6 jours',
      'lu': false,
    },
    {
      'medecin': 'Dr. Legrand',
      'date': '12 F\u00e9v 2026 \u00e0 10h00',
      'delai': 'Dans 13 jours',
      'lu': false,
    },
  ];

  final List<Map<String, dynamic>> _systemeNotifs = [
    {
      'titre': 'Nouveau document disponible',
      'message': 'R\u00e9sultats d\'analyses sanguines',
      'date': "Aujourd'hui",
      'lu': false,
    },
    {
      'titre': 'Rappel vaccination',
      'message': 'Votre rappel de vaccination COVID-19 est d\u00fb',
      'date': 'Hier',
      'lu': false,
    },
    {
      'titre': 'Confirmation de rendez-vous',
      'message': 'Votre rendez-vous avec Dr. Martin est confirm\u00e9',
      'date': 'Il y a 2 jours',
      'lu': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
          child: const Row(
            children: [
              SizedBox(width: 8),
              Icon(
                Icons.arrow_back_ios,
                size: AppDimensions.iconS,
                color: AppColors.textPrimary,
              ),
            ],
          ),
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingM,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Notifications',
                      style: TextStyle(
                        fontSize: AppDimensions.fontXXL,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF6D28D9),
                      ),
                    ),
                    if (_nonLues > 0)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingS,
                          vertical: AppDimensions.paddingXS,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.error,
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusFull,
                          ),
                        ),
                        child: Text(
                          '$_nonLues non lus',
                          style: const TextStyle(
                            fontSize: AppDimensions.fontXS,
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                  ],
                ),
                const Text(
                  'Rappels et alertes',
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
                      Tab(text: 'M\u00e9dicaments'),
                      Tab(text: 'Rendez-vous'),
                      Tab(text: 'Syst\u00e8me'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildMedicamentsTab(),
                _buildRdvTab(),
                _buildSystemeTab(),
              ],
            ),
          ),
          _buildBottomActions(),
        ],
      ),
    );
  }

  Widget _buildMedicamentsTab() {
    final nonPris = _medicaments.where((m) => !(m['pris'] as bool)).length;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      child: Column(
        children: [
          if (nonPris > 0)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppDimensions.paddingM),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: AppColors.primary,
                    size: AppDimensions.iconS,
                  ),
                  const SizedBox(width: AppDimensions.paddingS),
                  Text(
                    '$nonPris m\u00e9dicament${nonPris > 1 ? 's' : ''} \u00e0 prendre aujourd\'hui',
                    style: const TextStyle(
                      fontSize: AppDimensions.fontS,
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: AppDimensions.paddingM),
          ..._medicaments.asMap().entries.map((entry) {
            final index = entry.key;
            final med = entry.value;
            final pris = med['pris'] as bool;
            final prioritaire = med['prioritaire'] as bool;
            return Container(
              margin: const EdgeInsets.only(bottom: AppDimensions.paddingS),
              padding: const EdgeInsets.all(AppDimensions.paddingM),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppDimensions.radiusL),
                border: !pris
                    ? Border.all(color: AppColors.error.withValues(alpha: 0.3))
                    : null,
                boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 4)],
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: pris
                          ? AppColors.secondaryLight
                          : const Color(0xFFFEF2F2),
                      borderRadius: BorderRadius.circular(
                        AppDimensions.radiusM,
                      ),
                    ),
                    child: Icon(
                      Icons.medication_outlined,
                      color: pris ? AppColors.secondary : AppColors.error,
                      size: AppDimensions.iconM,
                    ),
                  ),
                  const SizedBox(width: AppDimensions.paddingM),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          med['nom'] as String,
                          style: const TextStyle(
                            fontSize: AppDimensions.fontM,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          'Heure: ${med['heure']}',
                          style: const TextStyle(
                            fontSize: AppDimensions.fontS,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        if (prioritaire)
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppDimensions.paddingS,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.error,
                              borderRadius: BorderRadius.circular(
                                AppDimensions.radiusFull,
                              ),
                            ),
                            child: const Text(
                              'Prioritaire',
                              style: TextStyle(
                                fontSize: AppDimensions.fontXS,
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (!pris) ...[
                    GestureDetector(
                      onTap: () => setState(() {
                        _medicaments[index]['pris'] = true;
                        if (_nonLues > 0) _nonLues--;
                      }),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusS,
                          ),
                        ),
                        child: const Icon(
                          Icons.check,
                          color: AppColors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppDimensions.paddingS),
                    GestureDetector(
                      onTap: () => setState(() => _medicaments.removeAt(index)),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.error,
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusS,
                          ),
                        ),
                        child: const Icon(
                          Icons.close,
                          color: AppColors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ] else
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.secondaryLight,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: AppColors.secondary,
                        size: 20,
                      ),
                    ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildRdvTab() {
    if (_rdvNotifs.isEmpty) {
      return const Center(
        child: Text(
          'Aucune notification de rendez-vous',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      itemCount: _rdvNotifs.length,
      itemBuilder: (context, index) {
        final rdv = _rdvNotifs[index];
        return Container(
          margin: const EdgeInsets.only(bottom: AppDimensions.paddingS),
          padding: const EdgeInsets.all(AppDimensions.paddingM),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppDimensions.radiusL),
            border: const Border(
              left: BorderSide(color: AppColors.primary, width: 4),
            ),
            boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 4)],
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                ),
                child: const Icon(
                  Icons.calendar_today,
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
                      rdv['medecin'] as String,
                      style: const TextStyle(
                        fontSize: AppDimensions.fontM,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      rdv['date'] as String,
                      style: const TextStyle(
                        fontSize: AppDimensions.fontS,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingS,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusFull,
                        ),
                      ),
                      child: Text(
                        rdv['delai'] as String,
                        style: const TextStyle(
                          fontSize: AppDimensions.fontXS,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.surface,
                  foregroundColor: AppColors.textPrimary,
                  elevation: 0,
                  side: const BorderSide(color: AppColors.divider),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingM,
                    vertical: AppDimensions.paddingXS,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                  ),
                ),
                child: const Text(
                  'D\u00e9tails',
                  style: TextStyle(fontSize: AppDimensions.fontS),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSystemeTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      itemCount: _systemeNotifs.length,
      itemBuilder: (context, index) {
        final notif = _systemeNotifs[index];
        final bool lu = notif['lu'] as bool;
        return Container(
          margin: const EdgeInsets.only(bottom: AppDimensions.paddingS),
          padding: const EdgeInsets.all(AppDimensions.paddingM),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppDimensions.radiusL),
            border: lu
                ? null
                : const Border(
                    left: BorderSide(color: Color(0xFF6D28D9), width: 4),
                  ),
            boxShadow: [BoxShadow(color: AppColors.shadow, blurRadius: 4)],
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F3FF),
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                ),
                child: const Icon(
                  Icons.notifications_outlined,
                  color: Color(0xFF6D28D9),
                  size: AppDimensions.iconM,
                ),
              ),
              const SizedBox(width: AppDimensions.paddingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            notif['titre'] as String,
                            style: TextStyle(
                              fontSize: AppDimensions.fontM,
                              fontWeight: lu
                                  ? FontWeight.w500
                                  : FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        if (!lu)
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: Color(0xFF6D28D9),
                              shape: BoxShape.circle,
                            ),
                          ),
                      ],
                    ),
                    Text(
                      notif['message'] as String,
                      style: const TextStyle(
                        fontSize: AppDimensions.fontS,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      notif['date'] as String,
                      style: const TextStyle(
                        fontSize: AppDimensions.fontXS,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      color: const Color(0xFFEFF6FF),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => setState(() {
                // ignore: curly_braces_in_flow_control_structures
                for (var m in _medicaments) m['pris'] = true;
                // ignore: curly_braces_in_flow_control_structures
                for (var r in _rdvNotifs) r['lu'] = true;
                // ignore: curly_braces_in_flow_control_structures
                for (var s in _systemeNotifs) s['lu'] = true;
                _nonLues = 0;
              }),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.textPrimary,
                side: const BorderSide(color: AppColors.divider),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                ),
              ),
              child: const Text(
                'Tout marquer comme lu',
                style: TextStyle(fontSize: AppDimensions.fontS),
              ),
            ),
          ),
          const SizedBox(width: AppDimensions.paddingS),
          Expanded(
            child: OutlinedButton(
              onPressed: () => setState(() {
                _medicaments.clear();
                _rdvNotifs.clear();
                _systemeNotifs.clear();
                _nonLues = 0;
              }),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.error,
                side: const BorderSide(color: AppColors.error),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                ),
              ),
              child: const Text(
                'Tout effacer',
                style: TextStyle(fontSize: AppDimensions.fontS),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
