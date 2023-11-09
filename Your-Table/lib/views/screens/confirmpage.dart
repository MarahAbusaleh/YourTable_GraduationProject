// ignore_for_file: deprecated_member_use, avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restuarant/consts/images.dart';
import 'package:restuarant/views/screens/rate_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main.dart';
import '../../consts/List.dart';

/*void main() {
  runApp(MaterialApp(title: "sd", home: MyApp()));
}*/

class ConfirmPage extends StatefulWidget {
  const ConfirmPage({super.key, String? userId});

  @override
  State<ConfirmPage> createState() => _ConfirmPageState();
}

class _ConfirmPageState extends State<ConfirmPage> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference ResData = FirebaseFirestore.instance.collection(
    "Restaurant",
  );

  @override
  Widget build(BuildContext context) {
    DocumentReference snp =
        FirebaseFirestore.instance.collection('User').doc(currentUser?.uid);
    String? userId = Provider.of<UserData>(context).userId;
    num price = 0;
    String ResName;
    return Scaffold(
        backgroundColor: const Color(0xFF010407),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(
            color: Color.fromARGB(255, 43, 171, 196),
          ),
          backgroundColor: const Color.fromARGB(255, 43, 171, 196),
          title: const Text(
            'Your Reservation',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: FutureBuilder(
          future: snp.get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              int arrlen = snapshot.data?['Basket'].length;
              for (int i = 0; i < arrlen; i++) {
                price += snapshot.data?['Basket'][i]['price'];
              }
              int currest = snapshot.data?['Res'];
              return FutureBuilder(
                  future: ResData.get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      String Notes = snapshot.data?.docs[currest]['Table']
                          ['TableReservation']['notes'];
                      ResName = snapshot.data?.docs[currest]['restaurantname'];

                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 220,
                                  child: Image.asset(
                                    currest == 0 ? r1 : r7,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    snapshot.data?.docs[currest]
                                        ['restaurantname'],
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 43, 171, 196),
                                        fontSize: 30),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(children: [
                                        const Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Text(
                                            "Number of Guests",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontSize: 25),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          snapshot.data?.docs[currest]['Table']
                                                  ['TableReservation']
                                              ['numberofguests'],
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontSize: 20),
                                        ),
                                      ]),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Column(children: [
                                        const Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(20, 4, 0, 4),
                                          child: Text(
                                            "Arriving Time" ,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 25),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          snapshot.data?.docs[currest]['Table']
                                                  ['TableReservation']
                                              ['reservationdate'],
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontSize: 20),
                                        ),
                                      ]),
                                    ),
                                  ]),
                                ),
                                const Text(
                                  "   Basket              Price",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontSize: 25),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                FutureBuilder(
                                  future: snp.get(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Padding(
                                          padding: const EdgeInsets.only(
                                              right: 15.0, left: 15),
                                          child: SizedBox(
                                            height: 80,
                                            width: double.infinity,
                                            child: ListView.builder(
                                                itemCount: snapshot
                                                    .data?['Basket'].length,
                                                itemBuilder: (context, index) {
                                                  print(snapshot.data?['Basket']
                                                      [index]['prod']);
                                                  String strSize =
                                                      snapshot.data?['Basket']
                                                          [index]['prod'];

                                                  return Row(children: [
                                                    Container(
                                                        width: 210,
                                                        child: Text(
                                                          "  " +
                                                              snapshot.data?[
                                                                      'Basket'][
                                                                  index]['prod'],
                                                          style:
                                                              const TextStyle(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          255,
                                                                          255,
                                                                          255),
                                                                  fontSize: 20),
                                                        )),
                                                    Container(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .topEnd,
                                                      child: Text(
                                                        "${snapshot.data!['Basket'][index]['price']}JOD",
                                                        style: const TextStyle(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    255,
                                                                    255,
                                                                    255),
                                                            fontSize: 18),
                                                      ),
                                                    ),
                                                  ]);
                                                }),
                                          ));
                                    }
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      28.0, 26, 0, 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Notes",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontSize: 25),
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(Notes,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255),
                                              fontSize: 25)),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      28.0, 13, 0, 15),
                                  child: Row(children: [
                                    const Text(
                                      "Total Price: ",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 25),
                                    ),
                                    Text("${price}JOD",
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            fontSize: 20)),
                                  ]),
                                ),
                                Center(
                                  child: SizedBox(
                                    width: 150,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: const Color(0xFF2babc4),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          )),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => RateScreen(
                                                    userId: "s",
                                                    name: ResName,
                                                  )),
                                        );
                                      },
                                      child: const Text(
                                        'Rate Now!',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                        ),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  });
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }
}
