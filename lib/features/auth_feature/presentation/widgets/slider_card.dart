import 'package:flutter/material.dart';
import 'package:meealthy/utils/text_styles/text_styles.dart';

class SliderCard extends StatelessWidget {
  final String text;


  SliderCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        // top: MediaQuery.of(context).size.height * 0,1,
        left: MediaQuery.of(context).size.width * 0.01,
        right: MediaQuery.of(context).size.width * 0.01,
      ),
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.73,
          width: MediaQuery.of(context).size.width * 0.9,

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),

          child: Center(
            child: Padding(
              padding:EdgeInsets.all(MediaQuery.of(context).size.width*0.1),
              child: Text(
                text,
                style:
                    TextStyles.defaultStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
