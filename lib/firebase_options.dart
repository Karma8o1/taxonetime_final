// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDRWA1Isv27JMCpX4Zd-WRgLkXpHMomdew',
    appId: '1:164525720989:web:102274091933e83ce51b74',
    messagingSenderId: '164525720989',
    projectId: 'taxonetime-cff62',
    authDomain: 'taxonetime-cff62.firebaseapp.com',
    storageBucket: 'taxonetime-cff62.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBIZd3wGhq7HtKrqDXLdR15UhixVLYqimk',
    appId: '1:164525720989:android:4d8d63e2171c66b9e51b74',
    messagingSenderId: '164525720989',
    projectId: 'taxonetime-cff62',
    storageBucket: 'taxonetime-cff62.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB1dA8u45zLwl3kQjNCHvLJZxGEPRa3mps',
    appId: '1:164525720989:ios:f225760a83b5ca93e51b74',
    messagingSenderId: '164525720989',
    projectId: 'taxonetime-cff62',
    storageBucket: 'taxonetime-cff62.appspot.com',
    iosBundleId: 'com.example.taxonetime',
  );
}
