import 'package:test/test.dart';
import 'package:jardin_botanico/models/category_model.dart';

void main() {
  group('Category', () {
    test('debería crear una categoría desde un mapa', () {
      // Configura el mapa
      final map = {'id': '1', 'nombreCategoria': 'Categoria 1'};

      // Crea una categoría desde el mapa
      final category = Category.fromMap(map);

      // Comprueba que los valores son los esperados
      expect(category.id, equals('1'));
      expect(category.nombreCategoria, equals('Categoria 1'));
    });

    test('debería convertir una categoría a un mapa', () {
      // Configura la categoría
      final category = Category(id: '1', nombreCategoria: 'Categoria 1');

      // Convierte la categoría a un mapa
      final map = category.toJson();

      // Comprueba que los valores son los esperados
      expect(map['id'], equals('1'));
      expect(map['nombreCategoria'], equals('Categoria 1'));
    });

    test('debería comparar dos categorías correctamente', () {
      // Configura dos categorías iguales y una diferente
      final category1 = Category(id: '1', nombreCategoria: 'Categoria 1');
      final category2 = Category(id: '1', nombreCategoria: 'Categoria 1');
      final category3 = Category(id: '2', nombreCategoria: 'Categoria 2');

      // Comprueba que las categorías iguales son iguales y que las diferentes no lo son
      expect(category1, equals(category2));
      expect(category1, isNot(equals(category3)));
    });
  });
}