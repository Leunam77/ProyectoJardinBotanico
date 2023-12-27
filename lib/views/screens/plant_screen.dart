import 'package:flutter/material.dart';
import 'package:jardin_botanico/controllers/plant_controller.dart';
import 'package:jardin_botanico/models/plant_model.dart';
import 'package:jardin_botanico/models/category_model.dart';
import 'package:jardin_botanico/controllers/category_controller.dart';
class PlantScreen extends StatefulWidget {
  final String plantId;
  final PlantModel? plant;
  const PlantScreen({super.key, required this.plantId, this.plant});

  @override
  PlantScreenState createState() => PlantScreenState();
}

class PlantScreenState extends State<PlantScreen> {
  late PlantController plantController;
  late CategoryController categoryController;
  late Future<PlantModel> futurePlant;
  late Future<List<Category>> futureCategories;

  @override
  void initState() {
    super.initState();
    plantController = PlantController();
    categoryController = CategoryController();
    futurePlant = plantController.getPlant(widget.plantId);
    futureCategories = categoryController.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          title: const Text(
            'Información de la planta',
            style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
      ),
      body: FutureBuilder<PlantModel>(
        future: futurePlant,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            PlantModel plant = snapshot.data!;
            return FutureBuilder<List<Category>>(
              future: futureCategories,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<Category> categories = snapshot.data!;
                  List<String> categoryNames = categories
                      .where((category) =>
                          plant.categoriesIds.contains(category.id))
                      .map((category) => category.nombreCategoria)
                      .toList();
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Card(
                            child: ListTile(
                              title: Text(
                                  'Nombres: ${plant.nombreColoquial.join(', ')}',
                                style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                  'Nombres Científicos: ${plant.nombreCientifico}',
                                style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: const Text('Categorías',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(categoryNames.join(', '),
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                          Card(
                            child: Image(
                              image: NetworkImage(plant.imageUrl ?? ''),
                              width: 300,
                              height: 300,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: const Text('Descripción',
                                  style: TextStyle(fontSize: 18.0,
                                  fontWeight: FontWeight.bold
                                  ),
                              ),
                              subtitle: Text(plant.descripcion,
                                  style: const TextStyle(fontSize: 16.0,
                                  fontWeight: FontWeight.normal
                                  ),
                              ),
                            ),
                          ),
                          Card(
                            child: ListTile(
                              title: const Text('Usos Medicinales',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(plant.usosMedicinales,
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
