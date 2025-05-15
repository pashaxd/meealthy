import 'package:flutter/material.dart';
import 'package:meealthy/utils/text_styles/text_styles.dart';

class AddingInfoWidget extends StatelessWidget {
  final String title;
  final String description;
  final List<Widget> children;
  AddingInfoWidget({
    super.key,
    required this.title,
    required this.description,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 5,
          children: [
            Text(title, style: TextStyles.defaultStyle),
            Text(description, style: TextStyles.defaultLittleStyle),
            Wrap(spacing: 5, runSpacing: 5, children: children),
          ],
        ),
      ),
    );
  }
}
