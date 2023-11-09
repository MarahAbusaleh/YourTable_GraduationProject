// ignore_for_file: non_constant_identifier_names, unused_local_variable, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restuarant/views/screens/home_screen.dart';

import '../main.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key, required String? userId, String? adminId});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? userId = Provider.of<UserData>(context).userId;
    var feedback;

    GlobalKey<FormState> check = GlobalKey<FormState>();

    Future<void> storeFeedback(String feedback) async {
      User? currentUser = FirebaseAuth.instance.currentUser;
      String userId = currentUser!.uid;

      try {
        await FirebaseFirestore.instance.collection('Feedback').add({
          'userid': userId,
          'feedback': feedback,
        });
        print('Feedback stored successfully!');
      } catch (error) {
        print('Error storing feedback: $error');
      }
    }

    void Feedback() {
      var checkfeild = check.currentState;
      if (checkfeild!.validate()) {
        checkfeild.save();
        storeFeedback(feedbackController.text);
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
                    'Your feedback has been sent successfully.',
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
                                    HomeScreen(userId: userId)),
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

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          resizeToAvoidBottomInset: true,
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
              backgroundColor: const Color.fromARGB(255, 43, 171, 196),
              title: const Text(
                'Feedback',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
          body: Builder(builder: (BuildContext context) {
            return Container(
              padding: const EdgeInsets.fromLTRB(10, 60, 10, 40),
              child: SingleChildScrollView(
                  child: Form(
                key: check,
                child: Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(
                                width: 1.5,
                                color:
                                    const Color.fromARGB(255, 255, 255, 255))),
                        //width: 450,
                        child: TextFormField(
                          controller: feedbackController,
                          onSaved: (text) {
                            feedback = text;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (text) {
                            if (text!.isEmpty) {
                              return "Feedback can't be empty";
                            } else {
                              return null;
                            }
                          },
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              counterStyle: TextStyle(
                                  color: Color.fromARGB(255, 140, 139, 139)),
                              hintText: 'Enter your feedback',
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 140, 139, 139)),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 0, 0, 0))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 0, 0, 0))),
                              errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 142, 10, 14)))),
                          cursorColor: Colors.white,
                          cursorHeight: 25,
                          maxLines: 10,
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                        )),
                    Container(
                      padding: const EdgeInsets.only(top: 40),
                      child: SizedBox(
                          height: 50,
                          width: 150,
                          child: MaterialButton(
                            color: const Color.fromARGB(255, 43, 171, 196),
                            onPressed: () {
                              Feedback();
                            },
                            textColor: const Color.fromARGB(255, 0, 0, 0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 22),
                            ),
                          )),
                    ),
                  ],
                ),
              )),
            );
          })),
    );
  }
}
