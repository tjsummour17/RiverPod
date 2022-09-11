import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/services/hive_database.dart';
import 'package:riverpod_app/utils/build_context_x.dart';

class ThemeProvider extends StateNotifier<ThemeMode> {
  ThemeProvider() : super(themeFromName(HiveDatabase.getTheme()));

  static ThemeMode themeFromName(String name) {
    if (name == 'light') {
      return ThemeMode.light;
    } else if (name == 'dark') {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  void setThemeMode(ThemeMode? mode) {
    if (mode != null) {
      state = mode;
      switch (mode) {
        case ThemeMode.light:
          HiveDatabase.saveTheme('light');
          break;
        case ThemeMode.dark:
          HiveDatabase.saveTheme('dark');
          break;
        default:
          HiveDatabase.saveTheme('system');
          break;
      }
    }
  }

  ThemeMode get themeMode => state;
}

extension ThemeModeX on ThemeMode {
  String toLocalizedString(BuildContext context) {
    switch (this) {
      case ThemeMode.system:
        return context.appLocalizations.system;
      case ThemeMode.dark:
        return context.appLocalizations.dark;
      case ThemeMode.light:
        return context.appLocalizations.light;
    }
  }
}

final themeNotifier =
    StateNotifierProvider<ThemeProvider, ThemeMode>((ref) => ThemeProvider());
