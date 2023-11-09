import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restuarant/UI/admin1_tabs.dart';
import 'package:restuarant/UI/admin2_tabs.dart';
import 'main.dart';

class AdminBranchPage extends StatefulWidget {
  const AdminBranchPage({Key? key, required this.adminId});

  final String? adminId;

  @override
  State<AdminBranchPage> createState() => _AdminBranchPageState();
}

class _AdminBranchPageState extends State<AdminBranchPage> {
  final RegExp branchnum = RegExp(r'^[0-9]+$');
  String? selectedRestaurant;

  @override
  Widget build(BuildContext context) {
    String? adminId = Provider.of<AdminData>(context).adminId;
    String? userId = Provider.of<UserData>(context).userId;
    GlobalKey<FormState> branch = GlobalKey<FormState>();

    void goToRestaurantChoicePage() {
      var checkfield = branch.currentState;
      if (checkfield!.validate()) {
        checkfield.save();
        if (selectedRestaurant == 'Ward') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MultiProvider(
                providers: [
                  ChangeNotifierProvider<UserData>(create: (_) => UserData()),
                  ChangeNotifierProvider<AdminData>(create: (_) => AdminData()),
                ],
                child: AdminTabs1(adminId: adminId, userId: userId),
              ),
            ),
          );
        } else if (selectedRestaurant == 'Tawaheen') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MultiProvider(
                providers: [
                  ChangeNotifierProvider<UserData>(create: (_) => UserData()),
                  ChangeNotifierProvider<AdminData>(create: (_) => AdminData()),
                ],
                child: AdminTabs2(adminId: adminId, userId: userId),
              ),
            ),
          );
        }
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
              fontWeight: FontWeight.bold,
            ),
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
              key: branch,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/logo/yourtable.PNG',
                        width: 125,
                        height: 125,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(20),
                        child: const Text(
                          'Welcome!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                            top: 10, right: 10, left: 10, bottom: 10),
                        width: 350,
                        child: Container(
                          color: Colors.black,
                          child: DropdownButtonFormField<String>(
                            style: TextStyle(color: Colors.black),
                            value: selectedRestaurant,
                            onChanged: (String? value) {
                              setState(() {
                                selectedRestaurant = value;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please select a restaurant";
                              }
                              return null;
                            },
                            items: const [
                              DropdownMenuItem<String>(
                                value: 'Ward',
                                child: Text(
                                  'Ward Restaurant',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              DropdownMenuItem<String>(
                                value: 'Tawaheen',
                                child: Text(
                                  'Tawaheen AlHawa Restaurant',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                            decoration: const InputDecoration(
                              counterStyle: TextStyle(
                                color: Color.fromARGB(255, 140, 139, 139),
                              ),
                              icon: Icon(
                                Icons.restaurant,
                                color: Colors.white,
                                size: 25,
                              ),
                              labelText: 'Restaurant Name',
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 43, 171, 196),
                                ),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color.fromARGB(255, 142, 10, 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(top: 20, right: 10, left: 10),
                        child: SizedBox(
                          height: 50,
                          width: 150,
                          child: MaterialButton(
                            color: const Color.fromARGB(255, 43, 171, 196),
                            onPressed: () {
                              goToRestaurantChoicePage();
                            },
                            textColor: const Color.fromARGB(255, 0, 0, 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Text(
                              'Go!',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
