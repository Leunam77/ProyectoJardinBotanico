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
    test(
        'test que debería lanzar una excepción al leer una categoría que no existe',
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
    test('test que debería devolver una lista vacía cuando no hay categorías',
        () async {
      final categories = await controller.getCategories();
      expect(categories, isEmpty);
    });
    test('test de creacion createCategory', () async {
      final category =
          Category(nombreCategoria: 'Test', id: ''); 
      await controller.createCategory(category); 

      final categories = await controller.getCategories();

      expect(categories, isNotEmpty);
      expect(
          categories.any((c) => c.nombreCategoria == category.nombreCategoria),
          isTrue);
    });

    test('test de  lectura de readCategory', () async {
      final category =
          Category(nombreCategoria: 'Test', id: 'id'); 
      await firestore
          .collection('categories')
          .doc('id')
          .set(category.toJson()); 

      final result = await controller.readCategory('id'); 
      expect(result, equals(category));
    });

    test('test de actualizacion de updateCategory', () async {
      final category =
          Category(nombreCategoria: 'Test', id: 'id'); 
      await firestore
          .collection('categories')
          .doc('id')
          .set(category.toJson()); 

      final updatedCategory = Category(
          nombreCategoria: 'Test actualizado',
          id: 'id'); 
      await controller
          .updateCategory(updatedCategory); 

      final snapshot = await firestore
          .collection('categories')
          .doc('id')
          .get(); 
      final data = snapshot.data()!;
      expect(data, equals(updatedCategory.toJson()));
    });

    test('test de  borrar con deleteCategory', () async {
      final category =
          Category(nombreCategoria: 'Test', id: 'id'); 
      await firestore
          .collection('categories')
          .doc('id')
          .set(category.toJson()); 

      await controller.deleteCategory('id');

      final snapshot = await firestore
          .collection('categories')
          .doc('id')
          .get(); 
      expect(snapshot.exists, isFalse);
    });
  });
}
