import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/models/user.dart';
import 'package:riverpod_app/providers/current_user_provider.dart';
import 'package:riverpod_app/providers/locale_provider.dart';
import 'package:riverpod_app/repo/authentication_firebase_repo.dart';
import 'package:riverpod_app/utils/build_context_x.dart';
import 'package:riverpod_app/viewmodels/create_account_view_model.dart';
import 'package:riverpod_app/views/main_page.dart';

class CreateAccountCard extends ConsumerWidget {
  CreateAccountCard({Key? key}) : super(key: key);

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();
  final TextEditingController _phoneTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> _createAccount() async {
      CreateAccountViewModel accountViewModel = ref.read(
        StateNotifierProvider<CreateAccountViewModel, User?>(
          (ref) => CreateAccountViewModel(),
        ).notifier,
      );
      Locale locale = ref.watch(localeNotifier);
      final result = await accountViewModel.createAccount(
        user: User(
          name: _nameTextController.text,
          phone: _phoneTextController.text,
          email: _emailTextController.text,
          password: _passwordTextController.text,
        ),
        langCode: locale.languageCode,
      );
      switch (result.status) {
        case CreateAccountStatus.success:
          CurrentUserProvider userProvider = ref.read(userNotifier.notifier);
          final newUser = result.user;
          if (newUser != null) {
            userProvider.saveUser(newUser);
            Navigator.pushReplacementNamed(context, MainPage.routeName);
          }
          break;
        case CreateAccountStatus.alreadyExists:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email already registered')),
          );
          break;
        case CreateAccountStatus.weakPassword:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Week password try different password'),
            ),
          );
          break;
        case CreateAccountStatus.unknownError:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Something went wrong')),
          );
      }
    }

    return Container(
      width: 430,
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
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TextFormField(
            controller: _nameTextController,
            decoration: InputDecoration(
              labelText: context.appLocalizations.fullName,
            ),
          ),
          const SizedBox(height: 15),
          TextFormField(
            controller: _phoneTextController,
            decoration: InputDecoration(
              labelText: context.appLocalizations.phone,
            ),
          ),
          const SizedBox(height: 15),
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
                  context.appLocalizations.createAccount,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              onPressed: _createAccount,
            ),
          ),
          const Divider(thickness: 1.5, height: 30),
          Text(context.appLocalizations.alreadyHaveAccount),
          const SizedBox(height: 15),
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
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
