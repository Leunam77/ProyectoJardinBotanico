import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jardin_botanico/models/category_model.dart';
import 'package:jardin_botanico/models/services/firebase_service.dart';

class CategoryController {
  // final FirebaseFirestore firestore = FirebaseService.firestore; // Usa la propiedad estática firestore de FirebaseService
  final FirebaseFirestore firestore;
  CategoryController({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseService.firestore;

  Future<DocumentReference> createCategory(Category category) async {
    return await firestore.collection('categories').add(category.toJson());
  }

  Future<Category> readCategory(String id) async {
    DocumentSnapshot snapshot =
        await firestore.collection('categories').doc(id).get();
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    data['id'] = snapshot.id; // Agrega el ID del documento al mapa de datos
    return Category.fromMap(data);
  }

  Future<void> updateCategory(Category category) {
    // Asegurarte de que no estás actualizando el ID.
    Map<String, dynamic> categoryData = category.toJson();
    categoryData.remove('id');
    return firestore
        .collection('categories')
        .doc(category.id)
        .update(categoryData);
  }

  Future<void> deleteCategory(String id) {
    return firestore.collection('categories').doc(id).delete();
  }
}
