import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'add_password.dart';
import 'modify_password.dart';
import 'slider.dart';
import 'user_credential_page.dart';
import 'home.dart';
import 'setting.dart';
import 'profile.dart';
import 'detail.dart';
import 'security_dashboard.dart';
import 'about.dart';
import 'help.dart';

// db pass
// P6tGsi533FUmU0qR

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  String url = dotenv.env['SUPABASE_URL']!;
  String anon = dotenv.env['SUPABASE_ANON_KEY']!;

  // Initialize Supabase
  await Supabase.initialize(
    url: url,
    anonKey: anon,
  );

  runApp(const PassblockApp());
}

class PassblockApp extends StatelessWidget {
  const PassblockApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = Supabase.instance.client.auth.currentUser != null;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: isLoggedIn ? '/home' : '/',
      routes: {
        '/': (context) => FeatureSlider(), // Default screen
        '/home': (context) =>
            HomeScreenManager(), // Home with bottom navigation
        '/profile': (context) => ProfileScreen(),
        '/add-password': (context) => AddPasswordScreen(),
        '/modify-password': (context) => ModifyPasswordScreen(),
        '/search': (context) => SecurityDashboard(),
        '/details': (context) => DetailScreen(),
        '/register': (context) => RegisterLoginTab(),
        '/settings': (context) => SettingScreen(),
        '/about': (context) => AboutScreen(),
        '/help': (context) => HelpScreen(),
      },
    );
  }
}
