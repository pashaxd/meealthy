import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:meealthy/features/auth_feature/widgets/main_text.dart';
import 'package:meealthy/utils/buttons/buttons.dart';

import 'package:meealthy/utils/text_styles/text_styles.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.2,

            ),
            height: MediaQuery.of(context).size.height * 0.8,

            child: CarouselSlider(
              items:
                  [MainText(), MainText(), MainText()].map((item) {
                    return Builder(
                      builder: (BuildContext context) {
                        return
                           Container(

                            child: item,
                          );
                      },
                    );
                  }).toList(),
              options: CarouselOptions(
                height: MediaQuery.of(context).size.height * 0.8,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
