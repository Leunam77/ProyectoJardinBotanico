import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jardin_botanico/models/plant_model.dart';
import 'package:jardin_botanico/controllers/plant_controller.dart';

class CreatePlantForm extends StatefulWidget {
  const CreatePlantForm({super.key});

  @override
  CreatePlantFormState createState() => CreatePlantFormState();
}

class CreatePlantFormState extends State<CreatePlantForm> {
  final _formKey = GlobalKey<FormState>();
  final plantController = PlantController();
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

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              setState(() {
                nombreColoquialControllers.add(TextEditingController());
              });
            },
            child: const Text('Agregar nombre coloquial'),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: nombreColoquialControllers.length,
            itemBuilder: (context, index) {
              return TextFormField(
                controller: nombreColoquialControllers[index],
                decoration:
                    const InputDecoration(labelText: 'Nombre Coloquial'),
                onSaved: (value) {
                  if (value != null && value.isNotEmpty) {
                    nombreColoquialControllers[index].text = value;
                  }
                },
              );
            },
          ),
          TextFormField(
            controller: nombreCientificoController,
            decoration: const InputDecoration(labelText: 'Nombre Científico'),
            onSaved: (value) => nombreCientifico = value ?? '',
          ),
          TextFormField(
            controller: descripcionController,
            decoration: const InputDecoration(labelText: 'Descripción'),
            onSaved: (value) => descripcion = value ?? '',
          ),
          TextFormField(
            controller: usosMedicinalesController,
            decoration: const InputDecoration(labelText: 'Usos Medicinales'),
            onSaved: (value) => usosMedicinales = value ?? '',
          ),
          ElevatedButton(
            onPressed: selectImage,
            child: const Text('Seleccionar imagen'),
          ),
          if (imageFile != null) Text(imageFile!.path),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                List<String> nombreColoquial = nombreColoquialControllers
                    .map((controller) => controller.text)
                    .toList();
                PlantModel newPlant = PlantModel(
                  nombreColoquial: nombreColoquial,
                  nombreCientifico: nombreCientifico,
                  descripcion: descripcion,
                  usosMedicinales: usosMedicinales,
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
    );
  }
}
