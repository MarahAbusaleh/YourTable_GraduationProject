import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restuarant/views/screens/menu_screen.dart';
import 'package:restuarant/views/screens/tabel_pic_Screen.dart';

import '../../consts/List.dart';
import '../../consts/colors.dart';
import '../../consts/images.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RestaurantName extends StatelessWidget {
  String? name;
  int? i;
  String? userId;
  RestaurantName({super.key, this.i, this.name, this.userId});
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
        title: Text(
          name!,
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 12),
        child:SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 750,
                //width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: category.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        FirebaseFirestore.instance
                            .collection('User')
                            .doc(currentUser?.uid)
                            .update({
                          'Res': i,
                        });
                        print(userId);
                        print('bwccDUzclXWzBKAtgEEA0tnZxDt1');
                        if (category[index]["id"] == 1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MenuScreen(
                                      i: i,
                                    )),
                          );
                        } else if (category[index]["id"] == 2) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TabelPicScreen(
                                      item: i,
                                    )),
                          );
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(width * .02),
                        padding: EdgeInsets.all(width * .031),
                        height: hight * .4,
                        width: width * .4,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              width: 3),
                          color: const Color.fromARGB(255, 0, 0, 0),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              //height: hight * .7,
                              //width: width * .7,
                              /*foregroundDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7)),
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(7)),*/
                              child: Image.asset(
                                category[index]["img"].toString(),
                                fit: BoxFit.fill,
                              ),
                            ),
                            Text(
                              category[index]["title"].toString(),
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
