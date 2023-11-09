// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restuarant/UI/auth_functions.dart';
import './adminforgetpassword.dart';
//import './branchpage.dart';
import 'main.dart';

class AdminLogInPage extends StatefulWidget {
  const AdminLogInPage({super.key, required String? adminId});

  @override
  State<AdminLogInPage> createState() => _AdminLogInPageState();
}

class _AdminLogInPageState extends State<AdminLogInPage> {
  final RegExp emailaddress = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final RegExp passwordd =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');

  bool rememberme = false;
  bool _passwordVisible = false;
  bool emailempty = false;
  bool passwordempty = false;

  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String? adminId = Provider.of<AdminData>(context).adminId;
    var email;
    var password;
    GlobalKey<FormState> check = GlobalKey<FormState>();

    // ignore: non_constant_identifier_names
    void LogIn() {
      var checkfeild = check.currentState;
      if (checkfeild!.validate()) {
        checkfeild.save();
        loginAdmin(emailController.text, passwordController.text, context);
      }
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Admin Page',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: const Color.fromARGB(255, 43, 171, 196),
          ),
          body: Container(
              padding: const EdgeInsets.only(top: 20),
              color: const Color.fromARGB(255, 0, 0, 0),
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                  child: Form(
                key: check,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Image.asset(
                        'assets/images/logo/yourtable.PNG',
                        width: 125,
                        height: 125,
                      ),
                    ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(20),
                          child: const Text(
                            'Login to continue,',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(
                                top: 10, right: 10, left: 10),
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
                                      color:
                                          Color.fromARGB(255, 140, 139, 139)),
                                  icon: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  hintText: 'Enter your email address',
                                  hintStyle: TextStyle(
                                      color:
                                          Color.fromARGB(255, 140, 139, 139)),
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
                                        color:
                                            Color.fromARGB(255, 43, 171, 196)),
                                  ),
                                  errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 142, 10, 14)))),
                              cursorColor: Colors.white,
                              cursorHeight: 25,
                              maxLength: 40,
                              maxLines: 1,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.done,
                            ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            margin: const EdgeInsets.only(
                                top: 10, right: 10, left: 10),
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
                              obscureText: !_passwordVisible,
                              style: const TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                counterStyle: const TextStyle(
                                    color: Color.fromARGB(255, 140, 139, 139)),
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
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 43, 171, 196))),
                                errorBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Color.fromARGB(255, 142, 10, 14))),
                              ),
                              cursorColor: Colors.white,
                              cursorHeight: 25,
                              maxLength: 20,
                              maxLines: 1,
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.done,
                            )),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Builder(
                          builder: (context) => SizedBox(
                              height: 50,
                              width: 150,
                              child: TextButton(
                                child: const Text('Forget Password?',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 43, 171, 196),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline)),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AdminForgetPasswordPage(
                                                adminId: adminId)),
                                  );
                                },
                              )),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: Builder(
                            builder: (context) => SizedBox(
                                height: 50,
                                width: 150,
                                child: MaterialButton(
                                    color:
                                        const Color.fromARGB(255, 43, 171, 196),
                                    onPressed: () {
                                      //LogIn();
                                      var checkfeild = check.currentState;
                                      if (checkfeild!.validate()) {
                                        checkfeild.save();
                                        loginAdmin(emailController.text,
                                            passwordController.text, context);
                                      }
                                    },
                                    textColor:
                                        const Color.fromARGB(255, 32, 31, 31),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22),
                                    ))),
                          ),
                        )
                      ],
                    )
                    /*Row(
                        children: [
                          Container(
                              margin: const EdgeInsets.only(left: 60),
                              child: const Text(
                                'Don\'t have an account?',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              )),
                          Builder(
                              builder: (context) => TextButton(
                                    child: const Text('SignUp!',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 43, 171, 196),
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            decoration:
                                                TextDecoration.underline)),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUpPage()),
                                      );
                                    },
                                  ))
                        ],
                      )*/
                  ],
                ),
              ))),
        ));
  }
}
