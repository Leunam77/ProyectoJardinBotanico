import 'package:jardin_botanico/models/services/firebase_service.dart';
import 'package:test/test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:jardin_botanico/controllers/category_controller.dart';
import 'package:jardin_botanico/models/category_model.dart';

void main() {
  group('test grupo Category controller', () {
    final firestore = FakeFirebaseFirestore();
    FirebaseService.firestore = firestore; 
    final controller = CategoryController(firestore: firestore);
    test('test que debería lanzar una excepción al leer una categoría que no existe',
        () async {
      expect(() async => await controller.readCategory('id_inexistente'),
          throwsA(isA<Exception>()));
    });
    test(
        'test que debería lanzar una excepción al actualizar una categoría que no existe',
        () async {
      final category = Category(id: 'id_inexistente', nombreCategoria: 'Test');
      expect(() async => await controller.updateCategory(category),
          throwsA(isA<Exception>()));
    });
    test(
        'test que debería completarse sin errores al eliminar una categoría que no existe',
        () async {
      await expectLater(controller.deleteCategory('id_inexistente'), completes);
    });
    test(
        'test que debería completarse sin errores al eliminar una categoría que no existe',
        () async {
      await expectLater(controller.deleteCategory('id_inexistente'), completes);
    });
    test('test que debería devolver una lista vacía cuando no hay categorías', () async {
      final categories = await controller.getCategories();
      expect(categories, isEmpty);
    });
    test('test de creacion createCategory', () async {
      final category =
          Category(nombreCategoria: 'Test', id: ''); // Define la categoría
      await controller.createCategory(category); // Crea la categoría

      // Recupera todas las categorías
      final categories = await controller.getCategories();

      // Verifica que la categoría fue creada correctamente
      expect(categories, isNotEmpty);
      expect(
          categories.any((c) => c.nombreCategoria == category.nombreCategoria),
          isTrue);
    });

    test('test de  lectura de readCategory', () async {
      final category =
          Category(nombreCategoria: 'Test', id: 'id'); // Define la categoría
      await firestore
          .collection('categories')
          .doc('id')
          .set(category.toJson()); // Añade la categoría a la base de datos

      final result = await controller.readCategory('id'); // Lee la categoría
      expect(result, equals(category));
    });

    test('test de actualizacion de updateCategory', () async {
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

    test('test de  borrar con deleteCategory', () async {
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
