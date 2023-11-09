import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restuarant/resetpassword.dart';
import 'package:restuarant/userchangeinfo.dart';
import 'package:restuarant/views/screens/home_screen.dart';

import '../main.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, String? userId});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    String? userId = Provider.of<UserData>(context).userId;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        userId: userId,
                      )),
            );
          },
        ),
        backgroundColor: const Color.fromARGB(255, 43, 171, 196),
        title: const Text('Settings',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.person,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            title: const Text("Change my information",
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 20)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CahngeInfoPage(
                          userId: userId,
                        )),
              );
            },
          ),
          const Divider(
            color: Color.fromARGB(255, 255, 255, 255),
            thickness: 0.5,
          ),
          ListTile(
            leading: const Icon(
              Icons.password,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            title: const Text("Reset Password",
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 20)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ResetPasswordPage(userId: userId)),
              );
            },
          ),
          const Divider(
            color: Color.fromARGB(255, 255, 255, 255),
            thickness: 0.5,
          ),
        ],
      ),
    );
  }
}
