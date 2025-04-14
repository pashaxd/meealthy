import 'package:flutter/material.dart';

class ScrollPoint extends StatelessWidget {
  final index;
  final int requiredIndex;

  ScrollPoint({super.key, required this.index, required this.requiredIndex});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: MediaQuery.of(context).size.height * 0.01,
      width:
          index == requiredIndex
              ? MediaQuery.of(context).size.width * 0.13
              : MediaQuery.of(context).size.width * 0.03,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: index == requiredIndex ? Colors.black : Colors.grey,
      ),
      duration: Duration(milliseconds: 350),
    );
  }
}
