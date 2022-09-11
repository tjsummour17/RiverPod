import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/services/hive_database.dart';
import 'package:riverpod_app/views/widgets/application_material.dart';
import 'firebase_options.dart';

void main() {
  runZonedGuarded(() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await HiveDatabase.initializeDB();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (e) {
      log(e.toString());
    }
    FlutterError.onError = (FlutterErrorDetails details) {
      log(details.stack.toString());
      log(details.exception.toString());
    };
    runApp(const ProviderScope(child: ApplicationMaterial()));
  }, (error, stackTrace) {
    log(error.toString() + '\n\n' + stackTrace.toString());
  });
}
