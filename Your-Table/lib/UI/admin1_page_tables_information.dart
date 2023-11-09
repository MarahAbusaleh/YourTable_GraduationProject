import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restuarant/UI/aboutus.dart';
import 'package:restuarant/UI/adminsettingspage.dart';
import '../main.dart';
import 'auth_functions.dart';

class TablesInfo1 extends StatefulWidget {
  const TablesInfo1({super.key, String? adminId});

  @override
  State<StatefulWidget> createState() {
    return TablesInfo1State();
  }
}

class TablesInfo1State extends State<TablesInfo1> {
  // List to keep track of the color for each inner container
  List<Color> innerContainerColors = List.generate(6, (index) => Colors.green);

  @override
  void initState() {
    fetchTableStatus();
    super.initState();
  }

  void fetchTableStatus() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('Restaurant')
        .doc('EbspzWo6KoFSgFIAY32l')
        .get();

    if (snapshot.exists) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      Map<String, dynamic>? tableCapacity =
          data['tablescapacity'] as Map<String, dynamic>?;

      if (tableCapacity != null) {
        tableCapacity.forEach((tableNumber, tableData) {
          Map<String, dynamic>? tableStatus =
              tableData?['tablestatus'] as Map<String, dynamic>?;

          if (tableStatus != null && tableStatus['Not Available'] == true) {
            int index = int.tryParse(tableNumber) ?? 0;
            if (index >= 0 && index <= innerContainerColors.length) {
              innerContainerColors[index] = Colors.red;
            }
          }
        });

        setState(() {
          // Update the state to reflect the new colors
          innerContainerColors = innerContainerColors;
        });
      }
    } else {
      print('Table document does not exist.');
    }
  }

  void updateInnerContainerColor(int index, String option) {
    setState(() {
      switch (option) {
        case "Available":
          innerContainerColors[index] = Colors.green;
          break;
        case "Not Available":
          innerContainerColors[index] = Colors.red;
          break;
        default:
          innerContainerColors[index] = Colors.green;
      }
    });
  }

  void updateTableStatus(int index) {
    CollectionReference restaurantCollection =
        FirebaseFirestore.instance.collection('Restaurant');

    Map<String, dynamic> updateData = {
      'tablescapacity.$index.tablestatus': {
        'Not Available': true,
      },
    };
    restaurantCollection
        .doc('EbspzWo6KoFSgFIAY32l')
        .update(updateData)
        .then((value) {
      print('Table status updated successfully!');
    }).catchError((error) {
      print('Failed to update table status: $error');
    });
  }

  void updateTableStatuss(int index) {
    CollectionReference restaurantCollection =
        FirebaseFirestore.instance.collection('Restaurant');

    Map<String, dynamic> updateData = {
      'tablescapacity.$index.tablestatus': {
        'Not Available': false,
      },
    };

    restaurantCollection
        .doc('EbspzWo6KoFSgFIAY32l')
        .update(updateData)
        .then((value) {
      print('Table status updated successfully!');
    }).catchError((error) {
      print('Failed to update table status: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    String? adminId = Provider.of<AdminData>(context).adminId;

    User? admin = FirebaseAuth.instance.currentUser;
    return Scaffold(
      backgroundColor: Colors.white54,
      drawer: Drawer(
          child: Column(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              child: Icon(
                Icons.person,
                size: 40,
                color: Colors.grey,
              ),
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 43, 171, 196),
            ),
            accountName: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Admin')
                  .doc(admin?.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text(
                    'Loading...',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 20,
                    ),
                  );
                }

                var adminData = snapshot.data!.data() as Map<String, dynamic>?;
                String adminName = adminData!['adminname'];

                return Text(
                  adminName,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20,
                  ),
                );
              },
            ),
            accountEmail: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Admin')
                  .doc(admin?.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text(
                    'Loading...',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 16,
                    ),
                  );
                }

                var adminData = snapshot.data!.data() as Map<String, dynamic>?;
                String adminEmail = adminData?['adminemail'];

                return Text(
                  adminEmail,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                  ),
                );
              },
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.settings,
              color: Colors.black,
            ),
            title: const Text("Settings",
                style: TextStyle(color: Colors.black, fontSize: 20)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SettingsPage(adminId: adminId)),
              );
            },
          ),
          const Divider(
            color: Color.fromARGB(255, 0, 0, 0),
            thickness: 0.5,
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.black,
            ),
            title: Text("Logout",
                style: TextStyle(color: Colors.black, fontSize: 20)),
            onTap: () {
              signOutUser(context);
            },
          ),
          const Divider(
            color: Color.fromARGB(255, 0, 0, 0),
            thickness: 0.5,
          ),
          ListTile(
            leading: const Icon(
              Icons.question_mark,
              color: Colors.black,
            ),
            title: const Text("About Us",
                style: TextStyle(color: Colors.black, fontSize: 20)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsPage()),
              );
            },
          ),
          const Divider(
            color: Color.fromARGB(255, 0, 0, 0),
            thickness: 0.5,
          ),
        ],
      )),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Tables Information",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF2babc4),
      ),
      body: GridView.builder(
        itemCount: 6,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 200,
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text('Available'),
                          onTap: () {
                            updateTableStatuss(index);
                            updateInnerContainerColor(index, 'Available');
                            Navigator.pop(context);
                          },
                        ),
                        ListTile(
                          title: const Text('Not Available'),
                          onTap: () {
                            updateTableStatus(index);
                            updateInnerContainerColor(index, 'Not Available');
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 3.0,
                ),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: Text(
                        (index + 1).toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: innerContainerColors[index],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
