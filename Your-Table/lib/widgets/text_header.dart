import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustemHeaderText extends StatelessWidget {
  CustemHeaderText({
    super.key,
    this.text,
  });
  String? text;

  @override
  Widget build(BuildContext context) {
    var hight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: hight * .02),
      child: Text(
        "$text",
        style: const TextStyle(color: Colors.white54),
      ),
    );
  }
}
