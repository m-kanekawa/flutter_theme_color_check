import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_theme_color_check/notifier/theme_mode_notifier.dart';

class WRadio extends HookConsumerWidget {
  const WRadio({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(themeModeProvider);
    final modeN = ref.read(themeModeProvider.notifier);

    return RadioGroup<Brightness>(
      groupValue: mode,
      onChanged: (Brightness? value) {
        modeN.select(value!);
      },
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Text('light'),
                Radio<Brightness>(value: Brightness.light),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Text('dark'),
                Radio<Brightness>(value: Brightness.dark),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
