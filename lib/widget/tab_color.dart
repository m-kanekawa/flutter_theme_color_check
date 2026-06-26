import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_theme_color_check/notifier/color_notifier.dart';

class TabColor extends HookConsumerWidget {
  const TabColor({super.key});

  final swatchWidth = 40.0;
  final swatchHeight = 30.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ignore: unused_local_variable
    final col = ref.watch(colorProvider);
    final colN = ref.read(colorProvider.notifier);
    final schemeL = colN.schemeL;
    final schemeD = colN.schemeD;
    final colorsL = _defineColors(schemeL);
    final colorsD = _defineColors(schemeD);
    final colorEntriesL = colorsL.entries.toList();
    final colorEntriesD = colorsD.entries.toList();

    return Material(
      child: Row(
        children: [
          _renderScheme(colorEntriesL, schemeL),
          _renderScheme(colorEntriesD, schemeD),
        ],
      ),
    );
  }

  Widget _renderScheme(
    List<MapEntry<String, Color>> colorEntries,
    ColorScheme scheme,
  ) {
    final halfLength = (colorEntries.length / 2).ceil();

    return Expanded(
      child: Container(
        padding: EdgeInsets.all(8),
        color: scheme.surface,
        child: Column(
          children: [
            for (int i = 0; i < halfLength; i++) ...{
              _renderColumn(colorEntries.sublist(i * 2, i * 2 + 2), scheme),
            },
          ],
        ),
      ),
    );
  }

  Widget _renderColumn(
    List<MapEntry<String, Color>> colorEntries,
    ColorScheme scheme,
  ) {
    final textStyle = TextStyle(fontSize: 12, color: scheme.onSurface);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: colorEntries.map((entry) {
        var colorName = entry.key;
        var colorHex = entry.value
            .toARGB32()
            .toRadixString(16)
            .padLeft(8, '0')
            .toUpperCase();

        return Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: swatchWidth,
                height: swatchHeight,
                color: entry.value,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText(
                    colorName,
                    style: textStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  SelectableText(colorHex, style: textStyle),
                ],
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Map<String, Color> _defineColors(ColorScheme scheme) => {
    'primary': scheme.primary,
    'onPrimary': scheme.onPrimary,
    'primaryContainer': scheme.primaryContainer,
    'onPrimaryContainer': scheme.onPrimaryContainer,
    'primaryFixed': scheme.primaryFixed,
    'primaryFixedDim': scheme.primaryFixedDim,
    'onPrimaryFixed': scheme.onPrimaryFixed,
    'onPrimaryFixedVariant': scheme.onPrimaryFixedVariant,
    'secondary': scheme.secondary,
    'onSecondary': scheme.onSecondary,
    'secondaryContainer': scheme.secondaryContainer,
    'onSecondaryContainer': scheme.onSecondaryContainer,
    'secondaryFixed': scheme.secondaryFixed,
    'secondaryFixedDim': scheme.secondaryFixedDim,
    'onSecondaryFixed': scheme.onSecondaryFixed,
    'onSecondaryFixedVariant': scheme.onSecondaryFixedVariant,
    'tertiary': scheme.tertiary,
    'onTertiary': scheme.onTertiary,
    'tertiaryContainer': scheme.tertiaryContainer,
    'onTertiaryContainer': scheme.onTertiaryContainer,
    'tertiaryFixed': scheme.tertiaryFixed,
    'tertiaryFixedDim': scheme.tertiaryFixedDim,
    'onTertiaryFixed': scheme.onTertiaryFixed,
    'onTertiaryFixedVariant': scheme.onTertiaryFixedVariant,
    'error': scheme.error,
    'onError': scheme.onError,
    'errorContainer': scheme.errorContainer,
    'onErrorContainer': scheme.onErrorContainer,
    'surface': scheme.surface,
    'onSurface': scheme.onSurface,
    'surfaceDim': scheme.surfaceDim,
    'surfaceBright': scheme.surfaceBright,
    'surfaceContainerLowest': scheme.surfaceContainerLowest,
    'surfaceContainerLow': scheme.surfaceContainerLow,
    'surfaceContainer': scheme.surfaceContainer,
    'surfaceContainerHigh': scheme.surfaceContainerHigh,
    'surfaceContainerHighest': scheme.surfaceContainerHighest,
    'onSurfaceVariant': scheme.onSurfaceVariant,
    'outline': scheme.outline,
    'outlineVariant': scheme.outlineVariant,
    'shadow': scheme.shadow,
    'scrim': scheme.scrim,
    'inverseSurface': scheme.inverseSurface,
    'onInverseSurface': scheme.onInverseSurface,
    'inversePrimary': scheme.inversePrimary,
    'surfaceTint': scheme.surfaceTint,
  };
}
