import 'package:flutter/material.dart';

class CustomRate extends StatefulWidget {
  const CustomRate({
    super.key,
  });

  @override
  State<CustomRate> createState() => _CustomRateState();
}

class _CustomRateState extends State<CustomRate> {
  int x = 0;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var hight = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * .7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                x = 1;
              });
            },
            icon: Icon(
              Icons.star,
              size: 40,
              color: x >= 1
                  ? const Color.fromARGB(255, 43, 171, 196)
                  : Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                x = 2;
              });
            },
            icon: Icon(
              Icons.star,
              size: 40,
              color: x >= 2
                  ? const Color.fromARGB(255, 43, 171, 196)
                  : Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                x = 3;
              });
            },
            icon: Icon(
              Icons.star,
              size: 40,
              color: x >= 3
                  ? const Color.fromARGB(255, 43, 171, 196)
                  : Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                x = 4;
              });
            },
            icon: Icon(
              Icons.star,
              size: 40,
              color: x >= 4
                  ? const Color.fromARGB(255, 43, 171, 196)
                  : Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                x = 5;
              });
            },
            icon: Icon(
              Icons.star,
              size: 40,
              color: x >= 5
                  ? const Color.fromARGB(255, 43, 171, 196)
                  : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
