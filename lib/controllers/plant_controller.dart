import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:jardin_botanico/models/plant_model.dart';
import 'package:jardin_botanico/models/services/firebase_service.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path/path.dart' as path;


class PlantController {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;


  PlantController({FirebaseFirestore? firestore, FirebaseStorage? storage})
      : firestore = firestore ?? FirebaseService.firestore,
        storage = storage ?? FirebaseService.storage;

  Future<void> createPlant(PlantModel plant, File imageFile) async {
    DocumentReference docRef = await firestore.collection('plants').add({});    
    String imageUrl = await uploadImage(imageFile);
    String qrCodeUrl = await generateQR(docRef.id);
    PlantModel newPlant = PlantModel(
      id: docRef.id, // Usa el ID generado automáticamente
      nombreColoquial: plant.nombreColoquial,
      nombreCientifico: plant.nombreCientifico,
      descripcion: plant.descripcion,
      usosMedicinales: plant.usosMedicinales,
      imageUrl: imageUrl,
      qrCodeUrl: qrCodeUrl,
      categoriesIds: plant.categoriesIds,
    );
    await docRef.set(newPlant.toJson());
  }

  Future<PlantModel> getPlant(String id) async {
    final doc = await firestore.collection('plants').doc(id).get();
    return PlantModel.fromMap(id, doc.data() as Map<String, dynamic>);
  }

  Future<void> updatePlant(PlantModel plant) async {
    await firestore.collection('plants').doc(plant.id).update(plant.toJson());
  }

  Future<void> deletePlant(String id) async {
    await firestore.collection('plants').doc(id).delete();
  }

  Future<String> uploadImage(File imageFile) async {
    FirebaseStorage storage = FirebaseService.storage;
    String fileName = path.basename(imageFile.path); 
    Reference ref = storage.ref().child('plants/$fileName');
    UploadTask uploadTask = ref.putFile(imageFile);

    await uploadTask.whenComplete(() => null);
    return await ref.getDownloadURL();
  }

  Future<String> generateQR(String plantId) async {
    final qrCode = QrPainter(
      // ignore: deprecated_member_use
      data: plantId,
      version: QrVersions.auto,
      emptyColor: Colors.white,
      eyeStyle: const QrEyeStyle(
        eyeShape: QrEyeShape.square,
        color: Colors.black,
      ),
      dataModuleStyle: const QrDataModuleStyle(
        dataModuleShape: QrDataModuleShape.square, 
        color: Colors.black,
      ), // Color de fondo blanco
    );

    final image = await qrCode.toImage(600);
    final bytes = await image.toByteData(format: ImageByteFormat.png);
    if (bytes == null) {
      throw Exception('Failed to convert image to bytes');
    }
    final blob = bytes.buffer.asUint8List();

    final storage = FirebaseService.storage;
    final ref = storage.ref().child('qrcodes/$plantId.png');
    final uploadTask = ref.putData(blob);

    await uploadTask.whenComplete(() => null);
    return await ref.getDownloadURL();
  }
  Future<bool> esPlantaValida(String codigo) async {
    if (codigo.contains('//')) {
      return false;
    }
    final DocumentSnapshot doc =
        await firestore.collection('plants').doc(codigo).get();

    // Si el documento existe, entonces el código corresponde a una planta
    return doc.exists;
  }
  Future<String> obtenerNombreCientifico(String codigo) async {
    if (codigo.contains('//')) {
      throw Exception('El código no puede contener "//"');
    }
    final DocumentSnapshot doc =
        await firestore.collection('plants').doc(codigo).get();

    if (!doc.exists) {
      throw Exception('No existe una planta con ese código');
    }
    return doc.get('nombreCientifico');
  }
  Stream<List<PlantModel>> getPlants() {
    return firestore.collection('plants').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return PlantModel.fromMap(doc.id, doc.data());
      }).toList();
    });
  }

Future<String> getQRUrl(String plantId) async {
    final doc = await firestore.collection('plants').doc(plantId).get();
    final plant = PlantModel.fromMap(doc.id, doc.data() ?? {});
    return plant.qrCodeUrl ?? '';
  }

}
