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
    apiKey: 'AIzaSyBpFP5m62mAmlKOlREcvXwZoli_WUWR1K0',
    appId: '1:191141917910:web:393ceca77fdf4cfb0e8577',
    messagingSenderId: '191141917910',
    projectId: 'dexter-f5c68',
    authDomain: 'dexter-f5c68.firebaseapp.com',
    storageBucket: 'dexter-f5c68.appspot.com',
    measurementId: 'G-XCVCTK64BM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBcS_fiYm6suHlXvOVXJ0SNCriJBJoHqKk',
    appId: '1:191141917910:android:07b2bef8fd54e7100e8577',
    messagingSenderId: '191141917910',
    projectId: 'dexter-f5c68',
    storageBucket: 'dexter-f5c68.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAMa1yDKzyjnh3Cw2Care1b0lO6GDEK7ts',
    appId: '1:191141917910:ios:93abf584f12ce4740e8577',
    messagingSenderId: '191141917910',
    projectId: 'dexter-f5c68',
    storageBucket: 'dexter-f5c68.appspot.com',
    iosClientId: '191141917910-ccjmj1qqn4ftvp4nn9kkoukcniubbrpo.apps.googleusercontent.com',
    iosBundleId: 'com.example.dexter',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAMa1yDKzyjnh3Cw2Care1b0lO6GDEK7ts',
    appId: '1:191141917910:ios:93abf584f12ce4740e8577',
    messagingSenderId: '191141917910',
    projectId: 'dexter-f5c68',
    storageBucket: 'dexter-f5c68.appspot.com',
    iosClientId: '191141917910-ccjmj1qqn4ftvp4nn9kkoukcniubbrpo.apps.googleusercontent.com',
    iosBundleId: 'com.example.dexter',
  );
}