import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:restuarant/UI/table_reservation.dart';

import '../../consts/images.dart';

class TabelPicScreen extends StatefulWidget {
  int? item;
  TabelPicScreen({super.key, this.item});

  @override
  State<TabelPicScreen> createState() => _TabelPicScreenState();
}

class _TabelPicScreenState extends State<TabelPicScreen> {
  int count = 0;

  CollectionReference ResData =
      FirebaseFirestore.instance.collection("Restaurant");

  @override
  Widget build(BuildContext context) {
    var hight = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        backgroundColor: const Color.fromARGB(255, 43, 171, 196),
        title: const Text(
          'Table Booking',
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
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: hight * 0.29,
                      crossAxisSpacing: width * 0.021,
                      crossAxisCount: 2,
                    ),
                    itemCount: snapshot
                        .data?.docs[widget.item!]['tablescapacity'].length,
                    itemBuilder: (context, index) {
                      final tableCapacity = snapshot.data?.docs[widget.item!]
                          ['tablescapacity'] as Map<String, dynamic>?;
                      final tableStatus = tableCapacity?[index.toString()]
                          ?['tablestatus'] as Map<String, dynamic>?;

                      final isNotAvailable =
                          tableStatus?['Not Available'] ?? false;

                      return InkWell(
                        onTap: () {
                          if (!isNotAvailable) {
                            setState(() {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text(
                                    'Book Now',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                  content: Container(
                                    height: hight * .23,
                                    width: width * .54,
                                    child: Image.asset(
                                      index == 0
                                          ? tt1
                                          : index == 1
                                              ? t2
                                              : index == 2
                                                  ? t3
                                                  : index == 3
                                                      ? t4
                                                      : index == 4
                                                          ? t5
                                                          : t6,
                                    ),
                                  ),
                                  actions: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => TableRes(
                                                  item: widget.item,
                                                  index: index,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF2babc4),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                            ),
                                            width: width * .18,
                                            padding: const EdgeInsets.all(10),
                                            child: const Text(
                                              "Book",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Color.fromARGB(
                                                  133, 60, 60, 60),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                            ),
                                            padding: const EdgeInsets.all(10),
                                            child: const Text(
                                              "Cancel",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: width * .051, vertical: hight * .01),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: hight * .27,
                                width: width * .4,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 255, 255, 255),
                                      width: 3),
                                  color: isNotAvailable
                                      ? Colors.red
                                      : Colors.green,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: hight * .2,
                                      width: width * .4,
                                      child: Image.asset(
                                        index == 0
                                            ? tt1
                                            : index == 1
                                                ? t2
                                                : index == 2
                                                    ? t3
                                                    : index == 3
                                                        ? t4
                                                        : index == 4
                                                            ? t5
                                                            : t6,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    SizedBox(height: hight * .01),
                                    Text(
                                      isNotAvailable
                                          ? "Not Available"
                                          : "Available",
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: hight * .005),
                                    Text(
                                      "Number Of Guests: ${snapshot.data?.docs[widget.item!]['tables'][index]['capacity']}",
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Table Number: ${index+1}",
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
