import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_theme_color_check/widget/g_button.dart';
import 'package:flutter_theme_color_check/widget/g_switch.dart';
import 'package:flutter_theme_color_check/widget/g_text.dart';
import 'package:flutter_theme_color_check/widget/g_box.dart';

class TabComponent extends HookConsumerWidget {
  const TabComponent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      child: SafeArea(
        child: Wrap(
          spacing: 8,
          children: [GButtons(), GSwitchs(), GTexts(), GBox()],
        ),
      ),
    );
  }
}
