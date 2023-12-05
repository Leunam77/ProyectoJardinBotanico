import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jardin_botanico/models/plant_model.dart';
import 'package:jardin_botanico/models/services/firebase_service.dart';

class PlantController {
  final FirebaseFirestore firestore;

  PlantController({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseService.firestore;

  Future<void> createPlant(PlantModel plant) async {
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
}
