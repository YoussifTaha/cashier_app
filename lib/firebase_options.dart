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
    apiKey: 'AIzaSyDbsejYV39898VRC-8D6Gs1qS9KTc5vgY0',
    appId: '1:360274576760:android:18d8a38cee9366369c748d',
    messagingSenderId: '360274576760',
    projectId: 'pub-s-pizza',
    databaseURL: 'https://pub-s-pizza-default-rtdb.firebaseio.com',
    storageBucket: 'pub-s-pizza.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB_xWTfZCXHkdrjsJUVw3trWwVoC4r5Fho',
    appId: '1:360274576760:ios:fab24ba505612c649c748d',
    messagingSenderId: '360274576760',
    projectId: 'pub-s-pizza',
    databaseURL: 'https://pub-s-pizza-default-rtdb.firebaseio.com',
    storageBucket: 'pub-s-pizza.appspot.com',
    androidClientId: '360274576760-m4qd3v0seqfqelkrlffeimimeqpnktq3.apps.googleusercontent.com',
    iosClientId: '360274576760-jfmqj2h9o8cqt1md9v3qi2u49siiu1oq.apps.googleusercontent.com',
    iosBundleId: 'com.example.cashierApp.cashierApp',
  );
}
