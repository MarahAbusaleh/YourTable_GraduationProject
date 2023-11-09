// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'admin2_page_menu.dart';
import 'admin2_page_photo.dart';
import 'admin2_page_tables_information.dart';

class AdminTabs2 extends StatefulWidget {
  const AdminTabs2({super.key, required adminId, required userId});

  @override
  State<StatefulWidget> createState() {
    return AdminTabs2State();
  }
}

class AdminTabs2State extends State<AdminTabs2> {
  @override
  Widget build(BuildContext context) {
    String? userId = Provider.of<UserData>(context).userId;
    String? adminId = Provider.of<AdminData>(context).adminId;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            toolbarHeight: 1,
            backgroundColor: Colors.black,
            bottom: TabBar(
                labelColor: Colors.black,
                indicatorWeight: 2.0,
                indicatorColor: const Color(0xFF2babc4),
                indicator: BoxDecoration(
                    color: const Color(0xFF2babc4),
                    borderRadius: BorderRadius.circular(20)),
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                unselectedLabelColor: Colors.white,
                tabs: [
                  //1
                  Container(
                    padding: const EdgeInsets.all(8),
                    width: 200,
                    height: 40,
                    child: const Text(
                      'Menu',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                  ),
                  //2
                  Container(
                    padding: const EdgeInsets.all(8),
                    width: 200,
                    height: 40,
                    child: const Text(
                      'Photo',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  //3
                  Container(
                    padding: const EdgeInsets.all(8),
                    width: 200,
                    height: 40,
                    child: const Text(
                      'Tables Inforamtion',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
          ),
          body: TabBarView(
            children: [
              Menu2(adminId: adminId),
              Photo2(adminId: adminId),
              TablesInfo2(
                adminId: adminId,
              )
            ],
          ),
        ),
      ),
    );
  }
}
