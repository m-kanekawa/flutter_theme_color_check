import 'package:flutter/material.dart';

class WTimePicker extends StatelessWidget {
  WTimePicker({super.key});

  MaterialTapTargetSize tapTargetSize = .padded;
  bool use24HourTime = false;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      child: const Text('Open time picker'),
      onPressed: () async {
        showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
          initialEntryMode: TimePickerEntryMode.dial,
          orientation: Orientation.portrait,
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: Theme.of(
                context,
              ).copyWith(materialTapTargetSize: tapTargetSize),
              child: Directionality(
                textDirection: TextDirection.ltr,
                child: MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(alwaysUse24HourFormat: use24HourTime),
                  child: child!,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
