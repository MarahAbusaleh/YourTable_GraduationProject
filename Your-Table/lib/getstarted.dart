// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:restuarant/adminloginpage.dart';
import 'package:restuarant/login.dart';
import 'package:restuarant/tabs.dart';
//import './tabs.dart';
import 'main.dart';

class GetStartedPage extends StatefulWidget {
  const GetStartedPage({super.key});

  @override
  State<GetStartedPage> createState() => _GetStartedPageState();
}

class _GetStartedPageState extends State<GetStartedPage> {
  @override
  Widget build(BuildContext context) {
    String? adminId = Provider.of<AdminData>(context).adminId;
    String? userId = Provider.of<UserData>(context).userId;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          //all components are in container
          padding: const EdgeInsets.fromLTRB(20, 100, 20, 20),
          width: double.infinity,
          height: double.infinity,
          color: const Color.fromARGB(255, 43, 171, 196),
          child: Column(
            //column for vertical parts of the page
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  'Welcome To',
                  textAlign: TextAlign.right,
                  style: GoogleFonts.ooohBaby(
                      textStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w900),
                      fontSize: 50),
                )
              ]),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text(
                  'Your Table.',
                  style: GoogleFonts.ooohBaby(
                      textStyle: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w900),
                      fontSize: 50),
                )
              ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //Image in a center widget
                  children: [
                    Image.asset(
                      'assets/images/logo/4.jpeg',
                      width: 220,
                      height: 220,
                    ),
                  ]),
              Container(
                margin: const EdgeInsets.all(30),
                child: const Text(
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  'Book Your Table Easily.',
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                  //container for 'get started' button
                  margin: const EdgeInsets.all(30),
                  child: Center(
                    child: Builder(
                      builder: (context) => SizedBox(
                          height: 50,
                          width: 150,
                          child: MaterialButton(
                              color: Colors.white,
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          //Tabs(userId: userId)),
                                          AdminLogInPage(adminId: adminId)),
                                );
                              },
                              textColor:
                                  const Color.fromARGB(255, 43, 171, 196),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: const Text(
                                'Get Started',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ))),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
