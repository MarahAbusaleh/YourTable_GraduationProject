import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './login.dart';
import './signup.dart';
import 'main.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key, required String? userId});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  @override
  Widget build(BuildContext context) {
    String? userId = Provider.of<UserData>(context).userId;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            toolbarHeight: 1,
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            bottom: TabBar(
              labelColor: const Color.fromARGB(255, 0, 0, 0),
              indicatorWeight: 2,
              indicatorColor: const Color.fromARGB(255, 43, 171, 196),
              indicator: BoxDecoration(
                  color: const Color.fromARGB(255, 43, 171, 196),
                  borderRadius: BorderRadius.circular(20)),
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelColor: const Color.fromARGB(255, 255, 255, 255),
              tabs: [
                Container(
                  padding: const EdgeInsets.all(8),
                  width: 120,
                  height: 40,
                  child: const Text(
                    'Login',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        //
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  width: 120,
                  height: 40,
                  child: const Text(
                    'Sign Up',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [LogInPage(userId: userId), SignUpPage(userId: userId)],
          ),
        ),
      ),
    );
  }
}
