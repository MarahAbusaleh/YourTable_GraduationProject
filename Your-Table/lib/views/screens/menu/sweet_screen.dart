import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restuarant/views/screens/menu/basket.dart';
import '../tabel_pic_Screen.dart';

import '../../../consts/List.dart';
import '../../../consts/colors.dart';
import '../../../consts/images.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SweetScreen extends StatelessWidget {
  int? item;
  SweetScreen({super.key, this.item});

  late SnackBar snackBar;
  CollectionReference ResData =
      FirebaseFirestore.instance.collection("Restaurant");
  User? currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    var hight = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: const Color.fromARGB(255, 43, 171, 196),
        title: const Text(
          "Sweets",
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder(
          future: ResData.get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  SizedBox(
                    height: hight * .02,
                  ),
                  Expanded(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisExtent: hight * 0.3,
                            crossAxisSpacing: width * 0.0231,
                            crossAxisCount: 2),
                        itemCount:
                            snapshot.data?.docs[item!]['Menu']["Sweets"].length,
                        itemBuilder: (context, index) {
                          for (int i = 0;
                              i <
                                  snapshot.data?.docs[item!]['Menu']["Sweets"]
                                      .length;) {
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * .01,
                                  vertical: hight * .01),
                              margin: EdgeInsets.symmetric(
                                  vertical: hight * .01,
                                  horizontal: width * .04),
                              height: hight * .2,
                              width: width * .4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      width: 3)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.black,
                                    backgroundImage: AssetImage(item == 0
                                        ? index == 0
                                            ? sw1
                                            : index == 1
                                                ? sw2
                                                : sw3
                                        : index == 0
                                            ? sw4
                                            : index == 1
                                                ? sw5
                                                : sw6),
                                    radius: hight * .07,
                                  ),
                                  Text(
                                    snapshot.data?.docs[item!]['Menu']['Sweets']
                                        [index]['prod'],
                                    style: const TextStyle(
                                        color: shadowAppColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "Price:" +
                                        (snapshot.data?.docs[item!]['Menu']
                                                ['Sweets'][index]['price'])
                                            .toString() +
                                        "JOD",
                                    style: const TextStyle(
                                        color: shadowAppColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        FirebaseFirestore.instance
                                            .collection('User')
                                            .doc(currentUser?.uid)
                                            .update({
                                          'Basket': FieldValue.arrayUnion([
                                            {
                                              'prod': snapshot.data?.docs[item!]
                                                      ['Menu']['Sweets'][index]
                                                  ['prod'],
                                              'price': snapshot
                                                      .data?.docs[item!]['Menu']
                                                  ['Sweets'][index]['price']
                                            }
                                          ])
                                        });
                                        snackBar = SnackBar(
                                          backgroundColor: const Color.fromARGB(
                                              255, 255, 255, 255),
                                          content: const Text(
                                            'Item has added to basket',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          action: SnackBarAction(
                                            textColor: const Color.fromARGB(
                                                255, 43, 171, 196),
                                            label: 'Reserve a Table',
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          TabelPicScreen(
                                                            item: item,
                                                          )));
                                            },
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                        const Color.fromARGB(255, 43, 171, 196),
                                      )),
                                      child: const Icon(
                                        Icons.add,
                                        color: blackAppColor,
                                      ))
                                ],
                              ),
                            );
                          }
                        }),
                  ),
                ],
              );
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}
