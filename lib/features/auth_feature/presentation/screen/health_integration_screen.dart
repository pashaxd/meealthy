import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:meealthy/core/presentation/bottom_navigation/bottom_navigation.dart';
import 'package:meealthy/utils/text_styles/text_styles.dart';
import '../../../health_feature/screen/health_screen.dart';

class HealthIntegrationScreen extends StatelessWidget {
  HealthIntegrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      // appBar: AppBar(
      //   backgroundColor:  Colors.grey[300],
      //   automaticallyImplyLeading: false,
      //   title: Text('Conjugation with Apple health',style: T),
      // ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/pngs/apple_health_integration.png',
                      height: 300,
                      width: 500,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Pair with Apple Watch to get data from Apple Health',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  onPressed: () => Get.offAll(() => BottomNavigation()),
                  child: Text(
                    'Perform conjugation',
                    style: TextStyles.defaultButtonStyle
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 