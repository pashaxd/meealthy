import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meealthy/utils/buttons/buttons.dart';
import 'package:meealthy/utils/text_styles/text_styles.dart';

import '../widgets/scroll_point.dart';
import '../widgets/slider_card.dart';

class SliderScreen extends StatelessWidget {
  SliderScreen({super.key});

  final card = 1.obs;
  final CarouselSliderController carouselController = CarouselSliderController();
  final List<String> cardTexts = [
    'First Card',
    'Second Card',
    'Third Card',
    'Fourth Card',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.04),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  carouselController.jumpToPage(cardTexts.length - 1);
                },
                child: Text('Skip', style: TextStyles.defaultLittleStyle),
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent), // Убирает фон при нажатии
                ),
              ),
            ],
          ),
          CarouselSlider(
            items:
                cardTexts.map((text) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(child: SliderCard(text: text));
                    },
                  );
                }).toList(),
            carouselController: carouselController,
            options: CarouselOptions(

              height: MediaQuery.of(context).size.height * 0.73,
              viewportFraction: 0.9,
              enlargeCenterPage: true,
              enlargeFactor: 0.15,
              enableInfiniteScroll: false,
              onPageChanged: (index, reason) {
                card.value =  index + 1; // Update the observable
              },
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(cardTexts.length, (index) {
                return Obx(
                  () => // Wrap only the ScrollPoint in Obx
                      ScrollPoint(index: card.value, requiredIndex: index + 1),
                );
              }),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Obx(
            () => AnimatedContainer(
              width:
                  card.value == 4
                      ? MediaQuery.of(context).size.width * 0.8
                      : MediaQuery.of(context).size.width * 0.31,
              duration: Duration(milliseconds: 500),

              child:
                  card.value == 4
                      ? DefButton(
                        Button: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.black,
                            ),
                          ),
                          onPressed: () {
                            // Add your onPressed logic here
                          },
                          child: Text(
                            'Okay! Start',
                            style: TextStyles.defaultButtonStyle,
                          ),
                        ),
                      )
                      : Container(),
            ),
          ),
        ],
      ),
    );
  }
}
