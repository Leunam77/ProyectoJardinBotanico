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
    apiKey: 'AIzaSyCAA48k2CmXS46XR_F2Sy1KIg0a1KtIoe4',
    appId: '1:306931792924:web:8fdc16be132bd8304bb3d9',
    messagingSenderId: '306931792924',
    projectId: 'jardinbotanicobd',
    authDomain: 'jardinbotanicobd.firebaseapp.com',
    storageBucket: 'jardinbotanicobd.appspot.com',
    measurementId: 'G-FMGTBRJKSR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDoeRNXgeFrEhTZrcJxCaTaVq5Xf480HOs',
    appId: '1:306931792924:android:a7165ffe397230ae4bb3d9',
    messagingSenderId: '306931792924',
    projectId: 'jardinbotanicobd',
    storageBucket: 'jardinbotanicobd.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDVkgUK5mfa9X-vX9kCFl-FeHQg6ZasE90',
    appId: '1:306931792924:ios:47ffbae32cabe3b04bb3d9',
    messagingSenderId: '306931792924',
    projectId: 'jardinbotanicobd',
    storageBucket: 'jardinbotanicobd.appspot.com',
    iosBundleId: 'com.example.jardinBotanico',
  );
}
