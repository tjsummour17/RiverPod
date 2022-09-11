import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/utils/build_context_x.dart';
import 'package:riverpod_app/views/helpers/responsive_helper.dart';
import 'package:riverpod_app/views/widgets/create_account_card.dart';

class CreateAccountPage extends ConsumerWidget {
  const CreateAccountPage({super.key});

  static String routeName = '/createAccount';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: ResponsiveWidget(
          desktop: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                context.appLocalizations.createAccount,
                style: TextStyle(
                  fontSize: 32,
                  color: context.theme.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Column(
                children: [
                  const SizedBox(height: 150),
                  CreateAccountCard(),
                  const SizedBox(height: 25),
                ],
              ),
            ],
          ),
          mobile: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      context.appLocalizations.createAccount,
                      style: const TextStyle(
                        fontSize: 32,
                        color: Color(0xff1877F2),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),
                    CreateAccountCard(),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
