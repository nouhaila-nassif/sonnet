import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Import de Firebase
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sonnet/BrunoMarsPage.DART';
import 'package:sonnet/EdSheeranPage.dart';
import 'package:sonnet/ElgrandeTotoPage.dart';
import 'package:sonnet/MetallicaPage.dart';
import 'package:sonnet/component/toggle_page.dart';
import 'package:sonnet/adelepage.dart';
import 'package:sonnet/taylor_page.dart'; 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(
      apiKey: "AIzaSyAdiT2f_I9Lsb_4X8H2Fw55bR_TZ1iYhzk",  // Your API key
      appId: "1:234182795210:android:6c57e6172cdb42618ab933",  // Your App ID
      messagingSenderId: "234182795210",  // Your project number
      projectId: "music-259cd",  // Your project ID
      storageBucket: "music-259cd.firebasestorage.app",  // Your storage bucket
      androidClientId: "com.example.sonnet",  // Your package name
    ),); // Initialisation de Firebase
  await dotenv.load();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const TogglePage(),
      routes: {
        '/adele': (context) => AdelePage(),
        '/taylor': (context) => TaylorPage(),
       '/bruno': (context) => BrunoMarsPage(),
        '/eagles': (context) => ElgrandeTotoPage(),
        '/EdSheeranPage': (context) => EdSheeranPage(),
        '/metallica': (context) => MetallicaPage(),

      },
    );
  }
}
