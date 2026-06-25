import 'package:flutter/material.dart';
import 'package:flutter_theme_color_check/widget/w_radio.dart';
import 'package:flutter_theme_color_check/widget/w_segment.dart';

class GSwitchs extends StatelessWidget {
  const GSwitchs({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Switch'),
        Container(
          width: 200,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(border: Border.all()),
          child: Column(
            spacing: 8,
            children: [
              // Segment
              WSegment(),

              // Radio
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: WRadio(),
              ),

              // Checkbox
              Container(
                decoration: BoxDecoration(border: Border.all()),
                child: Row(
                  children: [
                    Expanded(child: Checkbox(value: true, onChanged: (val) {})),
                    Expanded(
                      child: Checkbox(value: false, onChanged: (val) {}),
                    ),
                  ],
                ),
              ),

              // Switch
              SizedBox(
                child: Row(
                  children: [
                    Expanded(child: Switch(value: true, onChanged: (value) {})),
                    Expanded(
                      child: Switch(value: false, onChanged: (value) {}),
                    ),
                  ],
                ),
              ),

              // Slider
              SizedBox(
                child: Row(
                  children: [
                    Expanded(
                      child: Slider(
                        value: 5,
                        max: 10,
                        min: 0,
                        onChanged: (value) {},
                      ),
                    ),
                    Expanded(
                      child: Slider(value: 5, max: 10, min: 0, onChanged: null),
                    ),
                  ],
                ),
              ),

              // DropdownMenu
              SizedBox(
                child: Row(
                  children: [
                    Expanded(
                      child: DropdownMenu(
                        initialSelection: "Red",
                        dropdownMenuEntries: [
                          DropdownMenuEntry(value: "Red", label: "Red"),
                          DropdownMenuEntry(value: "Green", label: "Green"),
                          DropdownMenuEntry(value: "Blue", label: "Blue"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
