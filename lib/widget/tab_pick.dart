import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter_theme_color_check/notifier/color_notifier.dart';

class TabPick extends HookConsumerWidget {
  const TabPick({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final col = ref.watch(colorProvider);

    return Material(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          spacing: 8,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 8,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text('Light Mode'),
                  ),
                ),
                Container(
                  width: 40,
                  alignment: Alignment.center,
                  child: Text('Same'),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text('Dark Mode'),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 8,
              children: [
                Expanded(child: A(list: col.listL)),
                B(list: col.listSame),
                Expanded(
                  child: A(list: col.listD, listS: col.listSame),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class B extends HookConsumerWidget {
  final Map<String, bool> list;
  const B({super.key, required this.list});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colN = ref.read(colorProvider.notifier);
    List<Widget> w = [];

    for (var key in list.keys) {
      w.add(
        Checkbox(
          value: list[key],
          onChanged: (val) {
            colN.set_same(key, val!);
          },
        ),
      );
    }
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(spacing: 8, children: w),
    );
  }
}

class A extends HookConsumerWidget {
  final List<String> list;
  final Map<String, bool>? listS;
  const A({super.key, required this.list, this.listS});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colN = ref.read(colorProvider.notifier);
    List<Widget> w = [];

    for (var key in list) {
      Color color = colN.get_color(key);
      w.add(
        ((listS == null) || ((listS != null) && listS![key] == false))
            ? Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(key),
                        Text('${ColorTools.materialNameAndCode(color)} '),
                      ],
                    ),
                  ),
                  ColorBox(name: key, color: color),
                ],
              )
            : SizedBox(height: 40),
      );
    }
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(border: Border.all()),
      child: Column(spacing: 8, children: w),
    );
  }
}

class ColorBox extends HookConsumerWidget {
  final String name;
  final Color color;
  const ColorBox({super.key, required this.name, required this.color});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colN = ref.read(colorProvider.notifier);

    return ColorIndicator(
      width: 40,
      height: 40,
      borderRadius: 0,
      color: color,
      elevation: 1,
      onSelectFocus: false,
      onSelect: () async {
        final Color newColor = await showColorPickerDialog(
          context,
          color,
          title: const Text('ColorPicker with very long title'),
          width: 40,
          height: 40,
          spacing: 0,
          runSpacing: 0,
          borderRadius: 0,
          wheelDiameter: 165,
          enableOpacity: true,
          showColorCode: true,
          colorCodeHasColor: true,
          pickersEnabled: <ColorPickerType, bool>{ColorPickerType.wheel: true},
          copyPasteBehavior: const ColorPickerCopyPasteBehavior(
            copyButton: true,
            pasteButton: true,
            longPressMenu: true,
          ),
          actionButtons: ColorPickerActionButtons(
            dialogActionButtons: true,
            okButton: true,
            dialogOkButtonType: ColorPickerActionButtonType.elevated,
            dialogOkButtonStyle: TextButton.styleFrom(
              foregroundColor: Colors.yellow,
              backgroundColor: Colors.red,
            ),
            closeButton: true,
            dialogCancelButtonType: ColorPickerActionButtonType.outlined,

            dialogCancelButtonStyle: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green,
              elevation: 0,
            ),
          ),

          transitionBuilder:
              (
                BuildContext context,
                Animation<double> a1,
                Animation<double> a2,
                Widget widget,
              ) {
                final double curvedValue =
                    Curves.easeInOutBack.transform(a1.value) - 1.0;
                return Transform(
                  transform: Matrix4.translationValues(
                    0.0,
                    curvedValue * 200,
                    0.0,
                  ),
                  child: Opacity(opacity: a1.value, child: widget),
                );
              },
          transitionDuration: const Duration(milliseconds: 400),
          constraints: const BoxConstraints(
            minHeight: 480,
            minWidth: 550,
            maxWidth: 550,
          ),
        );

        colN.set_color(name, newColor);
      },
    );
  }
}
