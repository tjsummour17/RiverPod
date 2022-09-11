import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/models/user.dart';
import 'package:riverpod_app/repo/authentication_firebase_repo.dart';
import 'package:riverpod_app/services/hive_database.dart';

class CurrentUserProvider extends StateNotifier<User?> {
  CurrentUserProvider() : super(HiveDatabase.getLastLoggedInUser());

  void saveUser(User user) {
    state = user;
    HiveDatabase.saveLastLoggedInUser(user);
  }

  void logout() {
    state = null;
    AuthenticationFirebaseRepo().signOut();
    HiveDatabase.deleteLastLoggedInUser();
  }
}

final userNotifier = StateNotifierProvider<CurrentUserProvider, User?>(
  (ref) => CurrentUserProvider(),
);
