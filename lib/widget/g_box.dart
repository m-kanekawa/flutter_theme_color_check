import 'package:flutter/material.dart';
import 'package:flutter_theme_color_check/widget/w_alert.dart';
import 'package:flutter_theme_color_check/widget/w_card.dart';
import 'package:flutter_theme_color_check/widget/w_timepicker.dart';

class GBox extends StatelessWidget {
  const GBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Box'),
        Container(
          width: 300,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(border: Border.all()),
          child: Column(
            spacing: 8,
            children: [
              WAlert(),
              WTimePicker(),
              const Divider(height: 20, thickness: 5, indent: 20, endIndent: 0),
              WCard(),
            ],
          ),
        ),
      ],
    );
  }
}
