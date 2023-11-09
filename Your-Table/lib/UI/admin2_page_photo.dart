// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:restuarant/UI/aboutus.dart';
import 'package:restuarant/UI/adminsettingspage.dart';
import 'package:restuarant/consts/images.dart';

import '../main.dart';
import 'auth_functions.dart';

class Photo2 extends StatefulWidget {
  const Photo2({super.key, String? adminId});

  @override
  State<StatefulWidget> createState() {
    return Photo2State();
  }
}

class Photo2State extends State<Photo2> {
  File? galleryFile;
  final picker = ImagePicker();

  void _showPicker({
    required BuildContext context,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage(
    ImageSource img,
  ) async {
    final pickedFile = await picker.pickImage(source: img);
    XFile? xfilePick = pickedFile;
    setState(
      () {
        if (xfilePick != null) {
          galleryFile = File(pickedFile!.path);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(// is this context <<<
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String? adminId = Provider.of<AdminData>(context).adminId;
    User? admin = FirebaseAuth.instance.currentUser;
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
                  .collection('Admin')
                  .doc(admin?.uid)
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
                String adminName = adminData!['adminname'];

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
                  .collection('Admin')
                  .doc(admin?.uid)
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
                String adminEmail = adminData?['adminemail'];

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
                    builder: (context) => SettingsPage(adminId: adminId)),
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
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Photo",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF2babc4),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Row(
            children: <Widget>[
              //#1
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 60.0),
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: AssetImage(r7),
                        radius: 150,
                      ),
                      Container(
                        height: 60.0,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 60.0),
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: AssetImage(r8),
                        radius: 150,
                      ),
                      Container(
                        height: 60.0,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 60.0),
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: AssetImage(r9),
                        radius: 150,
                      ),
                      Container(
                        height: 60.0,
                      ),
                    ],
                  ),
                ),
              ),

              //#2
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(top: 60.0),
                  child: Column(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: AssetImage(r10),
                        radius: 150,
                      ),
                      Container(
                        height: 60.0,
                      ),
                    ],
                  ),
                ),
              ),

              //#3

              //#5
              /*Padding(
                padding: const EdgeInsets.only(top: 500.0, right: 30.0),
                child: Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 17.0),
                        // ignore: deprecated_member_use
                        primary: const Color(0xFF2babc4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    icon: const Icon(Icons.add_photo_alternate_outlined,
                        color: Colors.black),
                    label: const Text("Add Photo",
                        style: TextStyle(color: Colors.black)),
                    onPressed: () {
                      _showPicker(context: context);
                    },
                  ),
                ),
              )*/
            ],
          ),
        ),
      ),
    );
  }
}
