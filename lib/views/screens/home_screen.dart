import 'package:flutter/material.dart';
import 'package:jardin_botanico/controllers/plant_controller.dart';
import 'package:jardin_botanico/models/plant_model.dart';
import 'package:jardin_botanico/views/screens/plant_screen.dart';

class HomePagePlants extends StatelessWidget {
  final PlantController plantController = PlantController();

  HomePagePlants({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          title: const Text(
            'Inicio',
            style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
      ),
      body: FutureBuilder<List<PlantModel>>(
        future: plantController.getLatestPlants(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Ultimas plantas agregadas',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: snapshot.data!.map((plant) {
                      return Card(
                        color: const Color.fromARGB(255, 16, 71, 9),
                        child: Column(
                          children: <Widget>[
                            Text(
                              plant.nombreColoquial[0],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Image.network(
                              plant.imageUrl!,
                              width: 100,
                              height: 100,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PlantScreen(plantId: plant.id!)),
                                );
                              },
                              child: const Icon(
                                Icons.arrow_forward,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
