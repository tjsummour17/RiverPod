import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_app/l10n/lang.dart';
import 'package:riverpod_app/services/hive_database.dart';

class LocaleProvider extends StateNotifier<Locale> {
  LocaleProvider() : super(Locale(HiveDatabase.getLanguage()));

  void setLocale(Locale? locale) {
    if (locale != null) {
      if (!Lang.all.contains(locale)) return;
      HiveDatabase.saveLanguage(locale.languageCode);
      state = locale;
    }
  }

  Locale get locale => state;
}

final localeNotifier =
    StateNotifierProvider<LocaleProvider, Locale>((ref) => LocaleProvider());
