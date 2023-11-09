import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomSearch extends StatelessWidget {
  String? text;
  double? fontsize;

  CustomSearch({
    this.text,
    super.key,
    this.fontsize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .07,
      width: MediaQuery.of(context).size.width * .88,
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(5),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
                width: 1, color: Colors.white, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(5),
          ),
          prefixIcon: const Icon(
            Icons.search,
            size: 18,
            color: Colors.white,
          ),
          hintText: text,
          hintStyle: TextStyle(color: Colors.white, fontSize: fontsize),
        ),
        keyboardType: TextInputType.text,
      ),
    );
  }
}
