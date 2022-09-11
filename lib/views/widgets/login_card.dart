import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/models/user.dart';
import 'package:riverpod_app/providers/current_user_provider.dart';
import 'package:riverpod_app/repo/authentication_firebase_repo.dart';
import 'package:riverpod_app/utils/build_context_x.dart';
import 'package:riverpod_app/viewmodels/login_view_model.dart';
import 'package:riverpod_app/views/create_account_page.dart';
import 'package:riverpod_app/views/main_page.dart';

class LoginCard extends ConsumerWidget {
  LoginCard({Key? key}) : super(key: key);

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> _login() async {
      LoginViewModel loginViewModel = ref.read(
        StateNotifierProvider<LoginViewModel, User?>(
          (ref) => LoginViewModel(),
        ).notifier,
      );
      final result = await loginViewModel.signIn(
        email: _emailTextController.text,
        password: _passwordTextController.text,
      );
      switch (result.status) {
        case SignInStatus.success:
          CurrentUserProvider userProvider = ref.read(userNotifier.notifier);
          final newUser = result.user;
          if (newUser != null) {
            userProvider.saveUser(newUser);
            Navigator.pushReplacementNamed(context, MainPage.routeName);
          }
          break;
        case SignInStatus.userNotExists:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email is not registered')),
          );
          break;
        case SignInStatus.wrongPassword:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Incorrect password'),
            ),
          );
          break;
        case SignInStatus.unknownError:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Something went wrong')),
          );
      }
    }

    return Container(
      width: 430,
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Theme.of(context).shadowColor,
          ),
        ],
      ),
      child: Column(
        children: [
          TextFormField(
            controller: _emailTextController,
            decoration: InputDecoration(
              labelText: context.appLocalizations.email,
            ),
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: _passwordTextController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: context.appLocalizations.password,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  context.appLocalizations.login,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onPressed: _login,
            ),
          ),
          const Divider(thickness: 1.5, height: 30),
          Text(context.appLocalizations.dontHaveAccount),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  context.appLocalizations.createAccount,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onPressed: () =>
                  Navigator.pushNamed(context, CreateAccountPage.routeName),
            ),
          ),
        ],
      ),
    );
  }
}
