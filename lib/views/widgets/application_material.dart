import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:riverpod_app/l10n/lang.dart';
import 'package:riverpod_app/models/user.dart';
import 'package:riverpod_app/providers/current_user_provider.dart';
import 'package:riverpod_app/providers/locale_provider.dart';
import 'package:riverpod_app/providers/theme_provider.dart';
import 'package:riverpod_app/views/create_account_page.dart';
import 'package:riverpod_app/views/login_page.dart';
import 'package:riverpod_app/views/main_page.dart';

class ApplicationMaterial extends ConsumerWidget {
  const ApplicationMaterial({Key? key}) : super(key: key);

  final Color _lightFieldColor = const Color(0xFFF3F3F3);
  final Color _darkFieldColor = const Color(0xFF525252);
  final ColorScheme _lightColorScheme = const ColorScheme.light(
    primary: Color(0xFF50BBEE),
    primaryContainer: Color(0xFF00bbff),
    background: Color(0xFFF2F2F2),
    surface: Colors.white,
    error: Color(0xFFFF0000),
    errorContainer: Color(0xFFFF2211),
    inversePrimary: Color(0xFFb74b1f),
    inverseSurface: Color(0xFF000000),
    onSurface: Color(0xFF232323),
    onBackground: Colors.black,
  );
  final ColorScheme _darkColorScheme = const ColorScheme.dark(
    primary: Color(0xFF50BBEE),
    primaryContainer: Color(0xFF00bbff),
    background: Color(0xFF3D3F41),
    surface: Color(0xFF323436),
    error: Color(0xFFFF0000),
    errorContainer: Color(0xFFFF2211),
    inversePrimary: Color(0xFFb74b1f),
    inverseSurface: Color(0xFF000000),
    onSurface: Colors.white,
    onBackground: Colors.black,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Locale locale = ref.watch(localeNotifier);
    ThemeMode themeMode = ref.watch(themeNotifier);
    User? currentUser = ref.watch(userNotifier);
    return MaterialApp(
      title: 'RiverPod',
      supportedLocales: Lang.all,
      locale: locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      themeMode: themeMode,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: _lightColorScheme.background,
        shadowColor: const Color(0xAA626262),
        colorScheme: _lightColorScheme,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: _lightFieldColor,
          suffixStyle: TextStyle(color: _lightColorScheme.onSurface),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(7)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(7)),
            borderSide: BorderSide(color: _lightColorScheme.error),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(7)),
            borderSide: BorderSide(color: _lightColorScheme.error),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(7)),
            borderSide: BorderSide(color: _lightColorScheme.primary),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(7)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(7)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            color: _lightColorScheme.primary,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.2,
          ),
          titleSmall: TextStyle(
            color: _lightColorScheme.onSurface,
            fontSize: 16,
          ),
        ),
      ),
      darkTheme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: _darkColorScheme.background,
        colorScheme: _darkColorScheme,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: _darkFieldColor,
          suffixStyle: TextStyle(color: _darkColorScheme.onSurface),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(7)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(7)),
            borderSide: BorderSide(color: _darkColorScheme.error),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(7)),
            borderSide: BorderSide(color: _darkColorScheme.error),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(7)),
            borderSide: BorderSide(color: _darkColorScheme.primary),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(7)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(7)),
            borderSide: BorderSide(color: Colors.transparent),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(
            color: _darkColorScheme.primary,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            letterSpacing: -1.2,
          ),
          titleSmall: TextStyle(
            color: _darkColorScheme.onSurface,
            fontSize: 16,
          ),
        ),
      ),
      routes: {
        CreateAccountPage.routeName: (context) => const CreateAccountPage(),
        MainPage.routeName: (context) => const MainPage(),
        LoginPage.routeName: (context) => const LoginPage(),
      },
      home: currentUser == null ? const LoginPage() : const MainPage(),
    );
  }
}
