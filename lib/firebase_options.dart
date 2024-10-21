// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCBYseIcUYZXVhPUw_u2aYUssrDYpYeKiw',
    appId: '1:290792401820:android:d77f2e97e6ab2fef7ff659',
    messagingSenderId: '290792401820',
    projectId: 'splitzy-app',
    storageBucket: 'splitzy-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBJP068-eMDPa0NC-emUg36NrL2Xk_9O4s',
    appId: '1:290792401820:ios:756a93b38d6b7be67ff659',
    messagingSenderId: '290792401820',
    projectId: 'splitzy-app',
    storageBucket: 'splitzy-app.appspot.com',
    androidClientId: '290792401820-vf5m6abb7p9f58g02tt938b9q15ajt1l.apps.googleusercontent.com',
    iosClientId: '290792401820-aj4m6l2dii4j3nihbrm6u9hrs636lc55.apps.googleusercontent.com',
    iosBundleId: 'com.example.splitzy',
  );
}
