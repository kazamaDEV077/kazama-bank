import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:mobile_3_uas_kelompok_10/features/app/splash_screen/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    if (kIsWeb) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyChPguxco_eJZNJ-HK_Z8mU8oaFvIA-eJ4",
          authDomain: "mobile3-uas-kelompok-10",
          projectId: "mobile3-uas-kelompok-10-28f16",
          storageBucket: "mobile-3-uas-kelompok-10.appspot.com",
          messagingSenderId: "180131596009",
          appId: "1:180131596009:android:31041786eafcb218bc1278",
        ),
      );
    } else {
      await Firebase.initializeApp();
    }
    print("Firebase initialized successfully");
  } catch (error) {
    print("Firebase initialization failed: $error");
  }

  // Jalankan aplikasi utama
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kazama Bank',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
