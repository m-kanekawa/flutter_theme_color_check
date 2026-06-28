import 'package:flutter/material.dart';

// !!! Warning !!!
// set
//   "editor.formatOnSave": false,"
// in .vscode/settings.json
// when save this file
//
// I really hate dart formatter remove spaces between.
//

class Const {
  static final List<String> ColorSchemeList = [
    'primary',
    'onPrimary',
    'primaryContainer',
    'onPrimaryContainer',
    'primaryFixed',
    'primaryFixedDim',
    'onPrimaryFixed',
    'onPrimaryFixedVariant',
    'secondary',
    'onSecondary',
    'secondaryContainer',
    'onSecondaryContainer',
    'secondaryFixed',
    'secondaryFixedDim',
    'onSecondaryFixed',
    'onSecondaryFixedVariant',
    'tertiary',
    'onTertiary',
    'tertiaryContainer',
    'onTertiaryContainer',
    'tertiaryFixed',
    'tertiaryFixedDim',
    'onTertiaryFixed',
    'onTertiaryFixedVariant',
    'error',
    'onError',
    'errorContainer',
    'onErrorContainer',
    'surface',
    'onSurface',
    'surfaceDim',
    'surfaceBright',
    'surfaceContainerLowest',
    'surfaceContainerLow',
    'surfaceContainer',
    'surfaceContainerHigh',
    'surfaceContainerHighest',
    'onSurfaceVariant',
    'outline',
    'outlineVariant',
    'shadow',
    'scrim',
    'inverseSurface',
    'onInverseSurface',
    'inversePrimary',
    'surfaceTint',
  ];

  static final int ColorSchemeMaxLen = ColorSchemeList.reduce((a, b) {
    return a.length > b.length ? a : b;
  }).length;

  // ----------------------------------------------------------
  // I don't know how to write code below using ColorSchemeList
  // ----------------------------------------------------------
  static Map<String, Color> defineColors(ColorScheme scheme) => {
    'primary'                 : scheme.primary,
    'onPrimary'               : scheme.onPrimary,
    'primaryContainer'        : scheme.primaryContainer,
    'onPrimaryContainer'      : scheme.onPrimaryContainer,
    'primaryFixed'            : scheme.primaryFixed,
    'primaryFixedDim'         : scheme.primaryFixedDim,
    'onPrimaryFixed'          : scheme.onPrimaryFixed,
    'onPrimaryFixedVariant'   : scheme.onPrimaryFixedVariant,
    'secondary'               : scheme.secondary,
    'onSecondary'             : scheme.onSecondary,
    'secondaryContainer'      : scheme.secondaryContainer,
    'onSecondaryContainer'    : scheme.onSecondaryContainer,
    'secondaryFixed'          : scheme.secondaryFixed,
    'secondaryFixedDim'       : scheme.secondaryFixedDim,
    'onSecondaryFixed'        : scheme.onSecondaryFixed,
    'onSecondaryFixedVariant' : scheme.onSecondaryFixedVariant,
    'tertiary'                : scheme.tertiary,
    'onTertiary'              : scheme.onTertiary,
    'tertiaryContainer'       : scheme.tertiaryContainer,
    'onTertiaryContainer'     : scheme.onTertiaryContainer,
    'tertiaryFixed'           : scheme.tertiaryFixed,
    'tertiaryFixedDim'        : scheme.tertiaryFixedDim,
    'onTertiaryFixed'         : scheme.onTertiaryFixed,
    'onTertiaryFixedVariant'  : scheme.onTertiaryFixedVariant,
    'error'                   : scheme.error,
    'onError'                 : scheme.onError,
    'errorContainer'          : scheme.errorContainer,
    'onErrorContainer'        : scheme.onErrorContainer,
    'surface'                 : scheme.surface,
    'onSurface'               : scheme.onSurface,
    'surfaceDim'              : scheme.surfaceDim,
    'surfaceBright'           : scheme.surfaceBright,
    'surfaceContainerLowest'  : scheme.surfaceContainerLowest,
    'surfaceContainerLow'     : scheme.surfaceContainerLow,
    'surfaceContainer'        : scheme.surfaceContainer,
    'surfaceContainerHigh'    : scheme.surfaceContainerHigh,
    'surfaceContainerHighest' : scheme.surfaceContainerHighest,
    'onSurfaceVariant'        : scheme.onSurfaceVariant,
    'outline'                 : scheme.outline,
    'outlineVariant'          : scheme.outlineVariant,
    'shadow'                  : scheme.shadow,
    'scrim'                   : scheme.scrim,
    'inverseSurface'          : scheme.inverseSurface,
    'onInverseSurface'        : scheme.onInverseSurface,
    'inversePrimary'          : scheme.inversePrimary,
    'surfaceTint'             : scheme.surfaceTint,
  };
}
