import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/models/user.dart';
import 'package:riverpod_app/repo/authentication_firebase_repo.dart';
import 'package:riverpod_app/services/hive_database.dart';

class CreateAccountViewModel extends StateNotifier<User?> {
  CreateAccountViewModel({User? user}) : super(user);

  final AuthenticationFirebaseRepo _repo = AuthenticationFirebaseRepo();

  Future<CreateAccountResult> createAccount({
    required User user,
    String langCode = 'en',
  }) async {
    final result = await _repo.createAccount(
      user: user,
      langCode: langCode,
    );
    if (result.status == CreateAccountStatus.success) {
      final user = result.user;
      if (user != null) HiveDatabase.saveLastLoggedInUser(user);
    }
    return result;
  }
}
