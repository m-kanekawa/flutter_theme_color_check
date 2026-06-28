import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_theme_color_check/base/color_scheme.dart';
import 'package:flutter_theme_color_check/notifier/color_notifier.dart';

class TabCode extends HookConsumerWidget {
  const TabCode({super.key});

  String get_code(Brightness brightness, var col) {
    final String x = (brightness == Brightness.light) ? 'L' : 'D';
    final String xx = (brightness == Brightness.light) ? 'Light' : 'Dark';

    var color_seed = col.get_color_code('seed_$x');
    String code =
        '''
  // -- theme($xx) --
  static final ThemeData theme$x = ThemeData(
    useMaterial3      : true,
    colorScheme       : colorScheme$x,
  );
  static final ColorScheme colorScheme$x = ColorScheme.fromSeed(
    seedColor         : $color_seed,
    brightness        : Brightness.light,
  )
  .copyWith(
''';

    for (String key in ColorSchemeList) {
      String key_c = '${key}_$x';
      String key_u = 'U_${key}_$x';
      var color = col.get_color_code(key_c);
      if (col.list_use[key_u]) {
        code += '    $key : $color,\n';
      }
    }
    code += '  );\n';
    return code;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final col = ref.watch(colorProvider);
    String code = '''
class MyStyle {
''';

    code += get_code(Brightness.light, col);
    code += '\n';
    code += get_code(Brightness.dark, col);
    code += '}';

    return Material(
      child: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          spacing: 8,
          children: [
            ElevatedButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: code));
                const snackBar = SnackBar(
                  content: Text('Text copied to clipboard.'),
                  // duration: Duration(seconds: 10),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              },
              child: Text('Copy!'),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(border: Border.all()),
                      child: SingleChildScrollView(
                        child: SelectableText(
                          code,
                          style: TextStyle(fontFamily: 'NotoSansMono'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
