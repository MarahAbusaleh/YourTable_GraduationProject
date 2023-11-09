import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'admin1_page_menu.dart';
import 'admin1_page_photo.dart';
import 'admin1_page_tables_information.dart';

class AdminTabs1 extends StatefulWidget {
  const AdminTabs1({super.key, required adminId, required userId});

  @override
  State<StatefulWidget> createState() {
    return AdminTabs1State();
  }
}

class AdminTabs1State extends State<AdminTabs1> {
  @override
  Widget build(BuildContext context) {
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
              Menu1(adminId: adminId),
              Photo1(adminId: adminId),
              TablesInfo1(
                adminId: adminId,
              )
            ],
          ),
        ),
      ),
    );
  }
}
