// ignore_for_file: non_constant_identifier_names, unused_local_variable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './tabs.dart';
import 'main.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key, required String? userId});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPage();
}

class _ForgetPasswordPage extends State<ForgetPasswordPage> {
  final emailController = TextEditingController();
  final RegExp emailaddress = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  Widget build(BuildContext context) {
    String? userId = Provider.of<UserData>(context).userId;
    var email;

    GlobalKey<FormState> check = GlobalKey<FormState>();

    void Forget() {
      var checkfeild = check.currentState;
      if (checkfeild!.validate()) {
        checkfeild.save();
        showDialog(
            context: context,
            builder: (context) {
              return Container(
                margin: const EdgeInsets.only(bottom: 75),
                child: AlertDialog(
                  title: const Text(
                    'Check your mail',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0)),
                  ),
                  content: const Text(
                    'We have sent a password recover instructions to your mail.',
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
                                builder: (context) => Tabs(userId: userId)),
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
              // ignore: prefer_const_constructors
              backgroundColor: Color.fromARGB(255, 43, 171, 196),
              title: const Text(
                'Forget Password',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
          body: Builder(builder: (BuildContext context) {
            return Container(
              padding: const EdgeInsets.fromLTRB(50, 40, 60, 40),
              child: SingleChildScrollView(
                  child: Form(
                key: check,
                child: Column(
                  children: [
                    const Center(
                      child: Icon(
                        Icons.lock_open,
                        color: Colors.white,
                        size: 100,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: const Text(
                        'Forget Password?',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      width: 300,
                      height: 80,
                      child: Text(
                          'Enter the email associated with your account and we\'ll send an email with instructions to reset your password.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          )),
                    ),
                    SizedBox(
                        width: 350,
                        child: TextFormField(
                          controller: emailController,
                          onSaved: (text) {
                            email = text;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (text) {
                            if (text!.isEmpty) {
                              return "Email can't be empty";
                            } else if (emailaddress.hasMatch(text)) {
                              return null;
                            } else {
                              return "Enter a vaild email";
                            }
                          },
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              counterStyle: TextStyle(
                                  color: Color.fromARGB(255, 140, 139, 139)),
                              hintText: 'Enter your email address',
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 140, 139, 139)),
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 43, 171, 196))),
                              errorBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 142, 10, 14)))),
                          cursorColor: Colors.white,
                          cursorHeight: 25,
                          maxLength: 40,
                          maxLines: 1,
                          keyboardType: TextInputType.emailAddress,
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
                              Forget();
                            },
                            textColor: const Color.fromARGB(255, 0, 0, 0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child: const Text(
                              'Send',
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
