// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restuarant/UI/adminsettingspage.dart';
import '../main.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key, required String? adminId});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  bool _passwordVisible1 = false;
  bool _passwordVisible2 = false;

  final passwordController = TextEditingController();
  final passworddController = TextEditingController();
  final RegExp passwordd =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');

  @override
  Widget build(BuildContext context) {
    String? adminId = Provider.of<AdminData>(context).adminId;
    var _password1;
    var _password2;

    GlobalKey<FormState> check = GlobalKey<FormState>();

    void resetPassword(
        String adminId, String newPassword, BuildContext context) async {
      try {
        // Get a reference to the Firestore collection
        CollectionReference userRef =
            FirebaseFirestore.instance.collection('Admin');

        // Get the document reference for the user with the provided userId
        DocumentReference userDocRef = userRef.doc(adminId);

        // Get the current user document
        DocumentSnapshot userDoc = await userDocRef.get();

        if (userDoc.exists) {
          // Get the current password
          String currentPassword = userDoc['adminpassword'];

          // Check if the new password is different from the current password
          if (newPassword != currentPassword) {
            // Update the password field with the new password
            await userDocRef.update({'adminpassword': newPassword});

            print('Password reset successful');

            showDialog(
              context: context,
              builder: (context) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 75),
                  child: AlertDialog(
                    title: const Text(
                      'Done',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 32, 31, 31),
                      ),
                    ),
                    content: const Text(
                      'Your password has been reset successfully.',
                      style: TextStyle(color: Color.fromARGB(255, 32, 31, 31)),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SettingsPage(adminId: adminId),
                            ),
                          );
                        },
                        child: const Text(
                          'OK',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            showDialog(
              context: context,
              builder: (context) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 75),
                  child: AlertDialog(
                    title: const Text(
                      'Failed',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 32, 31, 31),
                      ),
                    ),
                    content: const Text(
                      'New password must be different from the previous password.',
                      style: TextStyle(color: Color.fromARGB(255, 32, 31, 31)),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SettingsPage(adminId: adminId),
                            ),
                          );
                        },
                        child: const Text(
                          'OK',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );

            print('New password must be different from the previous password');
          }
        }
      } catch (e) {
        // Handle any errors
        print('Error resetting password: $e');
      }
    }

    void Reset() {
      var checkfeild = check.currentState;
      if (checkfeild!.validate()) {
        checkfeild.save();
        resetPassword(adminId!, passworddController.text, context);
        showDialog(
            context: context,
            builder: (context) {
              return SizedBox(
                width: 350,
                height: 100,
                child: AlertDialog(
                    title: const Icon(
                      Icons.check_circle,
                      size: 60,
                      color: Color.fromARGB(255, 43, 171, 196),
                    ),
                    content: const Text(
                      'Your password has been reset successfully.',
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SettingsPage(adminId: adminId)),
                            );
                          },
                          child: const Text(
                            'OK',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          )),
                    ]),
              );
            });
      }
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            resizeToAvoidBottomInset: false,
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
              title: const Text(
                'Reset Password',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: const Color.fromARGB(255, 43, 171, 196),
            ),
            body: Container(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: SingleChildScrollView(
                  child: Form(
                    key: check,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(20),
                            child: const Text(
                              'Your new password must be different from previous passwords.',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 180, 178, 178),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                              child: TextFormField(
                            controller: passwordController,
                            onSaved: (text) {
                              _password1 = text;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return "Password can't be empty";
                              } else if (passwordd.hasMatch(text)) {
                                return null;
                              } else {
                                return 'Enter a stronger password';
                              }
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible1
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color:
                                        const Color.fromARGB(255, 43, 171, 196),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible1 = !_passwordVisible1;
                                    });
                                  },
                                ),
                                counterStyle: const TextStyle(
                                    color: Color.fromARGB(255, 140, 139, 139)),
                                hintText: 'Enter your new password',
                                hintStyle: const TextStyle(
                                    color: Color.fromARGB(255, 140, 139, 139)),
                                labelText: 'New Password',
                                labelStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 43, 171, 196))),
                                errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 142, 10, 14)))),
                            cursorColor: Colors.white,
                            cursorHeight: 25,
                            maxLength: 20,
                            maxLines: 1,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            obscureText: !_passwordVisible1,
                          )),
                          SizedBox(
                              child: TextFormField(
                            controller: passworddController,
                            onSaved: (text) {
                              _password2 = text;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return "Password can't be empty";
                              } else if (passworddController.text !=
                                  passwordController.text) {
                                return "Password don't match!";
                              } else {
                                return null;
                              }
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible2
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color:
                                        const Color.fromARGB(255, 43, 171, 196),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible2 = !_passwordVisible2;
                                    });
                                  },
                                ),
                                counterStyle: const TextStyle(
                                    color: Color.fromARGB(255, 140, 139, 139)),
                                hintText: 'Re-enter your password',
                                hintStyle: const TextStyle(
                                    color: Color.fromARGB(255, 140, 139, 139)),
                                labelText: 'Confirm Password',
                                labelStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 43, 171, 196))),
                                errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 142, 10, 14)))),
                            cursorColor: Colors.white,
                            cursorHeight: 25,
                            maxLength: 20,
                            maxLines: 1,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            obscureText: !_passwordVisible2,
                          )),
                          Container(
                            padding: const EdgeInsets.only(top: 30),
                            child: SizedBox(
                                height: 50,
                                width: 150,
                                child: MaterialButton(
                                  color:
                                      const Color.fromARGB(255, 43, 171, 196),
                                  onPressed: () {
                                    Reset();
                                  },
                                  textColor: const Color.fromARGB(255, 0, 0, 0),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50)),
                                  child: const Text(
                                    'Save',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))));
  }
}
