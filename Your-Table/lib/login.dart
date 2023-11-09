// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:restuarant/views/screens/home_screen.dart';
import './forgetpassword.dart';
import 'UI/auth_functions.dart';
import 'main.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key, required String? userId});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final RegExp emailaddress = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final RegExp passwordd =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');

  bool rememberme = false;
  bool _passwordVisible = false;

  var email;
  var password;

  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String? userId = Provider.of<UserData>(context).userId;
    GlobalKey<FormState> check = GlobalKey<FormState>();

    void LogIn() {
      var checkfeild = check.currentState;
      if (checkfeild!.validate()) {
        checkfeild.save();
        loginUser(emailController.text, passwordController.text, context);
      }
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Container(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                color: const Color.fromARGB(255, 0, 0, 0),
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                    child: Form(
                  key: check,
                  child: Column(
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/images/logo/yourtable.PNG',
                          width: 125,
                          height: 125,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 20),
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'Login to continue,',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(right: 20),
                          width: 350,
                          child: TextFormField(
                            controller: emailController,
                            onSaved: (text) {
                              email = text;
                            },
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                                icon: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                  size: 25,
                                ),
                                hintText: 'Enter your email address',
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 140, 139, 139)),
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 43, 171, 196)),
                                ),
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
                          margin: const EdgeInsets.only(right: 20),
                          width: 350,
                          child: TextFormField(
                            controller: passwordController,
                            onSaved: (text) {
                              password = text;
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
                              counterStyle: const TextStyle(
                                color: Color.fromARGB(255, 140, 139, 139),
                              ),
                              icon: const Icon(
                                Icons.lock,
                                color: Colors.white,
                                size: 25,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color:
                                      const Color.fromARGB(255, 43, 171, 196),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                },
                              ),
                              hintText: 'Enter your password',
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 140, 139, 139)),
                              labelText: 'Password',
                              labelStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 43, 171, 196))),
                              errorBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 142, 10, 14))),
                            ),
                            cursorColor: Colors.white,
                            cursorHeight: 25,
                            maxLength: 20,
                            maxLines: 1,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            obscureText: !_passwordVisible,
                          )),
                      Container(
                        margin: const EdgeInsets.fromLTRB(15, 15, 15, 10),
                        child: Center(
                            child: TextButton(
                          child: const Text('Forget Password?',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 43, 171, 196),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ForgetPasswordPage(userId: userId)),
                            );
                          },
                        )),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: SizedBox(
                            height: 50,
                            width: 150,
                            child: MaterialButton(
                                color: const Color.fromARGB(255, 43, 171, 196),
                                onPressed: () {
                                  LogIn();
                                },
                                textColor: const Color.fromARGB(255, 0, 0, 0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                ))),
                      )
                    ],
                  ),
                )))));
  }
}
