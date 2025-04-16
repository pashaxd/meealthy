import 'package:flutter/material.dart';
import 'package:meealthy/features/auth_feature/presentation/widgets/slider_card.dart';
import 'package:meealthy/utils/text_styles/text_styles.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          TextButton(onPressed: () {}, child: Text('')),
          SliderCard(
            text: 'Please login to the app to start using all features',

          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.015),

          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.width * 0.9,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.07,
                  width: MediaQuery.of(context).size.width*0.4,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.grey[300]),
                    ),
                    child: Text(
                      'With Apple',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.07,
                  width: MediaQuery.of(context).size.width*0.4,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.grey[300]),
                    ),
                    onPressed: () {},
                    child: Text(
                      'With Google',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
