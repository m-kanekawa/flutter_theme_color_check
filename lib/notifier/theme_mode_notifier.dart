import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeModeProvider = NotifierProvider<ThemeModeNotifier, Brightness>(
  ThemeModeNotifier.new,
);

class ThemeModeNotifier extends Notifier<Brightness> {
  @override
  Brightness build() {
    return Brightness.light;
  }

  void select(Brightness val) {
    state = val;
  }
}
