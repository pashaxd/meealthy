import 'package:flutter/material.dart';

class SliderCard extends StatelessWidget {
  final String text;

  SliderCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          // top: MediaQuery.of(context).size.height * 0,1,
      left: MediaQuery.of(context).size.width * 0.01,
      right: MediaQuery.of(context).size.width * 0.01),
      child: Container(

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),


        child: Center(child: Text(text)),
      ),
    );
  }
}
