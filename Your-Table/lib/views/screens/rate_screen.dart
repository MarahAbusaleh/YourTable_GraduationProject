// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restuarant/consts/colors.dart';
import 'package:restuarant/views/screens/home_screen.dart';

import '../../main.dart';
import '../../widgets/custom_rate.dart';

class RateScreen extends StatelessWidget {
  String? name;
  RateScreen({super.key, required String? userId, this.name});

  @override
  Widget build(BuildContext context) {
    String? userId = Provider.of<UserData>(context).userId;
    var hight = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        backgroundColor: const Color.fromARGB(255, 43, 171, 196),
        title: const Text(
          'Rating Page',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: hight * .45,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 120.0),
                    child: Center(
                      child: Text(
                        "See You Soon !",
                        style: TextStyle(
                            color: Color.fromARGB(255, 43, 171, 196),
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: hight * .07,
                  ),
                  Text(
                    name!,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: hight * .04,
                  ),
                  const CustomRate()
                ],
              ),
            ),
            SizedBox(
              height: hight * .04,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * .1,
              width: MediaQuery.of(context).size.width * .88,
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 1,
                        color: Colors.white,
                        style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: whiteAppColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  hintText: "Add Comment (optional)",
                  hintStyle:
                      const TextStyle(color: whiteAppColor, fontSize: 13),
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            SizedBox(
              height: hight * .05,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * .06),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(135, 187, 187, 187),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    child: const Text('Cancel',
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Color.fromARGB(255, 255, 255, 255))),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomeScreen(userId: userId)));
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xFF2babc4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    child: const Text('Done',
                        style: TextStyle(fontSize: 17.0, color: Colors.black)),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  HomeScreen(userId: userId)));
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
