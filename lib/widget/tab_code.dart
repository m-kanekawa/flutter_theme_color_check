import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter_theme_color_check/notifier/color_notifier.dart';

class TabCode extends HookConsumerWidget {
  const TabCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final col = ref.watch(colorProvider);

    final String code =
        '''
static final Color  COLOR_SEED_L              = ${col.get_color_code('COLOR_SEED_L')};
static final Color? COLOR_PRIMARY_L           = ${col.get_color_code('COLOR_PRIMARY_L')};
static final Color? COLOR_SECONDARY_L         = ${col.get_color_code('COLOR_SECONDARY_L')};
static final Color? COLOR_TERTIARY_L          = ${col.get_color_code('COLOR_TERTIARY_L')};
static final Color? COLOR_SURFACE_L           = ${col.get_color_code('COLOR_SURFACE_L')};
static final Color? COLOR_SURFACE_BRIGHT_L    = ${col.get_color_code('COLOR_SURFACE_BRIGHT_L')};
static final Color? COLOR_ONSURFACE_L         = ${col.get_color_code('COLOR_ONSURFACE_L')};
static final Color? COLOR_PRIMARY_CONTAINER_L = ${col.get_color_code('COLOR_PRIMARY_CONTAINER_L')};
static final Color? COLOR_ERROR_L             = ${col.get_color_code('COLOR_ERROR_L')};

static final Color  COLOR_SEED_D              = ${col.get_color_code('COLOR_SEED_D')};
static final Color? COLOR_PRIMARY_D           = ${col.get_color_code('COLOR_PRIMARY_D')};
static final Color? COLOR_SECONDARY_D         = ${col.get_color_code('COLOR_SECONDARY_D')};
static final Color? COLOR_TERTIARY_D          = ${col.get_color_code('COLOR_TERTIARY_D')};
static final Color? COLOR_SURFACE_D           = ${col.get_color_code('COLOR_SURFACE_D')};
static final Color? COLOR_SURFACE_BRIGHT_D    = ${col.get_color_code('COLOR_SURFACE_BRIGHT_D')};
static final Color? COLOR_ONSURFACE_D         = ${col.get_color_code('COLOR_ONSURFACE_D')};
static final Color? COLOR_PRIMARY_CONTAINER_D = ${col.get_color_code('COLOR_PRIMARY_CONTAINER_D')};
static final Color? COLOR_ERROR_D             = ${col.get_color_code('COLOR_ERROR_D')};

// -- theme(Light) --
static final themeL = ThemeData(
  useMaterial3      : true,
  colorScheme       : colorSchemeL,
);

static final colorSchemeL = ColorScheme.fromSeed(
  seedColor         : COLOR_SEED_L,
  brightness        : Brightness.light,
)
.copyWith( 
  primary           : COLOR_PRIMARY_L,
  secondary         : COLOR_SECONDARY_L,
  tertiary          : COLOR_TERTIARY_L,
  primaryContainer  : COLOR_PRIMARY_CONTAINER_L,
  surface           : COLOR_SURFACE_L,
  surfaceBright     : COLOR_SURFACE_BRIGHT_L,
  onSurface         : COLOR_ONSURFACE_L,
  error             : COLOR_ERROR_L,
);

// -- theme(Dark) --
static final themeD = ThemeData(
  useMaterial3      : true,
  colorScheme       : colorSchemeD,
);
static final colorSchemeD = ColorScheme.fromSeed(
  seedColor         : COLOR_SEED_D,
  brightness        : Brightness.dark,
)
.copyWith( 
  primary           : COLOR_PRIMARY_D,
  secondary         : COLOR_SECONDARY_D,
  tertiary          : COLOR_TERTIARY_D,
  primaryContainer  : COLOR_PRIMARY_CONTAINER_D,
  onPrimary         : COLOR_ONSURFACE_D,
  surface           : COLOR_SURFACE_D,
  surfaceBright     : COLOR_SURFACE_BRIGHT_D,
  onSurface         : COLOR_ONSURFACE_D,
  error             : COLOR_ERROR_D,
);
''';

    return Material(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Row(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(border: Border.all()),
                child: GestureDetector(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: code));
                    const snackBar = SnackBar(
                      content: Text('Text copied to clipboard.'),
                      // duration: Duration(seconds: 10),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: Text(
                    code,
                    style: TextStyle(fontFamily: 'NotoSansMono'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
