import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:jardin_botanico/models/plant_model.dart';
import 'package:jardin_botanico/models/services/firebase_service.dart';
import 'package:qr_flutter/qr_flutter.dart';


class PlantController {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;


  PlantController({FirebaseFirestore? firestore, FirebaseStorage? storage})
      : firestore = firestore ?? FirebaseService.firestore,
        storage = storage ?? FirebaseService.storage;

  Future<void> createPlant(PlantModel plant, File imageFile) async {
    String imageUrl = await uploadImage(imageFile, 'plants/${plant.id}');
    plant.imageUrl = imageUrl;
    String qrCodeUrl = await generateQR(plant.id);
    plant.qrCodeUrl = qrCodeUrl;
    await firestore.collection('plants').doc(plant.id).set(plant.toJson());
  }

  Future<PlantModel> getPlant(String id) async {
    final doc = await firestore.collection('plants').doc(id).get();
    return PlantModel.fromMap(doc.data() as Map<String, dynamic>);
  }

  Future<void> updatePlant(PlantModel plant) async {
    await firestore.collection('plants').doc(plant.id).update(plant.toJson());
  }

  Future<void> deletePlant(String id) async {
    await firestore.collection('plants').doc(id).delete();
  }

  Future<String> uploadImage(File imageFile, String path) async {
    FirebaseStorage storage = FirebaseService.storage;
    Reference ref = storage.ref().child(path);
    UploadTask uploadTask = ref.putFile(imageFile);

    await uploadTask.whenComplete(() => null);
    return await ref.getDownloadURL();
  }

  Future<String> generateQR(String plantId) async {
    final qrCode = QrPainter(
      data: plantId,
      version: QrVersions.auto,
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
}
