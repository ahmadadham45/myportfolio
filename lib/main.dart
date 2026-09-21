import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Import all the screens here so main.dart knows they exist
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/portfolio_screen.dart';
import 'screens/training_screen.dart';
import 'screens/elearning_screen.dart';
import 'screens/cpd_screen.dart';
import 'screens/forum_screen.dart';
import 'screens/register_screen.dart';// Added RegisterScreen import
// TODO: Import the rest of the screens (profile_screen.dart, cpd_screen.dart, etc.) as we build them

// -----------------------------------------------------------------------------
// APP ENTRY POINT
// This is the very first function that runs when the app is launched.
// -----------------------------------------------------------------------------
void main() async {
  // Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase using the generated options for Android/iOS/Web
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyPortfolioApp());
}

// -----------------------------------------------------------------------------
// ROOT WIDGET
// This configures the overall theme, colors, and navigation rules for the app.
// -----------------------------------------------------------------------------
class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyPortfolio',
      debugShowCheckedModeBanner: false, // Removes the red "DEBUG" banner
      
      // ==========================================
      // GLOBAL THEME CONFIGURATION
      // ==========================================
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFC62828)), // Your Red Theme
        useMaterial3: true,
      ),
      
      // ==========================================
      // ROUTING DIRECTORY (NAVIGATION)
      // ==========================================
      // This tells the app to start at the Login Screen ('/')
      initialRoute: '/',
      
      // This is the map of all possible pages in the app.
      // TODO: Add the routes for '/profile', '/cpd', etc., as we create those files.
      routes: {
        '/': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/portfolio': (context) => const PortfolioScreen(),
        '/training': (context) => const TrainingScreen(),
        '/elearning': (context) => const ElearningScreen(),
        '/cpd': (context) => const CpdScreen(),
        '/forum': (context) => const ForumScreen(),
        '/register': (context) => const RegisterScreen(), // Added RegisterScreen route
      },
    );
  }        
}