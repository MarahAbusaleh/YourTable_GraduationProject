import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:restuarant/UI/aboutus.dart';
import 'package:restuarant/UI/auth_functions.dart';
import 'package:restuarant/UI/feedbackpage.dart';

import 'package:restuarant/views/screens/restaurant_name.dart';

import '../../consts/List.dart';
import '../../consts/images.dart';
import '../../main.dart';
import '../../usersettingspage.dart';
import '../../widgets/custom_post.dart';
import '../../widgets/custom_search.dart';

// ignore: must_be_immutable

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required String? userId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String namePage = 'Home';
  CollectionReference ResData = FirebaseFirestore.instance.collection(
    "Restaurant",
  );

  @override
  Widget build(BuildContext context) {
    String? userId = Provider.of<UserData>(context).userId;
    User? user = FirebaseAuth.instance.currentUser;
    var hight = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      drawer: Drawer(
          child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              child: Icon(
                Icons.person,
                size: 40,
                color: Colors.grey,
              ),
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 43, 171, 196),
            ),
            accountName: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('User')
                  .doc(user?.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text(
                    'Loading...',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 20,
                    ),
                  );
                }

                var adminData = snapshot.data!.data() as Map<String, dynamic>?;
                String adminName = adminData!['username'];

                return Text(
                  adminName,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20,
                  ),
                );
              },
            ),
            accountEmail: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('User')
                  .doc(user?.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text(
                    'Loading...',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                    ),
                  );
                }

                var adminData = snapshot.data!.data() as Map<String, dynamic>?;
                String adminEmail = adminData?['useremail'];

                return Text(
                  adminEmail,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                  ),
                );
              },
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
            title: const Text("Settings",
                style: TextStyle(color: Colors.black, fontSize: 20)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SettingsPage(userId: userId)),
              );
            },
          ),
          const Divider(
            color: Color.fromARGB(255, 0, 0, 0),
            thickness: 0.5,
          ),
          ListTile(
            leading: const Icon(
              Icons.feedback,
              color: Colors.black,
            ),
            title: const Text("Feedback",
                style: TextStyle(color: Colors.black, fontSize: 20)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FeedbackPage(userId: userId)),
              );
            },
          ),
          const Divider(
            color: Color.fromARGB(255, 0, 0, 0),
            thickness: 0.5,
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.black,
            ),
            title: Text("Logout",
                style: TextStyle(color: Colors.black, fontSize: 20)),
            onTap: () {
              signOutUser(context);
            },
          ),
          const Divider(
            color: Color.fromARGB(255, 0, 0, 0),
            thickness: 0.5,
          ),
          ListTile(
            leading: const Icon(
              Icons.question_mark,
              color: Colors.black,
            ),
            title: const Text("About Us",
                style: TextStyle(color: Colors.black, fontSize: 20)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsPage()),
              );
            },
          ),
          const Divider(
            color: Color.fromARGB(255, 0, 0, 0),
            thickness: 0.5,
          ),
        ],
      )),
      appBar: AppBar(
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: const Color.fromARGB(255, 43, 171, 196),
          title: Text(
            namePage,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          )),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * .06,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 80,
                  child: CustomSearch(
                    text: "Search for Restaurant here...",
                    fontsize: 13.5,
                  ),
                ),
              ),
              const SizedBox(
                width: double.infinity,
                height: 30,
                child: Text(
                  ' Sort By',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 20),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: SizedBox(
                  height: hight * .15,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: title.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            namePage = title[index];
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: width * .01, vertical: 10),
                          height: hight * .1,
                          width: width * .27,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Center(
                            child: Text(
                              title[index],
                              style: const TextStyle(
                                  color: Color.fromARGB(115, 0, 0, 0),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: double.infinity,
                height: 35,
                child: Text(
                  'Restaurants',
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255), fontSize: 22),
                ),
              ),
              FutureBuilder(
                  future: ResData.get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        height: hight * .5,
                        width: double.infinity,
                        child: ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            return CustomPost(
                              onpressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RestaurantName(
                                            name: snapshot.data?.docs[index]
                                                ['restaurantname'],
                                            i: index,
                                            userId: userId,
                                          )),
                                );
                              },
                              restName:
                                  "${snapshot.data?.docs[index]['restaurantname']}",
                              text:
                                  "${snapshot.data?.docs[index]['restaurantstatus']}",
                              img: index == 0 ? r1 : r7,
                              place:
                                  "${snapshot.data?.docs[index]['shortlocation']}",
                            );
                          },
                        ),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
