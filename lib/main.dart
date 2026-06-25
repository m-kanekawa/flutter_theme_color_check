import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_theme_color_check/widget/sc_tab.dart';
import 'package:flutter_theme_color_check/notifier/theme_mode_notifier.dart';
import 'package:flutter_theme_color_check/notifier/color_notifier.dart';

void main() {
  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends HookConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);
    // ignore: unused_local_variable
    final col = ref.watch(colorProvider);
    final colN = ref.read(colorProvider.notifier);

    useEffect(() {
      Future(() async {
        // await colN.resetAllSetting();
        await colN.readAllSetting();
      });
      return null;
    }, []);

    return MaterialApp(
      home: ScTab(),
      theme: colN.themeL,
      darkTheme: colN.themeD,
      themeMode: (theme == Brightness.light) ? ThemeMode.light : ThemeMode.dark,
      debugShowCheckedModeBanner: false,
    );
  }
}
