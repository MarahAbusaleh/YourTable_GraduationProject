import 'package:flutter/material.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: const Color.fromARGB(255, 43, 171, 196),
          title: const Text(
            'About Us',
            style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          )),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'assets/images/logo/yourtable.PNG',
                width: 150,
                height: 150,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            const Text(
              '''Welcome to Your Table, the ultimate restaurant services application designed to enhance your dining experience. With Your Table, you can effortlessly reserve your desired table at any restaurant of your choice, ensuring a seamless and personalized dining experience. Our user-friendly interface allows you to browse through an extensive list of restaurants, explore their unique ambiance, and select the perfect table that suits your preferences. Additionally, you have the freedom to peruse enticing menus and make your selection in advance, guaranteeing that your favorite dishes will be prepared and ready upon your arrival. With the ability to specify the exact time you wish to reach the restaurant, you can eliminate any waiting time and make the most of your dining experience. Your Table takes the hassle out of restaurant reservations, allowing you to focus on savoring exquisite cuisine and creating lasting memories. Download Your Table today and unlock a world of dining possibilities at your fingertips.''',
              textAlign: TextAlign.justify,
              style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255), fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
