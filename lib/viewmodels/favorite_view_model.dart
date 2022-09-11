import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/models/university.dart';
import 'package:riverpod_app/repo/favorite_firbase_repo.dart';

class FavoriteViewModel extends StateNotifier<List<University>?> {
  FavoriteViewModel({List<University>? universities}) : super(universities);

  final FavoriteFirebaseRepo repo = FavoriteFirebaseRepo();

  Future<void> fetchFavorites(String userId) async {
    state = await repo.fetchFavorites(userId);
  }

  Future<void> addFavorite({
    required String userId,
    required University university,
  }) async {
    await repo.addFavorite(userId: userId, university: university);
    state?.add(university);
  }

  Future<void> removeFavorite({
    required String userId,
    required University university,
  }) async {
    await repo.removeFavorite(userId: userId, university: university);
    state?.remove(university);
  }
}

final favoriteNotifier =
    StateNotifierProvider<FavoriteViewModel, List<University>?>(
  (ref) => FavoriteViewModel(),
);
