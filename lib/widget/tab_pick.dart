import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter_theme_color_check/base/color_scheme.dart';
import 'package:flutter_theme_color_check/notifier/color_notifier.dart';

class TabPick extends HookConsumerWidget {
  const TabPick({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      child: Container(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            spacing: 8,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 8,
                children: [
                  Container(
                    width: 40,
                    alignment: Alignment.center,
                    child: Text('Use'),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text('Light Mode'),
                    ),
                  ),
                  Container(
                    width: 40,
                    alignment: Alignment.center,
                    child: Text('Use'),
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
                  Check(brightness: Brightness.light),
                  Expanded(child: ColorLine(brightness: Brightness.light)),
                  Check(brightness: Brightness.dark),
                  Expanded(child: ColorLine(brightness: Brightness.dark)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Check extends HookConsumerWidget {
  final Brightness brightness;
  const Check({super.key, required this.brightness});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final col = ref.watch(colorProvider);
    final colN = ref.read(colorProvider.notifier);
    final String x = (brightness == Brightness.light) ? 'L' : 'D';

    List<Widget> w = [];
    w.add(Checkbox(value: true, onChanged: null));
    for (String key in Const.ColorSchemeList) {
      String key_u = 'U_${key}_$x';
      w.add(
        Checkbox(
          value: col.list_use[key_u],
          onChanged: (val) {
            colN.set_use(key_u, val!);
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

class ColorLine extends HookConsumerWidget {
  final Brightness brightness;
  const ColorLine({super.key, required this.brightness});

  Widget getRow({
    required String key_c,
    required String name,
    required bool use,
    required Color color,
  }) {
    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name),
              if (use) Text(ColorTools.materialNameAndCode(color)),
            ],
          ),
        ),
        (use)
            ? ColorBox(key_c: key_c, name: name, color: color)
            : SizedBox(height: 40),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final col = ref.watch(colorProvider);
    final colN = ref.read(colorProvider.notifier);
    final String x = (brightness == Brightness.light) ? 'L' : 'D';

    List<Widget> w = [];
    w.add(
      getRow(
        key_c: 'seed_$x',
        name: 'seed',
        use: true,
        color: colN.get_color('seed_$x'),
      ),
    );

    for (String key in Const.ColorSchemeList) {
      String key_c = '${key}_$x';
      String key_u = 'U_${key}_$x';
      w.add(
        getRow(
          key_c: key_c,
          name: key,
          use: col.list_use[key_u],
          color: colN.get_color(key_c),
        ),
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
  final String key_c;
  final String name;
  final Color color;
  const ColorBox({
    super.key,
    required this.key_c,
    required this.name,
    required this.color,
  });

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
          title: Text(name),
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

        colN.set_color(key_c, newColor);
      },
    );
  }
}
