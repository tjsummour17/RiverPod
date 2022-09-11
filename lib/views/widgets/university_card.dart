import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/models/university.dart';
import 'package:riverpod_app/models/user.dart';
import 'package:riverpod_app/providers/current_user_provider.dart';
import 'package:riverpod_app/utils/build_context_x.dart';
import 'package:riverpod_app/viewmodels/favorite_view_model.dart';
import 'package:riverpod_app/viewmodels/home_view_model.dart';

class UniversityCard extends ConsumerWidget {
  const UniversityCard({
    required this.university,
    this.inFav = false,
    Key? key,
  }) : super(key: key);

  final University university;
  final bool inFav;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FavoriteViewModel favoriteViewModel = ref.read(favoriteNotifier.notifier);
    HomeViewModel homeViewModel = ref.read(universitiesNotifier.notifier);
    User user =
        ref.read(userNotifier) ?? const User(email: '', phone: '', name: '');
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(university.name ?? ''),
        subtitle: Text(university.domains?.first ?? ''),
        trailing: IconButton(
          onPressed: () {
            if (inFav) {
              favoriteViewModel.removeFavorite(
                userId: user.id,
                university: university,
              );
            } else {
              favoriteViewModel.addFavorite(
                userId: user.id,
                university: university,
              );
              homeViewModel.addUniToFav(university);
            }
          },
          icon: Icon(inFav ? Icons.favorite : Icons.favorite_border),
        ),
      ),
    );
  }
}
