import 'package:jardin_botanico/models/services/firebase_service.dart';
import 'package:test/test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:jardin_botanico/controllers/category_controller.dart';
import 'package:jardin_botanico/models/category_model.dart';

void main() {
  group('test grupo Category controller', () {
    final firestore = FakeFirebaseFirestore();
    FirebaseService.firestore = firestore; // Inicializa firestore en FirebaseService
    final controller = CategoryController(firestore : firestore);

    test('test de createCategory', () async {
      final category = Category(nombreCategoria: 'Test', id: ''); // Define la categoría
      final docRef = await controller.createCategory(category); // Crea la categ


      final snapshot = await docRef.get();
      expect(snapshot.exists, isTrue);
      expect(snapshot.data(), equals(category.toJson()));
      expect(docRef.id, isNotEmpty);
      final data = snapshot.data()! as Map<String, dynamic>;
      expect(data['nombreCategoria'], equals(category.nombreCategoria));
    });  

    test('test de readCategory', () async {
      final category =
          Category(nombreCategoria: 'Test', id: 'id'); // Define la categoría
      await firestore
          .collection('categories')
          .doc('id')
          .set(category.toJson()); // Añade la categoría a la base de datos

      final result = await controller.readCategory('id'); // Lee la categoría
      expect(result, equals(category));
    });

    test('test de updateCategory', () async {
      final category =
          Category(nombreCategoria: 'Test', id: 'id'); // Define la categoría
      await firestore
          .collection('categories')
          .doc('id')
          .set(category.toJson()); // Añade la categoría a la base de datos

      final updatedCategory = Category(
          nombreCategoria: 'Test actualizado',
          id: 'id'); // Define la categoría actualizada
      await controller
          .updateCategory(updatedCategory); // Actualiza la categoría

      final snapshot = await firestore
          .collection('categories')
          .doc('id')
          .get(); // Obtiene la categoría actualizada
      final data = snapshot.data()!;
      expect(data, equals(updatedCategory.toJson()));
    });

    test('test de deleteCategory', () async {
      final category =
          Category(nombreCategoria: 'Test', id: 'id'); // Define la categoría
      await firestore
          .collection('categories')
          .doc('id')
          .set(category.toJson()); // Añade la categoría a la base de datos

      await controller.deleteCategory('id'); // Borra la categoría

      final snapshot = await firestore
          .collection('categories')
          .doc('id')
          .get(); // Intenta obtener la categoría borrada
      expect(snapshot.exists, isFalse);
    });
    
  });
}  