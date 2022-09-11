import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/models/user.dart';
import 'package:riverpod_app/providers/current_user_provider.dart';
import 'package:riverpod_app/utils/build_context_x.dart';
import 'package:riverpod_app/viewmodels/favorite_view_model.dart';
import 'package:riverpod_app/views/widgets/university_card.dart';

class FavoritePage extends ConsumerWidget {
  const FavoritePage({super.key});

  static const String routeName = '/favorites';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FavoriteViewModel favoriteViewModel = ref.read(favoriteNotifier.notifier);

    final favorites = ref.watch(favoriteNotifier);
    User user =
        ref.watch(userNotifier) ?? const User(name: '', email: '', phone: '');

    Widget _buildUniversityList(BuildContext context, int index) =>
        favorites != null
            ? UniversityCard(
                university: favorites[index],
                inFav: true,
              )
            : const SizedBox();

    return Scaffold(
      appBar: AppBar(
        title: Text(context.appLocalizations.favorite),
      ),
      body: (favorites != null)
          ? RefreshIndicator(
              onRefresh: () => favoriteViewModel.fetchFavorites(user.id),
              child: ListView.builder(
                padding: const EdgeInsets.all(15),
                itemBuilder: _buildUniversityList,
                itemCount: favorites.length,
              ),
            )
          : const SizedBox(),
    );
  }
}
