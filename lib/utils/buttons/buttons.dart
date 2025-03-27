import 'package:flutter/material.dart';
import 'package:meealthy/utils/text_styles/text_styles.dart';


class DefButton extends StatelessWidget {
  final String text;
  final Function function;
  DefButton({super.key, required this.text, required this.function});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.9,
      height: MediaQuery.of(context).size.height*0.07,
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.black),
          ),
          onPressed: () {},
          child: Text(text,style: TextStyles.defaultButtonStyle),
      ),
    );
  }
}
