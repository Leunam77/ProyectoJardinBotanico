import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jardin_botanico/models/services/firebase_service.dart';

void main() {
  group('Grupo testing FirebaseService', () {
    test('test debería inicializar Firestore y Storage', () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      final firestore = FakeFirebaseFirestore();
      final storage = MockFirebaseStorage();

      FirebaseService.firestore = firestore;
      FirebaseService.storage = storage;

      expect(FirebaseService.firestore, equals(firestore));
      expect(FirebaseService.storage, equals(storage));
    });
    test('test debería devolver diferentes instancias para múltiples llamadas',
        () {
      final firestore = FakeFirebaseFirestore();
      final storage = MockFirebaseStorage();
      FirebaseService.firestore = firestore;
      FirebaseService.storage = storage;
      TestWidgetsFlutterBinding.ensureInitialized();
      final service1 = FirebaseService();
      final service2 = FirebaseService();

      expect(identical(service1, service2), isFalse);
    });
    test('set firestore debería cambiar la instancia de firestore', () {
      final firestore = FakeFirebaseFirestore();
      FirebaseService.firestore = firestore;

      expect(FirebaseService.firestore, equals(firestore));
    });

    test('set storage debería cambiar la instancia de storage', () {
      final storage = MockFirebaseStorage();
      FirebaseService.storage = storage;

      expect(FirebaseService.storage, equals(storage));
    });
  });
}
