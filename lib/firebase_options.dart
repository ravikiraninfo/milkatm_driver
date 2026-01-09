import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;


class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
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
    apiKey: 'AIzaSyBSv-YHKdMh5DIbcgYmNlihiS2eTexnhgE',
    appId: '1:500929236066:android:438d31ca312145df15153b',
    messagingSenderId: '500929236066',
    projectId: 'milk-atm',
    storageBucket: 'milk-atm.firebasestorage.app',
  );
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAdjTfwVUtYN-tlz49DWlw5iduOTa8LptM',
    appId: '1:500929236066:ios:040806e78fca63ac15153b',
    messagingSenderId: '500929236066',
    projectId: 'milk-atm',
    storageBucket: 'milk-atm.firebasestorage.app',
    iosBundleId: 'com.shop.milk-driver',
  );
}
