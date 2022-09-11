import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/models/user.dart';
import 'package:riverpod_app/repo/authentication_firebase_repo.dart';

class LoginViewModel extends StateNotifier<User?> {
  LoginViewModel({User? user}) : super(user);

  final AuthenticationFirebaseRepo _repo = AuthenticationFirebaseRepo();

  Future<SignInResult> signIn({
    required String email,
    required String password,
  }) async {
    final result = await _repo.signIn(
      email: email,
      password: password,
    );
    return result;
  }
}
