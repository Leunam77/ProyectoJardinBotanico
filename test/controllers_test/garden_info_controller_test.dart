import 'package:test/test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:jardin_botanico/models/garden_info_model.dart';
import 'package:jardin_botanico/controllers/garden_info_controller.dart';
import 'package:jardin_botanico/models/services/firebase_service.dart';

void main() {
  final firestore = FakeFirebaseFirestore();
  FirebaseService.firestore = firestore;
  final controller = GardenInfoController(firestore: firestore);

  group('grupo de test de GardenInfoController', () {
    test('test de getGardenInfo con un documento no existente', () async {
      final result = await controller.getGardenInfo();
      expect(result, isNull);
    });

    test('test de updateGardenInfo con un documento no existente', () async {
      final gardenInfo = GardenInfo(
          id: 'nonexistent',
          numero: '1234567890',
          direccionMaps: 'Test Address',
          linkFacebook: 'Test Facebook',
          linkInstagram: 'Test Instagram',
          linkTikTok: 'Test TikTok',
          descripcion: 'Test Description');
      expectLater(
          controller.updateGardenInfo(gardenInfo), throwsA(isA<Exception>()));
    });
    test('test de obtencion con getGardenInfo', () async {
      final gardenInfo = GardenInfo(
          id: 'DQ2iWNuSpjWdaQvJN0MW',
          numero: '1234567890',
          direccionMaps: 'Test Address',
          linkFacebook: 'Test Facebook',
          linkInstagram: 'Test Instagram',
          linkTikTok: 'Test TikTok',
          descripcion: 'Test Description');
      await firestore
          .collection('GardenInfo')
          .doc('DQ2iWNuSpjWdaQvJN0MW')
          .set(gardenInfo.toJson());

      final result = await controller.getGardenInfo();
      expect(result, gardenInfo);
    });

    test('test de que se actualiza con updateGardenInfo', () async {
      final gardenInfo = GardenInfo(
          id: 'info',
          numero: '1234567890',
          direccionMaps: 'Test Address',
          linkFacebook: 'Test Facebook',
          linkInstagram: 'Test Instagram',
          linkTikTok: 'Test TikTok',
          descripcion: 'Test Description');
      await firestore
          .collection('garden_info')
          .doc('info')
          .set(gardenInfo.toJson());

      final updatedGardenInfo = GardenInfo(
          id: 'info',
          numero: '0987654321',
          direccionMaps: 'Updated Test Address',
          linkFacebook: 'Updated Test Facebook',
          linkInstagram: 'Updated Test Instagram',
          linkTikTok: 'Updated Test TikTok',
          descripcion: 'Updated Test Description');
      await controller.updateGardenInfo(updatedGardenInfo);

      final snapshot =
          await firestore.collection('garden_info').doc('info').get();
      final result = GardenInfo.fromMap(
          snapshot.id, snapshot.data() as Map<String, dynamic>);
      expect(result, updatedGardenInfo);
    });

    test('test de que funciona setGardenInfo', () async {
      final gardenInfo = GardenInfo(
          id: 'info',
          numero: '1234567890',
          direccionMaps: 'Test Address',
          linkFacebook: 'Test Facebook',
          linkInstagram: 'Test Instagram',
          linkTikTok: 'Test TikTok',
          descripcion: 'Test Description');

      await controller.setGardenInfo(gardenInfo);

      final snapshot =
          await firestore.collection('garden_info').doc('info').get();
      final result = GardenInfo.fromMap(
          snapshot.id, snapshot.data() as Map<String, dynamic>);
      expect(result, gardenInfo);
    });

    test('test de setGardenInfo con un documento existente', () async {
      final gardenInfo = GardenInfo(
          id: 'info',
          numero: '1234567890',
          direccionMaps: 'Test Address',
          linkFacebook: 'Test Facebook',
          linkInstagram: 'Test Instagram',
          linkTikTok: 'Test TikTok',
          descripcion: 'Test Description');
      await firestore
          .collection('garden_info')
          .doc('info')
          .set(gardenInfo.toJson());

      final updatedGardenInfo = GardenInfo(
          id: 'info',
          numero: '0987654321',
          direccionMaps: 'Updated Test Address',
          linkFacebook: 'Updated Test Facebook',
          linkInstagram: 'Updated Test Instagram',
          linkTikTok: 'Updated Test TikTok',
          descripcion: 'Updated Test Description');
      await controller.setGardenInfo(updatedGardenInfo);

      final snapshot =
          await firestore.collection('garden_info').doc('info').get();
      final result = GardenInfo.fromMap(
          snapshot.id, snapshot.data() as Map<String, dynamic>);
      expect(result, updatedGardenInfo);
    });
  });
}
