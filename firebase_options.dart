import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return android;
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyChnOn6yREed1ixT6JuAm3X9NqBghfYH7Q',
    appId: '1:371144989994:android:54833b7b9133188c51d253',
    messagingSenderId: '371144989994',
    projectId: 'chatglobal-by-amar',
    storageBucket: 'chatglobal-by-amar.firebasestorage.app',
  );
}
