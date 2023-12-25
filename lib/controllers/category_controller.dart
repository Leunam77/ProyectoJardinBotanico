import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jardin_botanico/models/category_model.dart';
import 'package:jardin_botanico/models/services/firebase_service.dart';

class CategoryController {
  final FirebaseFirestore firestore;

  CategoryController({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseService.firestore;

  Future<void> createCategory(Category category) async {
    DocumentReference docRef = await firestore.collection('categories').add({});
    Category newCategory = Category(
      id: docRef.id, // Usa el ID generado automáticamente
      nombreCategoria: category.nombreCategoria,
    );
    await docRef.set(newCategory.toJson());
  }

  Future<Category> readCategory(String id) async {
    DocumentSnapshot snapshot =
        await firestore.collection('categories').doc(id).get();
    if (snapshot.data() != null) {
      return Category.fromMap(id, (snapshot.data() as Map<String, dynamic>));
    } else {
      throw Exception('No data found for category $id');
    }
  }

  Future<void> updateCategory(Category category) async {
    await firestore
        .collection('categories')
        .doc(category.id)
        .update(category.toJson());
  }

  Future<void> deleteCategory(String id) async {
    await firestore.collection('categories').doc(id).delete();
  }
  Future<List<Category>> getCategories() async {
    QuerySnapshot snapshot = await firestore.collection('categories').get();
    return snapshot.docs
        .map((doc) =>
            Category.fromMap(doc.id, doc.data() as Map<String, dynamic>))
        .toList();
  }
}

