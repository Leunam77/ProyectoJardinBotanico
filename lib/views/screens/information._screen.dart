import 'package:flutter/material.dart';
import 'package:jardin_botanico/controllers/garden_info_controller.dart';
import 'package:jardin_botanico/models/garden_info_model.dart';

class InformationScreen extends StatelessWidget {
  final GardenInfoController controller = GardenInfoController();

  InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GardenInfo?>(
      future: controller.getGardenInfo(),
      builder: (BuildContext context, AsyncSnapshot<GardenInfo?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          GardenInfo gardenInfo = snapshot.data!;
          return ListView(
            children: <Widget>[
              Text('Numero: ${gardenInfo.numero}'),
              Text('Direccion: ${gardenInfo.direccionMaps}'),
              Text('Facebook: ${gardenInfo.linkFacebook}'),
              Text('Instagram: ${gardenInfo.linkInstagram}'),
              Text('TikTok: ${gardenInfo.linkTikTok}'),
              Text('Descripción: ${gardenInfo.descripcion}'),
              Image(image: NetworkImage(gardenInfo.imageURLInfo ?? '')),
              // Añade aquí más campos según sea necesario
            ],
          );
        } else {
          return const Text('No data');
        }
      },
    );
  }
}
