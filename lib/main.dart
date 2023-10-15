import 'package:cloud_firestore/cloud_firestore.dart';
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
bool isFirebaseReady = true;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).catchError((e) {
    isFirebaseReady = false;
    print(e);
  });
  ;
  prefs = await SharedPreferences.getInstance();
  isViewed = prefs.getBool('showHome') ?? false;
  themeState = prefs.getBool('theme') ?? false;
  FirebaseFirestore.instance
      .enablePersistence(PersistenceSettings(synchronizeTabs: true));
  Get.put(AuthController());
  AuthController.authInstance.themeState.value = themeState;

  runApp(TaxOneTime(
    isviewed: isViewed,
  ));
}
