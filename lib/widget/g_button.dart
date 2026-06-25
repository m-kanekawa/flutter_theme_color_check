import 'package:flutter/material.dart';

class GButtons extends StatelessWidget {
  const GButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Button'),
        Container(
          width: 180,
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(border: Border.all()),
          child: Column(
            spacing: 8,
            children: [
              TextButton(onPressed: () {}, child: const Text("TextButton")),
              OutlinedButton(
                onPressed: () {},
                child: const Text("OutlinedButton"),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("ElevatedButton"),
              ),
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: IconButton(onPressed: () {}, icon: Icon(Icons.star)),
                  ),
                  Expanded(
                    child: IconButton.filled(
                      onPressed: () {},
                      icon: Icon(Icons.star),
                    ),
                  ),
                  Expanded(
                    child: IconButton.outlined(
                      onPressed: () {},
                      icon: Icon(Icons.star),
                    ),
                  ),
                ],
              ),
              FloatingActionButton.small(
                onPressed: () {},
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
