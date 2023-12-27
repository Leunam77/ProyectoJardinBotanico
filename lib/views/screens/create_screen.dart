import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jardin_botanico/models/category_model.dart';
import 'package:jardin_botanico/models/plant_model.dart';
import 'package:jardin_botanico/controllers/plant_controller.dart';
import 'package:jardin_botanico/views/screens/modal_category.dart';
import 'package:jardin_botanico/controllers/category_controller.dart';
import 'package:jardin_botanico/views/screens/modal_options_category.dart';

class CreatePlantForm extends StatefulWidget {
  const CreatePlantForm({super.key});

  @override
  CreatePlantFormState createState() => CreatePlantFormState();
}

class CreatePlantFormState extends State<CreatePlantForm> {
  final _formKey = GlobalKey<FormState>();
  final plantController = PlantController();
  final categoryController = CategoryController();
  final List<TextEditingController> nombreColoquialControllers = [];
  final nombreCientificoController = TextEditingController();
  final descripcionController = TextEditingController();
  final usosMedicinalesController = TextEditingController();
  String nombreColoquial = '';
  String nombreCientifico = '';
  String descripcion = '';
  String usosMedicinales = '';
  File? imageFile;
  final ImagePicker _picker = ImagePicker();
  List<Category> selectedCategories = <Category>[];

  Future<void> selectImage() async {
    final XFile? selectedImage = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 600,
    );

    if (selectedImage != null) {
      setState(() {
        imageFile = File(selectedImage.path);
      });
    }
  }

  void resetImage() {
    setState(() {
      imageFile = null;
    });
  }

  Future<List<Category>> getCategories() async {
    return await categoryController.getCategories();
  }

  Future<void> selectCategory(BuildContext context) async {
    List<Category> categories = await getCategories();

    Future<void> showModalSelectCategoryFunction() async {
      List<Category> selectedCategories =
          await showModalSelectCategory(context, categories);
      setState(() {
        this.selectedCategories = selectedCategories;
      });
    }

    showModalSelectCategoryFunction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0), // Cambia la altura aquí
        child: AppBar(
          title: const Text(
            'Registrar planta',
            style: TextStyle(fontSize: 19.0,
              fontWeight: FontWeight.bold
            ),
          ),
          centerTitle: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Card(
                  child: ListTile(
                    title: const Text('Agregar nombre coloquial'),
                    trailing: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          nombreColoquialControllers
                              .add(TextEditingController());
                        });
                      },
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: nombreColoquialControllers.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: TextFormField(
                          controller: nombreColoquialControllers[index],
                          decoration: const InputDecoration(
                            labelText: 'Nombre Coloquial',
                            border: InputBorder.none,
                          ),
                          onSaved: (value) {
                            if (value != null && value.isNotEmpty) {
                              nombreColoquialControllers[index].text = value;
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 15),
                Card(
                  child: ListTile(
                    title: TextFormField(
                      controller: nombreCientificoController,
                      decoration:
                          const InputDecoration(labelText: 'Nombre Científico'),
                      onSaved: (value) => nombreCientifico = value ?? '',
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Card(
                  child: ListTile(
                    title: TextFormField(
                      controller: descripcionController,
                      decoration:
                          const InputDecoration(labelText: 'Descripción'),
                      onSaved: (value) => descripcion = value ?? '',
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Card(
                  child: ListTile(
                    title: TextFormField(
                      controller: usosMedicinalesController,
                      decoration:
                          const InputDecoration(labelText: 'Usos Medicinales'),
                      onSaved: (value) => usosMedicinales = value ?? '',
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Card(
                  child: Column(
                    children: <Widget>[
                      if (imageFile != null) Text(imageFile!.path),
                      ElevatedButton(
                        onPressed: selectImage,
                        child: const Text('Seleccionar imagen'),
                      ),
                      ElevatedButton(
                        child: const Text('Agregar Categoría'),
                        onPressed: () {
                          showModalCategory(context);
                        },
                      ),
                      ElevatedButton(
                        child: const Text('Seleccionar Categoría'),
                        onPressed: () => selectCategory(context),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      List<String> nombreColoquial = nombreColoquialControllers
                          .map((controller) => controller.text)
                          .toList();
                      List<String> categoriesIds = selectedCategories
                          .map((category) => category.id)
                          .where(
                              (id) => id != null) // Filtra cualquier valor null
                          .map((id) =>
                              id!) // Convierte la lista de String? a lista de String
                          .toList();
                      PlantModel newPlant = PlantModel(
                        nombreColoquial: nombreColoquial,
                        nombreCientifico: nombreCientifico,
                        descripcion: descripcion,
                        usosMedicinales: usosMedicinales,
                        categoriesIds: categoriesIds,
                        fechaCreacion: Timestamp.now(),
                      );
                      plantController.createPlant(newPlant, imageFile!);
                    }
                    for (var controller in nombreColoquialControllers) {
                      controller.clear();
                    }
                    nombreCientificoController.clear();
                    descripcionController.clear();
                    usosMedicinalesController.clear();
                    resetImage();
                  },
                  child: const Text('Crear Planta'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
