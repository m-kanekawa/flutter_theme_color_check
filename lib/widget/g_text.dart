import 'package:flutter/material.dart';

class Texts extends StatelessWidget {
  const Texts({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Text'),
        Container(
          width: 180,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(border: Border.all()),
          child: Column(
            spacing: 8,
            children: [
              // TextField
              SizedBox(
                width: 250,
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
