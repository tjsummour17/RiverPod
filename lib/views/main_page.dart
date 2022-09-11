import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/l10n/lang.dart';
import 'package:riverpod_app/models/user.dart';
import 'package:riverpod_app/providers/current_user_provider.dart';
import 'package:riverpod_app/providers/locale_provider.dart';
import 'package:riverpod_app/providers/theme_provider.dart';
import 'package:riverpod_app/utils/build_context_x.dart';
import 'package:riverpod_app/viewmodels/favorite_view_model.dart';
import 'package:riverpod_app/viewmodels/home_view_model.dart';
import 'package:riverpod_app/views/favorites_page.dart';
import 'package:riverpod_app/views/helpers/responsive_helper.dart';
import 'package:riverpod_app/views/login_page.dart';
import 'package:riverpod_app/views/widgets/university_card.dart';

class MainPage extends ConsumerWidget {
  MainPage({Key? key}) : super(key: key);

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    LocaleProvider localeProvider = ref.watch(localeNotifier.notifier);
    Locale locale = ref.watch(localeNotifier);
    ThemeProvider themeProvider = ref.watch(themeNotifier.notifier);
    ThemeMode themeMode = ref.watch(themeNotifier);
    User user =
        ref.watch(userNotifier) ?? const User(name: '', email: '', phone: '');

    CurrentUserProvider userProvider = ref.watch(userNotifier.notifier);

    FavoriteViewModel favoriteViewModel = ref.read(favoriteNotifier.notifier);

    HomeViewModel homeViewModel = ref.read(universitiesNotifier.notifier);

    final universities = ref.watch(universitiesNotifier);

    Widget _buildUniversityList(BuildContext context, int index) =>
        universities != null
            ? UniversityCard(university: universities[index])
            : const SizedBox();

    Widget _buildDrawerWidget() => ListView(
          children: [
            ListTile(
              leading: const Icon(
                Icons.account_circle_rounded,
                size: 35,
              ),
              title: Text(user.name),
              subtitle: Text(user.email),
            ),
            ListTile(
              leading: const Icon(
                Icons.language,
                size: 35,
              ),
              title: Text(context.appLocalizations.language),
              subtitle: Text(Lang.getLangName(locale.languageCode)),
              onTap: () {
                showDialog<void>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(context.appLocalizations.language),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (Locale locale in Lang.all)
                          ListTile(
                            title: Text(
                              Lang.getLangName(locale.languageCode),
                            ),
                            onTap: () {
                              localeProvider.setLocale(locale);
                              Navigator.pop(context);
                            },
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.brightness_4,
                size: 35,
              ),
              title: Text(context.appLocalizations.theme),
              subtitle: Text(themeMode.toLocalizedString(context)),
              onTap: () {
                showDialog<void>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(context.appLocalizations.theme),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        for (ThemeMode themeMode in ThemeMode.values)
                          ListTile(
                            title: Text(
                              themeMode.toLocalizedString(context),
                            ),
                            onTap: () {
                              themeProvider.setThemeMode(themeMode);
                              Navigator.pop(context);
                            },
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.favorite,
                size: 35,
              ),
              title: Text(context.appLocalizations.favorite),
              trailing: const Icon(Icons.navigate_next_outlined),
              onTap: () {
                favoriteViewModel.fetchFavorites(user.id);
                Navigator.pushNamed(context, FavoritePage.routeName);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.logout,
                size: 35,
              ),
              title: Text(context.appLocalizations.logout),
              onTap: () {
                userProvider.logout();
                Navigator.pushReplacementNamed(context, LoginPage.routeName);
              },
            ),
          ],
        );

    Widget _buildCountryItem({
      required String countryName,
      required Color color,
    }) =>
        InkWell(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: color.withOpacity(0.6),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(countryName),
          ),
          onTap: () =>
              homeViewModel.fetchUniversities(countryName: countryName),
        );

    Widget _buildBodyWidget() => Column(
          children: [
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCountryItem(
                        countryName: 'Jordan',
                        color: Colors.green,
                      ),
                      _buildCountryItem(
                        countryName: 'Egypt',
                        color: Colors.cyan,
                      ),
                      _buildCountryItem(
                        countryName: 'Spain',
                        color: Colors.purpleAccent,
                      ),
                    ],
                  ),
                ),
                if (context.screenWidth > 720) ...[
                  Expanded(
                    child: TextFormField(
                      onChanged: homeViewModel.onSearch,
                      decoration: InputDecoration(
                        hintText: context.appLocalizations.search,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15)
                ]
              ],
            ),
            const SizedBox(height: 15),
            const Divider(),
            Expanded(
              child: universities == null
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(5),
                      itemBuilder: _buildUniversityList,
                      itemCount: universities.length,
                    ),
            )
          ],
        );

    return ResponsiveWidget(
      desktop: Scaffold(
        body: Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildDrawerWidget(),
            ),
            const VerticalDivider(
              thickness: 1.5,
              width: 1.5,
            ),
            Expanded(
              flex: 3,
              child: _buildBodyWidget(),
            ),
          ],
        ),
      ),
      mobile: Scaffold(
        appBar: AppBar(
          title: TextFormField(
            onChanged: homeViewModel.onSearch,
            decoration: InputDecoration(
              hintText: context.appLocalizations.search,
            ),
          ),
        ),
        drawer: Drawer(
          child: _buildDrawerWidget(),
        ),
        body: _buildBodyWidget(),
      ),
    );
  }
}
