import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'firebase_options.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  static FirebaseFirestore? _firestore;
  static FirebaseStorage? _storage;
  static FirebasePerformance? _performance;

  Future<void> initializeFirebase() async {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
    _firestore = FirebaseFirestore.instance;
    _storage = FirebaseStorage.instance;
    _performance = FirebasePerformance.instance;
  }

  static FirebaseFirestore get firestore {
    if (_firestore == null) {
      throw Exception(
          "Firestore is not initialized. Call initializeFirebase() first.");
    }
    return _firestore!;
  }

  static FirebaseStorage get storage {
    if (_storage == null) {
      throw Exception(
          "Storage is not initialized. Call initializeFirebase() first.");
    }
    return _storage!;
  }

  static Future<FirebasePerformance> get performance async {
    _performance ??= FirebasePerformance.instance;
    return _performance!;
  }

  static set firestore(FirebaseFirestore instance) {
    _firestore = instance;
  }

  static set storage(FirebaseStorage instance) {
    _storage = instance;
  }
}
