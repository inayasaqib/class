import 'dart:async';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitool/Authentication/login.dart';
import 'package:unitool/Provider/provider.dart';
import 'package:unitool/Views/Picture/picture.dart';
import 'package:unitool/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => UiProvider()..init(),
      child: Consumer<UiProvider>(
        builder: (context, UiProvider notifier, child){
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: notifier.isDark? ThemeMode.dark: ThemeMode.light,
        darkTheme: notifier.isDark? notifier.DarkTheme: notifier.LightTheme,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true
        ),
        home: const Authentication(),
           );
        }
      ),
    );
  }
}