import 'package:flutter/material.dart';
import '../../presentation/auth/login_screen.dart';
import '../../presentation/auth/register_screen.dart';
import '../../presentation/patients/dashboard/patient_dashboard_screen.dart';
import '../../presentation/patients/rdv/rdv_booking_screen.dart';
import '../../presentation/patients/rdv/rdv_list_screen.dart';
import '../../presentation/patients/notifications/notifications_screen.dart';
import '../../presentation/patients/documents/documents_screen.dart';
import '../../presentation/patients/traitements/traitements_screen.dart';
import '../../presentation/patients/consultations/consultations_screen.dart';
import '../../presentation/patients/export/export_screen.dart';
import '../../presentation/medecin/dashboard/medecin_dashboard_screen.dart';
// ignore: unused_import
import '../../presentation/medecin/patients/medecin_patients_screen.dart';
import '../../presentation/auth/splash_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String login = '/login';

  static const String splash = '/';
  static const medecinConsultation = '/medecin/consultation';
  static const prescription = '/medecin/prescription';
  static const String register = '/register';
  static const String patientDashboard = '/patient/dashboard';
  static const String medecinDashboard = '/medecin/dashboard';
  static const String rdvList = '/patient/rdv';
  static const String rdvBooking = '/patient/rdv/booking';
  static const String traitements = '/patient/traitements';
  static const String consultations = '/patient/consultations';
  static const String documents = '/patient/documents';
  static const String notifications = '/patient/notifications';
  static const String export = '/patient/export';
  static const String medecinAgenda = '/medecin/agenda';
  static const String medecinPatients = '/medecin/patients';
  static const String medecinOrdonnances = '/medecin/ordonnances';
  static const String nouvelleConsultation = '/nouvelle-consultation';
  static const String nouvellePrescription = '/nouvelle-prescription';

  static const String medecinNotifications = '/medecin/notifications';

  static Map<String, WidgetBuilder> get routes => {
    login: (_) => const LoginScreen(),
    splash: (_) => const SplashScreen(),
    register: (_) => const RegisterScreen(),
    patientDashboard: (_) => const PatientDashboardScreen(),
    rdvBooking: (_) => const RdvBookingScreen(),
    rdvList: (_) => const RdvListScreen(),
    notifications: (_) => const NotificationsScreen(),
    documents: (_) => const DocumentsScreen(),
    traitements: (_) => const TraitementsScreen(),
    consultations: (_) => const ConsultationsScreen(),
    export: (_) => const ExportScreen(),
    medecinDashboard: (_) => const MedecinDashboardScreen(),
    medecinAgenda: (_) => const SizedBox.shrink(),
    medecinPatients: (_) => const SizedBox.shrink(),
    medecinOrdonnances: (_) => const SizedBox.shrink(),
    medecinNotifications: (_) => const SizedBox.shrink(),
  };
}
