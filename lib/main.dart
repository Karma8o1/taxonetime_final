import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxonetime/app/app.dart';
import 'package:taxonetime/controller/authController.dart';
import 'firebase_options.dart';

bool isViewed = false;
late bool themeState;
late SharedPreferences prefs;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getBool('showHome') ?? false;
  themeState = prefs.getBool('theme') ?? false;

  Get.put(AuthController());
  AuthController.authInstance.themeState.value = themeState;

  runApp(TaxOneTime(
    isviewed: isViewed,
  ));
}
