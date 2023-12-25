import 'package:flutter/material.dart';
import 'package:jardin_botanico/models/plant_model.dart';
import 'package:jardin_botanico/controllers/plant_controller.dart';
import 'package:jardin_botanico/models/category_model.dart';
import 'package:jardin_botanico/controllers/category_controller.dart';

class SearchPlantsPage extends StatefulWidget {
  const SearchPlantsPage({super.key});

  @override
  SearchPlantsPageState createState() => SearchPlantsPageState();
}

class SearchPlantsPageState extends State<SearchPlantsPage> {
  final PlantController plantController = PlantController();
  final CategoryController categoryController = CategoryController();
  String search = '';
  List<PlantModel> plants = [];
  List<PlantModel> searchResults = [];
  Map<String, Category> categories = {};

  void searchPlants() {
    searchResults = plants
        .where((plant) =>
            plant.nombreColoquial.any((name) => name.contains(search)) ||
            plant.categoriesIds.any((id) =>
                categories[id]?.nombreCategoria.contains(search) ?? false))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          title: const Text(
            'Buscador',
            style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  search = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Buscar',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      searchPlants();
                    });
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final plant = searchResults[index];
                return ListTile(
                  leading: Image.network(plant.imageUrl ?? ''),
                  title: Text(plant.nombreColoquial.first),
                  subtitle: Text(
                      categories[plant.categoriesIds.first]?.nombreCategoria ??
                          ''),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    plantController.getPlants().listen((data) {
      setState(() {
        plants = data;
      });
    });
    categoryController.getCategories().then((data) {
      setState(() {
        categories = {
          for (var category in data)
            if (category.id != null) category.id!: category
        };
      });
    });
  }
}
