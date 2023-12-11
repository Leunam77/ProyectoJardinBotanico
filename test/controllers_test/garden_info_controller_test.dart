import 'package:test/test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:jardin_botanico/models/garden_info_model.dart';
import 'package:jardin_botanico/controllers/garden_info_controller.dart';
import 'package:jardin_botanico/models/services/firebase_service.dart';


void main() {
  final firestore = FakeFirebaseFirestore();
  FirebaseService.firestore = firestore; // Inicializa firestore en FirebaseService
  final controller = GardenInfoController(firestore: firestore);

  group('grupo de test de GardenInfoController', () {
    test('getGardenInfo', () async {
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

      final result = await controller.getGardenInfo();
      expect(result, gardenInfo);
    });

    test('updateGardenInfo', () async {
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
      final result =
          GardenInfo.fromMap(snapshot.data() as Map<String, dynamic>);
      expect(result, updatedGardenInfo);
    });
    test('setGardenInfo', () async {
      final gardenInfo = GardenInfo(
          id: 'info',
          numero: '1234567890',
          direccionMaps: 'Test Address',
          linkFacebook: 'Test Facebook',
          linkInstagram: 'Test Instagram',
          linkTikTok: 'Test TikTok',
          descripcion: 'Test Description');

      await controller.setGardenInfo(gardenInfo);

      final result =
          await firestore.collection('garden_info').doc('info').get();
      expect(result.data(), gardenInfo.toJson());
    });
  });
}
