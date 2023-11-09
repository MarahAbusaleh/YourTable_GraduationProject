import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:restuarant/UI/adminsettingspage.dart';

import '../main.dart';
import 'adminchangename.dart';
import 'adminchangephone.dart';

class CahngeInfoPage extends StatefulWidget {
  const CahngeInfoPage({super.key, required String? adminId});

  @override
  State<CahngeInfoPage> createState() => _CahngeInfoPageState();
}

class _CahngeInfoPageState extends State<CahngeInfoPage> {
  @override
  Widget build(BuildContext context) {
    String? adminId = Provider.of<AdminData>(context).adminId;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => SettingsPage(adminId: adminId)),
            );
          },
        ),
        backgroundColor: const Color.fromARGB(255, 43, 171, 196),
        title: const Text('Change My Information',
            style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
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
            title: const Text("Change my name",
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 20)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AdminChangenamePage(adminId: adminId)),
              );
            },
          ),
          const Divider(
            color: Color.fromARGB(255, 255, 255, 255),
            thickness: 0.5,
          ),
          ListTile(
            leading: const Icon(
              Icons.phone,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            title: const Text("Change my phone number",
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255), fontSize: 20)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AdminChangePhonePage(adminId: adminId)),
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
