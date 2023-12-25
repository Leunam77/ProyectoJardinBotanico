import 'package:flutter/material.dart';
import 'package:jardin_botanico/models/category_model.dart';
import 'package:jardin_botanico/controllers/category_controller.dart';

void showModalCategory(BuildContext context) {
  final controller = TextEditingController();
  final categoryController = CategoryController();
  var navigator = Navigator.of(context);
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Agregar Categoría'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: "Nombre de la categoría"),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              navigator.pop();
            },
          ),
          TextButton(
            child: const Text('Agregar'),
            onPressed: () async {
              String nombreCategoria = controller.text;
              Category newCategory =
                  Category(nombreCategoria: nombreCategoria);
              await categoryController.createCategory(newCategory);
              navigator.pop();
            },
          ),
        ],
      );
    },
  );
}
