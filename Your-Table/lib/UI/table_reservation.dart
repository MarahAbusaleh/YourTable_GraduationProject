// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import './booking_confirm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:restuarant/UI/secure_payment.dart';
import '../confirmed.dart';
import '../main.dart';

class TableRes extends StatefulWidget {
  final int index;
  int? item;

  TableRes({Key? key, required this.item, required this.index})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TableResState();
  }
}

var checker;
int? selectedTableNum;

class TableResState extends State<TableRes> {
  TimeOfDay time = const TimeOfDay(hour: 00, minute: 00);

  DateTime getNow() {
    DateTime now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
  }

  TextEditingController guestsController = TextEditingController();
  TextEditingController childrennumController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  @override
  void dispose() {
    guestsController.dispose();
    childrennumController.dispose();
    super.dispose();
  }

  String hintText = '';
  late int TableNum;
  late int item;
  late String docindex;

  @override
  void initState() {
    super.initState();
    hintText = '${widget.index + 1}';
    TableNum = widget.index;
    item = widget.item!;
    if (item == 0)
      docindex = 'EbspzWo6KoFSgFIAY32l';
    else
      docindex = 'piCrbBDyluejavahRiLu';
  }

  @override
  Widget build(BuildContext context) {
    String? userId = Provider.of<UserData>(context).userId;
    GlobalKey<FormState> check = GlobalKey<FormState>();

    void Save() {
      var checkfeild = check.currentState;
      if (checkfeild!.validate() && getNow().hour > 0) {
        checkfeild.save();
        storeReservation(
            TableNum,
            guestsController.text,
            childrennumController.text,
            getNow(),
            noteController.text,
            context,
            docindex);
      }
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color(0xFF2babc4),
        title: const Text(
          'Table Reservation',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      backgroundColor: Colors.black,
      body: Form(
        key: check,
        child: ListView(
          children: <Widget>[
            //Element #1
            const Padding(
              padding: EdgeInsets.only(top: 30.0, left: 15.0, bottom: 15.0),
              child: Text(
                'Arrival Time:',
                style: TextStyle(
                    fontSize: 19.0, color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),

            //Element #2
            Center(
              child: Text(
                '${time.hour}:${time.minute}',
                style: const TextStyle(fontSize: 19.0, color: Colors.white),
              ),
            ),

            Container(height: 10.0),

            //Element #3
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  // ignore: deprecated_member_use
                  primary: const Color(0xFF2babc4),
                ),
                child: const Text(
                  'Select a time',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () async {
                  TimeOfDay? newTime = await showTimePicker(
                    context: context,
                    initialTime: time,
                  );
                  if (newTime == null) return;
                  setState(() {
                    time = newTime;
                  });
                },
              ),
            ),

            //Element #6
            const Padding(
              padding: EdgeInsets.only(top: 20.0, left: 15.0),
              child: Text(
                'Guests:',
                style: TextStyle(
                    fontSize: 19.0, color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),

            //Element #7
            Padding(
              padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
              child: TextFormField(
                validator: (text) {
                  if (text!.isEmpty) {
                    return "Please enter guests number";
                  } else {
                    return null;
                  }
                },
                controller: guestsController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Enter number of guests...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            //Element #8
            const Padding(
              padding: EdgeInsets.only(top: 20.0, left: 15.0),
              child: Text(
                'Number of children chairs:',
                style: TextStyle(
                    fontSize: 19.0, color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),

            //Element #9
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
              child: TextField(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Enter number of chairs (optional)...',
                  border: OutlineInputBorder(),
                ),
                controller: childrennumController,
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(top: 20.0, left: 15.0),
              child: Text(
                'Notes:',
                style: TextStyle(
                    fontSize: 19.0, color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),

            //Element #7
            Padding(
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

            const Padding(
              padding: EdgeInsets.only(top: 20.0, left: 15.0),
              child: Text(
                'Table Number:',
                style: TextStyle(
                    fontSize: 19.0, color: Color.fromARGB(255, 255, 255, 255)),
              ),
            ),

            //Element #9
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, left: 15.0, right: 15.0),
              child: TextField(
                decoration: InputDecoration(
                  enabled: false,
                  filled: true,
                  hintText: hintText,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            //Element #10
            Padding(
              padding: const EdgeInsets.only(
                  top: 30.0, left: 210.0, right: 30.0, bottom: 50.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    // ignore: deprecated_member_use
                    primary: const Color(0xFF2babc4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
                child: const Text('Go to payment!',
                    style: TextStyle(fontSize: 19.0, color: Colors.black)),
                onPressed: () {
                  Save();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void storeReservation(int TableNum, String GuestsNum, String? ChildrenNum,
    DateTime date, String Notes, BuildContext context, String docindex) async {
  bool isValid = false;
  User? currentUser = FirebaseAuth.instance.currentUser;

  if (currentUser != null) {
    String userId = currentUser.uid;

    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('Restaurant')
        .doc(docindex)
        .get();

    if (documentSnapshot.exists) {
      Map<String, dynamic>? data =
          documentSnapshot.data() as Map<String, dynamic>?;

      Map<String, dynamic>? tableCapacity =
          data?['tablescapacity'] as Map<String, dynamic>?;

      Map<String, dynamic>? tableStatus =
          tableCapacity?[(TableNum).toString()] as Map<String, dynamic>?;

      bool notAvailable = tableStatus?['tablestatus']['Not Available'] ?? false;

      if (notAvailable) {
        // The table is already reserved. Please choose another table.
      } else {
        // Table is available, update fields
        DocumentReference documentRef = documentSnapshot.reference;

        Map<String, dynamic> tableStatusData = {
          'tablescapacity.${(TableNum)}.tablestatus.Not Available': true,
        };
        documentRef.update(tableStatusData);

        DateTime now = DateTime.now();
        DateTime combinedDate =
            DateTime(now.year, now.month, now.day, date.hour, date.minute);
        String formattedDate =
            DateFormat('yyyy-MM-dd HH:mm').format(combinedDate);

        Map<String, dynamic> TableRes = {
          'Table.TableReservation': {
            'userid': userId,
            'reservationid': TableNum,
            'reservationdate': formattedDate,
            'numberofchildrens': ChildrenNum,
            'numberofguests': GuestsNum,
            'notes': Notes,
          },
        };
        documentRef.update(TableRes);

        // Reservation successful, navigate to the desired page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SecurePayment(userId: userId),
          ),
        );
      }
    } else {
      print('Table document does not exist.');
    }
  } else {
    print('No user logged in.');
  }
}
