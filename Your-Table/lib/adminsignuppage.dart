// ignore_for_file: unused_local_variable, prefer_typing_uninitialized_variables, non_constant_identifier_names, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'UI/auth_functions.dart';
import 'main.dart';

class AdminSignUpPage extends StatefulWidget {
  const AdminSignUpPage({super.key, required adminId});

  @override
  State<AdminSignUpPage> createState() => _AdminSignUpPageState();
}

class _AdminSignUpPageState extends State<AdminSignUpPage> {
  bool _passwordVisible = false;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  final RegExp phonenumber = RegExp(r'^\+9627(7|8|9)\d{7}$');
  final RegExp emailaddress = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final RegExp passwordd =
      RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');

  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    String? adminId = Provider.of<AdminData>(context).adminId;
    var name;
    var email;
    var phone_number;
    var password;

    GlobalKey<FormState> check = GlobalKey<FormState>();

    // ignore: non_constant_identifier_names
    void SignUp() {
      var checkfeild = check.currentState;
      if (checkfeild!.validate() && isChecked) {
        checkfeild.save();
        SignUpAdmin(nameController.text, emailController.text,
            phoneController.text, passwordController.text, context);
        /*showDialog(
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
                    'We have sent an activation link to your email address, Please click on the link to activate your account.',
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
                                builder: (context) => MultiProvider(
                                    providers: [
                                      ChangeNotifierProvider<UserData>(
                                          create: (_) => UserData()),
                                      ChangeNotifierProvider<AdminData>(
                                          create: (_) => AdminData()),
                                    ],
                                    child: AdminLogInPage(
                                      adminId: adminId,
                                    )),
                              ));
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
            });*/
      }
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Admin Page',
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            backgroundColor: const Color.fromARGB(255, 43, 171, 196),
          ),
          body: Container(
              padding: const EdgeInsets.only(
                top: 20,
              ),
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
                          alignment: Alignment.topLeft,
                          child: const Text(
                            'Create Account',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        )
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
                              controller: nameController,
                              onSaved: (text) {
                                name = text!;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
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
                                  counterStyle: TextStyle(
                                      color:
                                          Color.fromARGB(255, 140, 139, 139)),
                                  icon: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  hintText: 'Enter your name',
                                  hintStyle: TextStyle(
                                      color:
                                          Color.fromARGB(255, 140, 139, 139)),
                                  labelText: 'Name',
                                  labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 43, 171, 196))),
                                  errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 142, 10, 14)))),
                              cursorColor: Colors.white,
                              cursorHeight: 25,
                              maxLength: 20,
                              maxLines: 1,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                            )),
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
                                email = text!;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
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
                                          color: Color.fromARGB(
                                              255, 43, 171, 196))),
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
                              controller: phoneController,
                              onSaved: (text) {
                                phone_number = text!;
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return "Phone number can't be empty";
                                } else if (phonenumber.hasMatch(text)) {
                                  return null;
                                } else {
                                  return "Enter a valid Phone number";
                                }
                              },
                              style: const TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                  counterStyle: TextStyle(
                                      color:
                                          Color.fromARGB(255, 140, 139, 139)),
                                  icon: Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                  hintText: 'ex: +9627########',
                                  hintStyle: TextStyle(
                                      color:
                                          Color.fromARGB(255, 140, 139, 139)),
                                  labelText: 'Phone Number',
                                  labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 43, 171, 196))),
                                  errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 142, 10, 14)))),
                              cursorColor: Colors.white,
                              cursorHeight: 25,
                              maxLength: 13,
                              maxLines: 1,
                              keyboardType: TextInputType.phone,
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
                                password = text!;
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
                                      color:
                                          Color.fromARGB(255, 140, 139, 139)),
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
                                      color: const Color.fromARGB(
                                          255, 43, 171, 196),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                  hintText: 'Enter your password',
                                  hintStyle: const TextStyle(
                                      color:
                                          Color.fromARGB(255, 140, 139, 139)),
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
                                          color: Color.fromARGB(
                                              255, 43, 171, 196))),
                                  errorBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 142, 10, 14)))),
                              cursorColor: Colors.white,
                              cursorHeight: 25,
                              maxLength: 20,
                              maxLines: 1,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              obscureText: !_passwordVisible,
                            ))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          side: MaterialStateBorderSide.resolveWith(
                            (states) => const BorderSide(
                                width: 2.0,
                                color: Color.fromARGB(255, 140, 139, 139)),
                          ),
                          activeColor: const Color.fromARGB(255, 43, 171, 196),
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        const Text('I have read and agree to the',
                            style: TextStyle(
                              fontSize: 12,
                              color: Color.fromARGB(255, 140, 139, 139),
                            )),
                        TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (_) => const AlertDialog(
                                title: Text('Terms and Conditions'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Please read these Terms and Conditions ("Terms") carefully before using our mobile application (Your Table) and related services. By using the App, you agree to be bound by these Terms..',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                        ),
                                      ),
                                      SizedBox(height: 16.0),
                                      Text(
                                        '''1- Description of Service

Our App allows users to make reservations at restaurants and cafes. We are not responsible for any issues that may arise during or after your meal, and we do not guarantee the availability or quality of any restaurant or cafe listed on the App.

2- User Accounts 

To use our App, you must create a user account. You are responsible for maintaining the confidentiality of your account and password, and for restricting access to your account. You agree to accept responsibility for all activities that occur under your account or password.

3- Payment

Payment for your reservation is made directly to the restaurant or cafe, and is subject to their payment policies. We are not responsible for any payment issues or disputes that may arise.

4- Modification of Terms

We reserve the right to modify these Terms at any time, without notice to you. By continuing to use the App after any modifications have been made, you agree to be bound by the revised Terms.

5- Termination

We may terminate your access to the App at any time, without notice or liability, for any reason whatsoever.

6- Limitation of Liability

We are not responsible for any damages, including but not limited to, direct, indirect, incidental, consequential, or punitive damages, arising out of your use of the App or any restaurant or cafe listed on the App.

7- Governing Law

These Terms shall be governed by and construed in accordance with the laws of HKJ.

By using this app, you agree to be bound by these terms and conditions, If you do not agree to these terms and conditions, you should not use this app.''',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16.0,
                                        width: double.infinity,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: const Text('Terms and Conditions.',
                              style: TextStyle(
                                fontSize: 13,
                                color: Color.fromARGB(255, 43, 171, 196),
                              )),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: 10, right: 10, left: 10),
                          child: SizedBox(
                            height: 50,
                            width: 150,
                            child: MaterialButton(
                                color: const Color.fromARGB(255, 43, 171, 196),
                                onPressed: () {
                                  SignUp();
                                },
                                textColor: const Color.fromARGB(255, 0, 0, 0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22),
                                )),
                          ),
                        )
                      ],
                    )

                    /*Row(
                        children: [
                          Container(
                              margin: const EdgeInsets.only(left: 60),
                              child: const Text(
                                'Already have an account?',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              )),
                          Builder(
                              builder: (context) => TextButton(
                                    child: const Text('Login!',
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
                                                const LogInPage()),
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
