import 'package:test/test.dart';
import "package:jardin_botanico/controllers/category_controller.dart";

void main() {
  group('Existencia de atributos', () {
    test('Obtener categoria', () {
      String idTest = "0";
      expect(CategoryController().getCategory(idTest), equals("Arbusto"));
    });
    test('buscar Categoria', () {
      expect(CategoryController().searchCategory("arbusto"), equals("arbusto"));
    });
  });
}
