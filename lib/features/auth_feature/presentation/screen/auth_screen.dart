import 'package:flutter/material.dart';
import 'package:meealthy/features/auth_feature/presentation/screen/slider.dart';

import '../../../../utils/buttons/buttons.dart';
import '../../../../utils/text_styles/text_styles.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.25,
            ),
            height: MediaQuery.of(context).size.height * 0.8,

            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,

              child: Column(
                children: [
                  Column(
                    spacing: 15,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Meealthy', style: TextStyles.defaultBigGreyStyle),
                      Text(
                        'Welcome to Meealthy — your health assistant',
                        style: TextStyles.defaultStyle,
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.32),
                  DefButton(
                    Button: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.black),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SliderScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Get Started',
                        style: TextStyles.defaultButtonStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void navigation(context) {}
