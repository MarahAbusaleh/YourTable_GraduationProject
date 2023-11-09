// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import './secure_payment.dart';

class BookingConfirm extends StatefulWidget {
  const BookingConfirm({super.key, required String? userId});

  @override
  State<StatefulWidget> createState() {
    return BookingConfirmState();
  }
}

class BookingConfirmState extends State<BookingConfirm> {
  TextEditingController noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String? userId = Provider.of<UserData>(context).userId;
    GlobalKey<FormState> check = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color(0xFF2babc4),
        title: const Text(
          'Booking Confirmation',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.black,
      body: ListView(
        children: <Widget>[
          //Element #1
          const Padding(
            padding: EdgeInsets.only(top: 30.0, left: 15.0, bottom: 15.0),
            child: Text('Restaurant Name:',
                style: TextStyle(
                    fontSize: 19.0, color: Color.fromARGB(255, 255, 255, 255))),
          ),

          //Element #2
          Container(height: 10.0),

          //Element #3
          const Padding(
            padding: EdgeInsets.only(left: 50.0, bottom: 15.0),
            child: Text('test\ntest',
                style: TextStyle(fontSize: 19.0, color: Colors.white)),
          ),

          //Element #4
          const Padding(
            padding: EdgeInsets.only(top: 20.0, left: 15.0, bottom: 15.0),
            child: Text(
              'Basket:',
              style: TextStyle(
                  fontSize: 19.0, color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
          Container(height: 10.0),

          //Element #5
          const Padding(
            padding: EdgeInsets.only(left: 50.0, bottom: 15.0),
            child: Text('test \ntest \ntest',
                style: TextStyle(fontSize: 19.0, color: Colors.white)),
          ),

          //Element #6
          const Padding(
            padding: EdgeInsets.only(top: 20.0, left: 15.0),
            child: Text(
              'Notes:',
              style: TextStyle(
                  fontSize: 19.0, color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ),

          //Element #7
          Form(
            key: check,
            child: Padding(
              padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
              child: TextFormField(
                controller: noteController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Do you want to tell us something ?!',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),

          //Element #8
          const Padding(
            padding: EdgeInsets.only(top: 20.0, left: 15.0),
            child: Text(
              'Total Price:',
              style: TextStyle(
                  fontSize: 19.0, color: Color.fromARGB(255, 255, 255, 255)),
            ),
          ),
          Container(height: 10.0),

          //Element #9
          const Padding(
            padding: EdgeInsets.only(left: 50.0, bottom: 15.0),
            child: Text('test',
                style: TextStyle(fontSize: 19.0, color: Colors.white)),
          ),

          //Element #10
          Padding(
            padding: const EdgeInsets.only(
                top: 20.0, left: 180.0, right: 30.0, bottom: 50.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  // ignore: deprecated_member_use
                  primary: const Color(0xFF2babc4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  )),
              child: const Text('Go To Payment!',
                  style: TextStyle(fontSize: 17.0, color: Colors.black)),
              onPressed: () {
                storeNote(noteController.text);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SecurePayment(userId: userId)));
              },
            ),
          ),
        ],
      ),
    );
  }
}

void storeNote(String Note) async {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  var userId;
  User? currentUser = FirebaseAuth.instance.currentUser;
  if (currentUser != null) {
    String userId = currentUser.uid;

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Restaurant')
        .where('Table.TableReservation.userid', isEqualTo: userId)
        .get();

    DocumentReference documentRef = querySnapshot.docs[0].reference;
    Map<String, dynamic> note = {'Table.notes': Note};
    documentRef.update(note);
  } else {
    print('No user logged in.');
  }

  // Query the 'Table' collection to check if the entered tableNum exists

  // Create a new document in the "TableReservation" collection
}
