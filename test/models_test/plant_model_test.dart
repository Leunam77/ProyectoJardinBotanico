import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jardin_botanico/models/plant_model.dart';

void main() {
  group('Grupo testing PlantModel', () {
    final testPlant = PlantModel(
      id: '1',
      nombreColoquial: ['Test Plant'],
      nombreCientifico: 'Testus plantus',
      descripcion: 'This is a test plant',
      usosMedicinales: 'Testing',
      imageUrl: 'http://example.com/test.jpg',
      qrCodeUrl: 'http://example.com/test_qr.jpg',
      categoriesIds: ['1', '2', '3'],
      fechaCreacion: Timestamp.now(),
    );

    test('test que debería crear un PlantModel a partir de un mapa', () {
      final timestamp = Timestamp.now();

      final testPlant = PlantModel(
        id: '1',
        nombreColoquial: ['Test Plant'],
        nombreCientifico: 'Testus plantus',
        descripcion: 'This is a test plant',
        usosMedicinales: 'Testing',
        imageUrl: 'http://example.com/test.jpg',
        qrCodeUrl: 'http://example.com/test_qr.jpg',
        categoriesIds: ['1', '2', '3'],
        fechaCreacion: timestamp,
      );

      final map = {
        'id': '1',
        'nombreColoquial': ['Test Plant'],
        'nombreCientifico': 'Testus plantus',
        'descripcion': 'This is a test plant',
        'usosMedicinales': 'Testing',
        'imageUrl': 'http://example.com/test.jpg',
        'qrCodeUrl': 'http://example.com/test_qr.jpg',
        'categoriesIds': ['1', '2', '3'],
        'fechaCreacion': timestamp,
      };

      final plantFromMap = PlantModel.fromMap('1', map);

      expect(plantFromMap, testPlant);
    });

    test('test que debería convertir un PlantModel a un mapa', () {
      final map = testPlant.toJson();

      expect(map, {
        'id': '1',
        'nombreColoquial': ['Test Plant'],
        'nombreCientifico': 'Testus plantus',
        'descripcion': 'This is a test plant',
        'usosMedicinales': 'Testing',
        'imageUrl': 'http://example.com/test.jpg',
        'qrCodeUrl': 'http://example.com/test_qr.jpg',
        'categoriesIds': ['1', '2', '3'],
        'fechaCreacion': testPlant.fechaCreacion,
      });
    });
  });
}
