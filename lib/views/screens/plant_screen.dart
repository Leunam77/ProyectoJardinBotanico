import 'package:flutter/material.dart';
import 'package:jardin_botanico/controllers/plant_controller.dart';
import 'package:jardin_botanico/models/plant_model.dart';

class PlantScreen extends StatefulWidget {
  final String plantId;
  final PlantModel? plant;
  const PlantScreen({super.key, required this.plantId, this.plant});

  @override
  PlantScreenState createState() => PlantScreenState();
}

class PlantScreenState extends State<PlantScreen> {
  late PlantController plantController;
  late Future<PlantModel> plant;

  @override
  void initState() {
    super.initState();
    plantController = PlantController();
    plant = plantController.getPlant(widget.plantId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PlantModel>(
      future: plant,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          PlantModel plant = snapshot.data!;
          return Card(
            child: Column(
              children: <Widget>[
                Text('Nombre Científico: ${plant.nombreCientifico}'),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: plant.nombreColoquial.length,
                  itemBuilder: (context, index) {
                    return Text(
                        'Nombre Coloquial ${index + 1}: ${plant.nombreColoquial[index]}');
                  },
                ),
                Text('Descripción: ${plant.descripcion}'),
                Text('Usos Medicinales: ${plant.usosMedicinales}'),
                Image(image: NetworkImage(plant.imageUrl ?? '')),
              ],
            ),
          );
        }
      },
    );
  }
}
