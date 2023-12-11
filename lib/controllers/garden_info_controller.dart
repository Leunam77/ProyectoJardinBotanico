import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jardin_botanico/models/garden_info_model.dart';
import 'package:jardin_botanico/models/services/firebase_service.dart';

class GardenInfoController {
  final FirebaseFirestore firestore;
  GardenInfoController({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseService.firestore;

  Future<GardenInfo> getGardenInfo() async {
    DocumentSnapshot snapshot =
        await firestore.collection('garden_info').doc('info').get();
    return GardenInfo.fromMap(snapshot.data() as Map<String, dynamic>);
  }

  Future<void> updateGardenInfo(GardenInfo gardenInfo) {
    return firestore
        .collection('garden_info')
        .doc('info')
        .update(gardenInfo.toJson());
  }

  // Future<void> addGardenInfo(GardenInfo gardenInfo) async {
  //   DocumentReference docRef =
  //       await firestore.collection('garden_info').add(gardenInfo.toJson());
  //   await docRef.update({'id': docRef.id});
  //   return docRef.id;
  // }

  Future<void> setGardenInfo(GardenInfo gardenInfo) async {
    await firestore
        .collection('garden_info')
        .doc('info')
        .set(gardenInfo.toJson());
  }
}
