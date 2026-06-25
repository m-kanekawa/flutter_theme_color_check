import 'package:flutter/material.dart';

enum Something { a, b, c }

class Segment extends StatefulWidget {
  const Segment({super.key});

  @override
  State<Segment> createState() => SegmentState();
}

class SegmentState extends State<Segment> {
  Something value = .a;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Something>(
      segments: const <ButtonSegment<Something>>[
        ButtonSegment<Something>(
          value: Something.a,
          label: Text('A'),
        ),
        ButtonSegment<Something>(
          value: Something.b,
          label: Text('B'),
        ),
        ButtonSegment<Something>(
          value: Something.c,
          label: Text('C'),
        ),
      ],
      selected: <Something>{value},
      onSelectionChanged: (Set<Something> newSelection) {
        setState(() {
          value = newSelection.first;
        });
      },
    );
  }
}
