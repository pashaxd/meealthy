import 'package:flutter/material.dart';

import '../../../utils/buttons/buttons.dart';
import '../../../utils/text_styles/text_styles.dart';

class MainText extends StatelessWidget {
  MainText ({super.key});

  @override
  Widget build(BuildContext context) {
    return
   SizedBox(

     width: MediaQuery.of(context).size.width*0.9,

     child: Column(
        children: [
            Column(
              spacing: 15,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Meealthy', style: TextStyles.defaultBigGreyStyle),
                Text(
                    ' Welcome to Meealthy — your health assistant',
                    style: TextStyles.defaultStyle,
                  ),
                ],
               ),
                 SizedBox(height: MediaQuery.of(context).size.height * 0.29),
                 DefButton(text: 'Get Started', function: () {}),
              ],

      ),
   );
     }
}
