import 'package:flutter/material.dart';
import 'package:jardin_botanico/models/category_model.dart';


Future<List<Category>> showModalSelectCategory(
    BuildContext context, List<Category> categories) async {
  List<Category> selectedCategories = [];

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Selecciona las categorías'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SizedBox(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  final category = categories[index];
                  final isSelected = selectedCategories.contains(category);

                  return ListTile(
                    title: Text(category.nombreCategoria),
                    leading: Checkbox(
                      value: isSelected,
                      onChanged: (bool? newValue) {
                        setState(() {
                          if (newValue == true) {
                            selectedCategories.add(category);
                          } else {
                            selectedCategories.remove(category);
                          }
                        });
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Aceptar'),
            onPressed: () {
              Navigator.of(context).pop(selectedCategories);
            },
          ),
        ],
      );
    },
  );

  return selectedCategories;
}
