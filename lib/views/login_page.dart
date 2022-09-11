import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/l10n/lang.dart';
import 'package:riverpod_app/providers/locale_provider.dart';
import 'package:riverpod_app/providers/theme_provider.dart';
import 'package:riverpod_app/utils/build_context_x.dart';
import 'package:riverpod_app/views/helpers/responsive_helper.dart';
import 'package:riverpod_app/views/widgets/login_card.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  static String routeName = '/login';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LocaleProvider localeProvider = ref.read(localeNotifier.notifier);
    ThemeProvider themeProvider = ref.read(themeNotifier.notifier);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          const SizedBox(width: 5),
          IntrinsicWidth(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: DropdownButtonFormField<Locale>(
                borderRadius: BorderRadius.circular(15),
                hint: Text(context.appLocalizations.language),
                items: [
                  for (Locale locale in Lang.all)
                    DropdownMenuItem(
                      value: locale,
                      child: Text(
                        Lang.getLangName(locale.languageCode),
                      ),
                    ),
                ],
                onChanged: localeProvider.setLocale,
              ),
            ),
          ),
          IntrinsicWidth(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: DropdownButtonFormField<ThemeMode>(
                borderRadius: BorderRadius.circular(15),
                hint: Text(context.appLocalizations.theme),
                items: [
                  for (ThemeMode theme in ThemeMode.values)
                    DropdownMenuItem(
                      value: theme,
                      child: Text(theme.toLocalizedString(context)),
                    ),
                ],
                onChanged: themeProvider.setThemeMode,
              ),
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
      body: SingleChildScrollView(
        child: ResponsiveWidget(
          desktop: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.appLocalizations.appName,
                        style: TextStyle(
                          fontSize: 64,
                          color: context.theme.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        context.appLocalizations.appDescription,
                        style: const TextStyle(fontSize: 28),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    const SizedBox(height: 150),
                    LoginCard(),
                    const SizedBox(height: 25),
                  ],
                ),
              ],
            ),
          ),
          mobile: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      context.appLocalizations.appName,
                      style: const TextStyle(
                        fontSize: 60,
                        color: Color(0xff1877F2),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      context.appLocalizations.appDescription,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 40),
                    LoginCard(),
                    const SizedBox(height: 30),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
