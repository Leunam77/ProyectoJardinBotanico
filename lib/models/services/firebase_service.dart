import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseService {
  static FirebaseFirestore? _firestore;
  static FirebaseStorage? _storage;
  static final FirebaseService _instance = FirebaseService._();
  

  factory FirebaseService() {
    return _instance;
  }
  FirebaseService._() {
    initFirebase();
  }

  Future<void> initFirebase() async {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
    _firestore = FirebaseFirestore.instance;
    _storage = FirebaseStorage.instance;
  }
  static FirebaseFirestore get firestore => _firestore!;
  static FirebaseStorage get storage => _storage!;
  static set firestore(FirebaseFirestore instance){
    _firestore = instance;
  }
  static set storage(FirebaseStorage instance) {
    _storage = instance;
  }

}