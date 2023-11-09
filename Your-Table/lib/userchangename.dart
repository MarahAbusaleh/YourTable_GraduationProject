// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, prefer_const_constructors, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restuarant/userchangeinfo.dart';
import '../main.dart';

class ChangenamePage extends StatefulWidget {
  const ChangenamePage({super.key, required String? userId});

  @override
  State<ChangenamePage> createState() => _ChangenamePageState();
}

final nameController = TextEditingController();

class _ChangenamePageState extends State<ChangenamePage> {
  var name;
  var phone_number;
  @override
  Widget build(BuildContext context) {
    String? userId = Provider.of<UserData>(context).userId;
    GlobalKey<FormState> check = GlobalKey<FormState>();

    void Change() {
      var checkfeild = check.currentState;
      if (checkfeild!.validate()) {
        checkfeild.save();
        updateAdminFields(nameController.text);
        showDialog(
            context: context,
            builder: (context) {
              return Container(
                margin: const EdgeInsets.only(bottom: 75),
                child: AlertDialog(
                  title: const Icon(
                    Icons.check_circle,
                    size: 60,
                    color: Color.fromARGB(255, 43, 171, 196),
                  ),
                  content: const Text(
                    'Your information has been changed successfully.',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CahngeInfoPage(userId: userId)),
                          );
                        },
                        child: const Text(
                          'OK',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ))
                  ],
                ),
              );
            });
      }
    }

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Color.fromARGB(255, 43, 171, 196),
            title: const Text(
              'Change My Information',
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            )),
        body: Builder(builder: (BuildContext context) {
          return Form(
            key: check,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(children: [
                Container(
                    // margin: const EdgeInsets.only(right: 20),
                    //width: 350,
                    child: TextFormField(
                  controller: nameController,
                  onSaved: (text) {
                    name = text!;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "Name can't be empty";
                    } else if (text.length < 2) {
                      return "Name must be longer";
                    } else if (RegExp('^[a-zA-Z\\sa-zA-Z\\s]\$')
                        .hasMatch(text)) {
                      return null;
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      counterStyle:
                          TextStyle(color: Color.fromARGB(255, 140, 139, 139)),
                      hintText: 'Enter your new name',
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 140, 139, 139)),
                      labelText: 'Name',
                      labelStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 43, 171, 196))),
                      errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 142, 10, 14)))),
                  cursorColor: Colors.white,
                  cursorHeight: 25,
                  maxLength: 20,
                  maxLines: 1,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                )),
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                      height: 50,
                      width: 150,
                      child: MaterialButton(
                          color: const Color.fromARGB(255, 43, 171, 196),
                          onPressed: () {
                            Change();
                          },
                          textColor: const Color.fromARGB(255, 0, 0, 0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          child: const Text(
                            'Save',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ))),
                ),
              ]),
            ),
          );
        }));
  }
}

void updateAdminFields(String? newName) async {
  try {
    // Get a reference to the Firestore collection
    CollectionReference adminRef =
        FirebaseFirestore.instance.collection('User');
    User? user = FirebaseAuth.instance.currentUser;

    // Prepare the update data
    Map<String, dynamic> updateData = {};

    // Check if newName is not null and update adminname field
    if (newName != null) {
      updateData['username'] = newName;
    }

    // Check if newPhone is not null and update adminphone field
    // Perform the update if there are any fields to update
    if (updateData.isNotEmpty) {
      await adminRef.doc(user?.uid).update(updateData);
    }
  } catch (e) {
    // Handle any errors
    print('Error updating admin record: $e');
  }
}
