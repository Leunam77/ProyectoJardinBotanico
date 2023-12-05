import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class FirebaseService {
  static FirebaseFirestore? _firestore;
  static final FirebaseService _instance = FirebaseService._();

  factory FirebaseService() {
    return _instance;
  }
  FirebaseService._() {
    _initFirebase();
  }

  Future<void> _initFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _firestore = FirebaseFirestore.instance;
  }
  static FirebaseFirestore get firestore => _firestore!;
  
  static set firestore(FirebaseFirestore instance){
    _firestore = instance;
  }
}