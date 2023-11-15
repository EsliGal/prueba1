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
        return macos;
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
    apiKey: 'AIzaSyA5gkIkVd5KZ1e8a0o_dqXBa-Nk5HkNigE',
    appId: '1:857832835054:web:42445e68d3ac2709c530ff',
    messagingSenderId: '857832835054',
    projectId: 'pruebadevelsystem',
    authDomain: 'pruebadevelsystem.firebaseapp.com',
    storageBucket: 'pruebadevelsystem.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDGCn_LXFWiVUoEseANdKplGf8LLjUFbLE',
    appId: '1:857832835054:android:fcd100e80bbe2ed4c530ff',
    messagingSenderId: '857832835054',
    projectId: 'pruebadevelsystem',
    storageBucket: 'pruebadevelsystem.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDaOGBodIxG3JbTifgmoCAWUiBCM7G25VM',
    appId: '1:857832835054:ios:1282d0f3ec01140dc530ff',
    messagingSenderId: '857832835054',
    projectId: 'pruebadevelsystem',
    storageBucket: 'pruebadevelsystem.appspot.com',
    iosBundleId: 'com.example.prueba1',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDaOGBodIxG3JbTifgmoCAWUiBCM7G25VM',
    appId: '1:857832835054:ios:8d10cd0177891ac6c530ff',
    messagingSenderId: '857832835054',
    projectId: 'pruebadevelsystem',
    storageBucket: 'pruebadevelsystem.appspot.com',
    iosBundleId: 'com.example.prueba1.RunnerTests',
  );
}