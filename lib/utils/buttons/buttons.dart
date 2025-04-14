import 'package:flutter/material.dart';
import 'package:meealthy/utils/text_styles/text_styles.dart';


class DefButton extends StatelessWidget {
  Widget Button;
  DefButton({super.key, required this.Button});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.9,
      height: MediaQuery.of(context).size.height*0.07,
      child: Button,
    );
  }
}
