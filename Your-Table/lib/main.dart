// ignore_for_file: use_key_in_widget_constructors

import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
//import 'package:restuarant/UI/table_reservation.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
//import 'package:restuarant/UI/table_reservation.dart';
import 'package:restuarant/getstarted.dart';
//import 'package:restuarant/views/screens/home_screen.dart';
//import 'package:restuarant/getstarted.dart';
//import 'package:restuarant/views/screens/home_screen.dart';

class UserData extends ChangeNotifier {
  String? userId;

  void setUserId(String id) {
    userId = id;
    notifyListeners();
  }
}

class AdminData extends ChangeNotifier {
  String? adminId;

  void setAdminId(String id) {
    adminId = id;
    notifyListeners();
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyBnsji_mvz6Gs1OeTgUXuwyoXpciILsxXw',
          appId: '1:2449559643:android:0ccbe9343e084475e62f7e',
          messagingSenderId: '2449559643',
          projectId: 'your-table-df574'));
  runApp(
    ChangeNotifierProvider(
      create: (_) => UserData(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(seconds: 2),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MultiProvider(
            providers: [
              ChangeNotifierProvider<UserData>(create: (_) => UserData()),
              ChangeNotifierProvider<AdminData>(create: (_) => AdminData()),
            ],
            child: GetStartedPage(),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 0, 0, 0),
      child: Image.asset(
        'assets/images/logo/splash.png', // Replace with your image file path
        fit: BoxFit.contain,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }
}
