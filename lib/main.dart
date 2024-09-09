import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'core/styles/theme_style.dart';
import 'features/add_new_card_page/ui/add_card_page.dart';
import 'features/all_cards_screen/ui/all_cards_screen.dart';
import 'features/navigation_screen/ui/navigation.dart';
import 'features/onboardingScreen/ui/onboarding_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeStyle.lightThemeData,
      home: AddCardScreen(),
    );
  }
}
