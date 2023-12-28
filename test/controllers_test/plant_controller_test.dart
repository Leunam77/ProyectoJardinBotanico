import 'dart:io';
import 'package:jardin_botanico/models/services/firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test/test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:jardin_botanico/controllers/plant_controller.dart';
import 'package:jardin_botanico/models/plant_model.dart';
import 'package:mockito/mockito.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';

class MockFile extends Mock implements File {
  @override
  String get path => 'path/to/mock/file';
}

void main() {
  group('Grupo de testing  Plant controller', () {
    late PlantController controller;
    late MockFile imageFile;
    late FakeFirebaseFirestore firestore;
    late MockFirebaseStorage storage;

    setUp(() {
      firestore = FakeFirebaseFirestore();
      storage = MockFirebaseStorage();
      FirebaseService.firestore = firestore;
      FirebaseService.storage = storage;
      controller = PlantController(firestore: firestore);
      imageFile = MockFile();
    });

    test('test de creacion con createPlant', () async {
      final plant = PlantModel(
        nombreColoquial: ['nombreColoquial'],
        nombreCientifico: 'nombreCientifico',
        descripcion: 'descripcion',
        usosMedicinales: 'usosMedicinales',
        imageUrl: 'imageUrl',
        qrCodeUrl: 'qrCodeUrl',
        categoriesIds: ['categoryId'],
        fechaCreacion: Timestamp.fromDate(DateTime(2022, 12, 31)),
      );

      imageFile = MockFile();

      await controller.createPlant(plant, imageFile);

      await Future.delayed(const Duration(seconds: 10));

      final querySnapshot = await firestore
          .collection('plants')
          .orderBy('fechaCreacion', descending: true)
          .limit(1)
          .get();

      expect(querySnapshot.docs, isNotEmpty);

      final latestDoc = querySnapshot.docs.first;

      expect(latestDoc['nombreColoquial'], equals(plant.nombreColoquial));
      expect(latestDoc['nombreCientifico'], equals(plant.nombreCientifico));
      expect(latestDoc['descripcion'], equals(plant.descripcion));
      expect(latestDoc['usosMedicinales'], equals(plant.usosMedicinales));
    });

    test('test de obtencion con getPlant', () async {
      final plant = PlantModel(
        id: 'id1',
        nombreColoquial: ['nombreColoquial'],
        nombreCientifico: 'nombreCientifico',
        descripcion: 'descripcion',
        usosMedicinales: 'usosMedicinales',
        imageUrl: 'imageUrl',
        qrCodeUrl: 'qrCodeUrl',
        categoriesIds: ['categoryId'],
        fechaCreacion: Timestamp.fromDate(DateTime(2022, 12, 31)),
      );
      await firestore.collection('plants').doc(plant.id).set(plant.toJson());

      final snapshot = await firestore.collection('plants').doc('id1').get();
      expect(snapshot.data(), equals(plant.toJson()));
    });

    test('test de actualizacion con updatePlant', () async {
      final plant = PlantModel(
        id: 'id1',
        nombreColoquial: ['nombreColoquial'],
        nombreCientifico: 'nombreCientifico',
        descripcion: 'descripcion',
        usosMedicinales: 'usosMedicinales',
        imageUrl: 'imageUrl',
        qrCodeUrl: 'qrCodeUrl',
        categoriesIds: ['categoryId'],
        fechaCreacion: Timestamp.fromDate(DateTime(2022, 12, 31)),
      );
      await firestore.collection('plants').doc(plant.id).set(plant.toJson());

      final updatedPlant = PlantModel(
        id: 'id1',
        nombreColoquial: ['nombreColoquial actualizado'],
        nombreCientifico: 'nombreCientifico actualizado',
        descripcion: 'descripcion actualizada',
        usosMedicinales: 'usosMedicinales actualizados',
        imageUrl: 'imageUrl',
        qrCodeUrl: 'qrCodeUrl',
        categoriesIds: ['categoryId'],
        fechaCreacion: Timestamp.fromDate(DateTime(2022, 12, 31)),
      );
      await controller.updatePlant(updatedPlant);

      final snapshot = await firestore.collection('plants').doc(plant.id).get();
      final data = snapshot.data()!;
      expect(data, equals(updatedPlant.toJson()));
    });

    test('test de borrar con deletePlant', () async {
      final plant = PlantModel(
        id: 'id1',
        nombreColoquial: ['nombreColoquial'],
        nombreCientifico: 'nombreCientifico',
        descripcion: 'descripcion',
        usosMedicinales: 'usosMedicinales',
        imageUrl: 'imageUrl',
        qrCodeUrl: 'qrCodeUrl',
        categoriesIds: ['categoryId'],
        fechaCreacion: Timestamp.fromDate(DateTime(2022, 12, 31)),
      );

      await firestore.collection('plants').doc('id').set(plant.toJson());

      await controller.deletePlant('id');

      final snapshot = await firestore.collection('plants').doc('id').get();
      expect(snapshot.exists, isFalse);
    });
    test('test de subir imagen con uploadImage', () async {
      final storage = MockFirebaseStorage();

      final controller = PlantController(storage: storage);
      final image = File('path/a/la/imagen');
      final result = await controller.uploadImage(image);

      expect(result,
          'https://firebasestorage.googleapis.com/v0/b/some-bucket/o/plants/imagen');
    });
    test('test de crear, actualizar y eliminar', () async {
      final controller = PlantController(
        firestore: firestore,
        storage: storage,
      );

      final plant = PlantModel(
        nombreColoquial: ['nombreColoquial'],
        nombreCientifico: 'nombreCientifico',
        descripcion: 'descripcion',
        usosMedicinales: 'usosMedicinales',
        imageUrl: 'imageUrl',
        qrCodeUrl: 'qrCodeUrl',
        categoriesIds: ['categoryId'],
        fechaCreacion: Timestamp.fromDate(DateTime.now()),
      );

      final imageFile = File('path/to/image.png');
      await controller.createPlant(plant, imageFile);

      final querySnapshot = await firestore
          .collection('plants')
          .orderBy('fechaCreacion', descending: true)
          .limit(1)
          .get();

      expect(querySnapshot.docs, isNotEmpty);

      final updatedPlant = PlantModel(
        id: querySnapshot.docs.first.id,
        nombreColoquial: ['nombreColoquial actualizado'],
        nombreCientifico: 'nombreCientifico actualizado',
        descripcion: 'descripcion actualizada',
        usosMedicinales: 'usosMedicinales actualizados',
        imageUrl: 'imageUrl',
        qrCodeUrl: 'qrCodeUrl',
        categoriesIds: ['categoryId'],
        fechaCreacion: Timestamp.fromDate(DateTime.now()),
      );

      await controller.updatePlant(updatedPlant);

      final querySnapshot2 = await firestore
          .collection('plants')
          .orderBy('fechaCreacion', descending: true)
          .limit(1)
          .get();

      expect(querySnapshot2.docs, isNotEmpty);

      await controller.deletePlant(querySnapshot2.docs.first.id);

      expect(
          () async => await controller.getPlant(querySnapshot2.docs.first.id),
          throwsA(isA<Exception>()));
    });

    test('test de subir imagen y devolver URLImagen', () async {
      final controller = PlantController(
        firestore: firestore,
        storage: storage,
      );

      final imageFile = File('path/to/image.png');
      final imageUrl = await controller.uploadImage(imageFile);

      expect(imageUrl, isNotNull);
      expect(imageUrl, startsWith('https://'));
    });

    test('test de generar un QR y descargar la URL', () async {
      final controller = PlantController(
        firestore: firestore,
        storage: storage,
      );

      final qrUrl = await controller.generateQR('plantId');

      expect(qrUrl, isNotNull);
      expect(qrUrl, startsWith('https://'));
    });

    test('test de retornar verdadero para verificar plantaValida', () async {
      final controller = PlantController(
        firestore: firestore,
        storage: storage,
      );
      final plant = PlantModel(
        nombreColoquial: ['nombreColoquial'],
        nombreCientifico: 'nombreCientifico',
        descripcion: 'descripcion',
        usosMedicinales: 'usosMedicinales',
        imageUrl: 'imageUrl',
        qrCodeUrl: 'qrCodeUrl',
        categoriesIds: ['categoryId'],
        fechaCreacion: Timestamp.fromDate(DateTime.now()),
      );

      final imageFile = File('path/to/image.png');
      await controller.createPlant(plant, imageFile);
      final querySnapshot2 = await firestore
          .collection('plants')
          .orderBy('fechaCreacion', descending: true)
          .limit(1)
          .get();

      expect(querySnapshot2.docs, isNotEmpty);
      final isValid =
          await controller.esPlantaValida(querySnapshot2.docs.first.id);

      expect(isValid, isTrue);
    });

    test('test de retorno de primerNombreColoquial', () async {
      final controller = PlantController(
        firestore: firestore,
        storage: storage,
      );
      final plant = PlantModel(
        nombreColoquial: ['nombreColoquial'],
        nombreCientifico: 'nombreCientifico',
        descripcion: 'descripcion',
        usosMedicinales: 'usosMedicinales',
        imageUrl: 'imageUrl',
        qrCodeUrl: 'qrCodeUrl',
        categoriesIds: ['categoryId'],
        fechaCreacion: Timestamp.fromDate(DateTime.now()),
      );

      final imageFile = File('path/to/image.png');
      await controller.createPlant(plant, imageFile);
      final querySnapshot2 = await firestore
          .collection('plants')
          .orderBy('fechaCreacion', descending: true)
          .limit(1)
          .get();

      expect(querySnapshot2.docs, isNotEmpty);
      final nombreCientifico = await controller
          .obtenerNombreCientifico(querySnapshot2.docs.first.id);

      expect(nombreCientifico, equals('nombreColoquial'));
    });

    test('test de lista de plantas', () async {
      final controller = PlantController(
        firestore: firestore,
        storage: storage,
      );
      final plant = PlantModel(
        nombreColoquial: ['nombreColoquial'],
        nombreCientifico: 'nombreCientifico',
        descripcion: 'descripcion',
        usosMedicinales: 'usosMedicinales',
        imageUrl: 'imageUrl',
        qrCodeUrl: 'qrCodeUrl',
        categoriesIds: ['categoryId'],
        fechaCreacion: Timestamp.fromDate(DateTime.now()),
      );

      final imageFile = File('path/to/image.png');
      await controller.createPlant(plant, imageFile);
      final querySnapshot2 = await firestore
          .collection('plants')
          .orderBy('fechaCreacion', descending: true)
          .limit(1)
          .get();

      expect(querySnapshot2.docs, isNotEmpty);
      final plants = await controller.getPlants().first;

      expect(plants, isNotEmpty);
    });

    test('test retorno un Qr valido por planta', () async {
      final controller = PlantController(
        firestore: firestore,
        storage: storage,
      );
      final plant = PlantModel(
        nombreColoquial: ['nombreColoquial'],
        nombreCientifico: 'nombreCientifico',
        descripcion: 'descripcion',
        usosMedicinales: 'usosMedicinales',
        imageUrl: 'imageUrl',
        qrCodeUrl: 'qrCodeUrl',
        categoriesIds: ['categoryId'],
        fechaCreacion: Timestamp.fromDate(DateTime.now()),
      );

      final imageFile = File('path/to/image.png');
      await controller.createPlant(plant, imageFile);
      final querySnapshot2 = await firestore
          .collection('plants')
          .orderBy('fechaCreacion', descending: true)
          .limit(1)
          .get();

      expect(querySnapshot2.docs, isNotEmpty);
      final qrUrl = await controller.getQRUrl(querySnapshot2.docs.first.id);

      expect(qrUrl, isNotNull);
      expect(qrUrl, startsWith('https://'));
    });

    test('test retorno las ultimas plantas', () async {
      final controller = PlantController(
        firestore: firestore,
        storage: storage,
      );
      final plant = PlantModel(
        nombreColoquial: ['nombreColoquial'],
        nombreCientifico: 'nombreCientifico',
        descripcion: 'descripcion',
        usosMedicinales: 'usosMedicinales',
        imageUrl: 'imageUrl',
        qrCodeUrl: 'qrCodeUrl',
        categoriesIds: ['categoryId'],
        fechaCreacion: Timestamp.fromDate(DateTime.now()),
      );

      final imageFile = File('path/to/image.png');
      await controller.createPlant(plant, imageFile);
      final querySnapshot2 = await firestore
          .collection('plants')
          .orderBy('fechaCreacion', descending: true)
          .limit(1)
          .get();

      expect(querySnapshot2.docs, isNotEmpty);
      final latestPlants = await controller.getLatestPlants();

      expect(latestPlants, isNotEmpty);
    });
  });
}
