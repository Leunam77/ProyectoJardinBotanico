import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jardin_botanico/models/services/firebase_service.dart';

void main() {
  group('Grupo testing FirebaseService', () {
    test('test debería inicializar Firestore y Storage', () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      // Configura los fakes
      final firestore = FakeFirebaseFirestore();
      final storage = MockFirebaseStorage();

      // Configura el servicio de Firebase
      FirebaseService.firestore = firestore;
      FirebaseService.storage = storage;

      // Comprueba que Firestore y Storage se han inicializado correctamente
      expect(FirebaseService.firestore, equals(firestore));
      expect(FirebaseService.storage, equals(storage));
    });
    test('test debería devolver la misma instancia para múltiples llamadas', () {
      final firestore = FakeFirebaseFirestore();
      final storage = MockFirebaseStorage();
      FirebaseService.firestore = firestore;
      FirebaseService.storage = storage;
      TestWidgetsFlutterBinding.ensureInitialized(); 
      final service1 = FirebaseService();
      final service2 = FirebaseService();

      expect(service1, equals(service2));
    });
  });
}