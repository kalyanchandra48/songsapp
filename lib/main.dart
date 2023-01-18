import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:songs_app/pages/favourites_page.dart';
import 'package:songs_app/pages/navigation_bar_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const SongsApp());
}

class SongsApp extends StatelessWidget {
  const SongsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        'favourites': (context) => FavouritesPage(),
      },
      debugShowCheckedModeBanner: false,
      home: const NavigationBarPage(),
    );
  }
}
