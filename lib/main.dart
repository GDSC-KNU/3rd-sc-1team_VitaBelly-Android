import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'login_page.dart';
import 'main_screen.dart';
import 'pregnancy_info_screen.dart';
import 'gynecology_clinic_location_screen.dart';
import 'pregnancy_selfcare_screen.dart';
import 'housekeeping_services_screen.dart';
import 'pregnancy_test_schedule_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(VitaBellyApp());
}

class VitaBellyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VitaBelly',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Register the routes
      routes: {
        '/': (context) => LoginPage(),
        '/main': (context) => MainScreen(),
        '/pregnancyInfo': (context) => PregnancyInfoScreen(),
        '/gynecologyClinicLocation': (context) =>
            GynecologyClinicLocationScreen(),
        '/selfCare': (context) => PregnancySelfCareScreen(),
        '/houseKeepingServices': (context) => HousekeepingServicesScreen(),
        '/pregnancyTestSchedule': (context) => PregnancyTestScheduleScreen(),
      },
    );
  }
}
