import 'package:jardin_botanico/models/services/firebase_service.dart';
import 'package:test/test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:jardin_botanico/controllers/plant_controller.dart';
import 'package:jardin_botanico/models/plant_model.dart';

void main() {
  group('test grupo de Plant controller', () {
    final firestore = FakeFirebaseFirestore();
    FirebaseService.firestore =
        firestore; // Inicializa firestore en FirebaseService
    final controller = PlantController(firestore: firestore);

    test('test de createPlant', () async {
      final plant = PlantModel(
        id: 'id1',
        nombreColoquial: 'nombreColoquial',
        nombreCientifico: 'nombreCientifico',
        descripcion: 'descripcion',
        usosMedicinales: 'usosMedicinales',
      ); // Define la planta
      await controller.createPlant(plant); // Crea la planta

      final snapshot = await firestore.collection('plants').doc(plant.id).get();
      expect(snapshot.exists, isTrue);
      expect(snapshot.data(), equals(plant.toJson()));
    });

    test('test de getPlant', () async {
      final plant = PlantModel(
        id: 'id1',
        nombreColoquial: 'nombreColoquial',
        nombreCientifico: 'nombreCientifico',
        descripcion: 'descripcion',
        usosMedicinales: 'usosMedicinales',
      ); // Define la planta
      await firestore
          .collection('plants')
          .doc(plant.id)
          .set(plant.toJson()); // Añade la planta a la base de datos

      final result = await controller.getPlant(plant.id); // Lee la planta
      expect(result.toJson(), equals(plant.toJson()));
    });

    test('test de updatePlant', () async {
      final plant = PlantModel(
        id: 'id1',
        nombreColoquial: 'nombreColoquial',
        nombreCientifico: 'nombreCientifico',
        descripcion: 'descripcion',
        usosMedicinales: 'usosMedicinales',
      ); // Define la planta
      await firestore
          .collection('plants')
          .doc(plant.id)
          .set(plant.toJson()); // Añade la planta a la base de datos

      final updatedPlant = PlantModel(
        id: 'id1',
        nombreColoquial: 'nombreColoquial actualizado',
        nombreCientifico: 'nombreCientifico actualizado',
        descripcion: 'descripcion actualizada',
        usosMedicinales: 'usosMedicinales actualizados',
      ); // Define la planta actualizada
      await controller.updatePlant(updatedPlant); // Actualiza la planta

      final snapshot = await firestore
          .collection('plants')
          .doc(plant.id)
          .get(); // Obtiene la planta actualizada
      final data = snapshot.data()!;
      expect(data, equals(updatedPlant.toJson()));
    });

    test('test de deletePlant', () async {
      final plant = PlantModel(
        id: 'id1',
        nombreColoquial: 'nombreColoquial',
        nombreCientifico: 'nombreCientifico',
        descripcion: 'descripcion',
        usosMedicinales: 'usosMedicinales',
      ); // Define la planta

      await firestore
          .collection('plants')
          .doc('id')
          .set(plant.toJson()); // Añade la planta a la base de datos

      await controller.deletePlant('id'); // Borra la planta

      final snapshot = await firestore
          .collection('plants')
          .doc('id')
          .get(); // Intenta obtener la planta borrada
      expect(snapshot.exists, isFalse);
    });
  });
}
