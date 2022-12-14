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
    return web;
  }

  static const FirebaseOptions web = FirebaseOptions(
      apiKey: "AIzaSyDF9mzYdQIZdiKKiT5TwHPpZ7O9zv0ugoA",
      authDomain: "file-management-886dc.firebaseapp.com",
      projectId: "file-management-886dc",
      storageBucket: "file-management-886dc.appspot.com",
      messagingSenderId: "519579716174",
      appId: "1:519579716174:web:bd23769abbcfec05fb111f",
      measurementId: "G-0CC3SPSDQH");

  /* static const FirebaseOptions web = FirebaseOptions(
      apiKey: "AIzaSyBDuV852ogvXe0RhC7W3ZzM0cXJLs1ZOWk",
      authDomain: "fe-slot-analysis.firebaseapp.com",
      projectId: "fe-slot-analysis",
      storageBucket: "fe-slot-analysis.appspot.com",
      messagingSenderId: "1009983760292",
      appId: "1:1009983760292:web:57d41790490e94b6768331",
      measurementId: "G-XPZ2F9JRXJ"); */
}
