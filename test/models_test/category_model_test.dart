import 'package:test/test.dart';
import 'package:jardin_botanico/models/category_model.dart';

void main() {
  group('Grupo testing Category', () {
    test('test que debería crear una categoría desde un mapa', () {
      final map = {'nombreCategoria': 'Categoria 1'};

      final category = Category.fromMap('1', map);

      expect(category.id, equals('1'));
      expect(category.nombreCategoria, equals('Categoria 1'));
    });

    test('test que debería convertir una categoría a un mapa', () {
      final category = Category(id: '1', nombreCategoria: 'Categoria 1');

      final map = category.toJson();

      expect(map['id'], equals('1'));
      expect(map['nombreCategoria'], equals('Categoria 1'));
    });

    test('test que debería comparar dos categorías correctamente', () {
      final category1 = Category(id: '1', nombreCategoria: 'Categoria 1');
      final category2 = Category(id: '1', nombreCategoria: 'Categoria 1');
      final category3 = Category(id: '2', nombreCategoria: 'Categoria 2');

      expect(category1, equals(category2));
      expect(category1, isNot(equals(category3)));
    });
  });
}
