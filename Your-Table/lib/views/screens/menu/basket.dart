import 'package:flutter/material.dart';
import 'package:restuarant/consts/List.dart';
import 'package:restuarant/consts/colors.dart';

import '../tabel_pic_Screen.dart';

class Basket extends StatelessWidget {
  const Basket({super.key});

  @override
  Widget build(BuildContext context) {
    var hight = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 43, 171, 196),
          iconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            "Basket",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TabelPicScreen()));
              },
              icon: const Icon(
                Icons.table_bar,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * .05, vertical: hight * .01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: hight * .8167,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: menu.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.symmetric(vertical: hight * .01),
                        height: hight * .143,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: blackAppColor,
                            borderRadius: BorderRadius.circular(7),
                            border: Border.all(
                                color:
                                    const Color.fromARGB(255, 255, 255, 255))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              height: hight * .12,
                              width: width * .37,
                              decoration: BoxDecoration(
                                  color: whiteAppColor,
                                  borderRadius: BorderRadius.circular(8)),
                              child: Image.asset(
                                height: hight * 1.1,
                                menu[index]["img"].toString(),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              menu[index]["title"],
                              style: const TextStyle(
                                  color: shadowAppColor,
                                  fontWeight: FontWeight.w500),
                            ),
                            InkWell(
                              /* onTap: () {
                                menu[index]["id"] == 1
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BreakfastScreen()))
                                    : menu[index]["id"] == 2
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MeanMaleScreen()))
                                        : menu[index]["id"] == 3
                                            ? Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DrinkScreen()))
                                            : menu[index]["id"] == 4
                                                ? Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            SweetScreen()))
                                                : Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            HookahScreen()));
                              },*/
                              child: Container(
                                width: width * .20,
                                height: hight * .04,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color:
                                      const Color.fromARGB(255, 43, 171, 196),
                                ),
                                child: const Center(
                                    child: Text(
                                  "Price",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                )),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
