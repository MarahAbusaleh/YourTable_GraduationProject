// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restuarant/views/screens/confirmpage.dart';

import 'main.dart';

class ConfirmedPage extends StatefulWidget {
  const ConfirmedPage({super.key, required String? userId});

  @override
  State<ConfirmedPage> createState() => _ConfirmedPageState();
}

class _ConfirmedPageState extends State<ConfirmedPage> {
  @override
  Widget build(BuildContext context) {
    String? userId = Provider.of<UserData>(context).userId;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            padding: const EdgeInsets.fromLTRB(20, 150, 20, 0),
            width: double.infinity,
            height: double.infinity,
            color: const Color.fromARGB(255, 0, 0, 0),
            child: Center(
              child: Column(
                children: [
                  const Icon(
                    size: 170,
                    Icons.check_circle,
                    color: Color.fromARGB(255, 43, 171, 196),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 30, bottom: 30),
                    child: const Text(
                      'Confirmed',
                      style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontSize: 30,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                  Container(
                    width: 300,
                    height: 150,
                    padding: const EdgeInsets.only(bottom: 30),
                    child: const Text(
                      'We are pleased to inform you that your reservation request has been received and confirmed.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 18,
                      ),
                    ),
                  ),
                  SizedBox(
                      height: 50,
                      width: 300,
                      child: MaterialButton(
                          color: const Color.fromARGB(255, 43, 171, 196),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ConfirmPage()),
                            );
                          },
                          textColor: const Color.fromARGB(255, 0, 0, 0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: const Text(
                            'View Reservation Information',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ))),
                ],
              ),
            ),
          ),
        ));
  }
}
