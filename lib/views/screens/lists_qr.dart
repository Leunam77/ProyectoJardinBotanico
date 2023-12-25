import 'package:flutter/material.dart';
import 'package:jardin_botanico/controllers/plant_controller.dart';
import 'package:jardin_botanico/models/plant_model.dart';
import 'package:logging/logging.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';

final _logger = Logger('PlantListScreenState');

class PlantListScreen extends StatefulWidget {
  const PlantListScreen({Key? key}) : super(key: key);

  @override
  PlantListScreenState createState() => PlantListScreenState();
}

class PlantListScreenState extends State<PlantListScreen> {
  final PlantController plantController = PlantController();

  Future<void> downloadQR(PlantModel plant) async {
    Dio dio = Dio();
    try {
      // Solicita el permiso de almacenamiento
      PermissionStatus status = await Permission.storage.request();

      // Si el permiso no fue concedido, retorna
      if (!status.isGranted) {
        _logger.warning('Permiso de almacenamiento no concedido');
        return;
      }

      // Permite al usuario seleccionar un directorio
      String? path = await FilePicker.platform.getDirectoryPath();

      if (path == null) {
        _logger.warning('Selección de directorio cancelada');
        return;
      }

      // Crea la ruta del archivo
      String filePath = '$path/${plant.id}.png';

      // Descarga la imagen y guárdala en el archivo
      if (plant.qrCodeUrl == null) {
        _logger.warning('plant.qrCodeUrl es null');
        return;
      }
      await dio.download(plant.qrCodeUrl!, filePath);

      _logger.info('Imagen descargada y guardada en $filePath');
    } catch (e) {
      _logger.severe('Error al descargar la imagen: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0), // Cambia la altura aquí
        child: AppBar(
          title: const Text(
            'Descargar códigos QR',
            style: TextStyle(fontSize: 19.0,
            fontWeight: FontWeight.bold,),
          ),
          centerTitle: true,
        ),
      ),
      body: StreamBuilder<List<PlantModel>>(
        stream: plantController.getPlants(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final plant = snapshot.data![index];
              return ListTile(
                leading: Image.network(plant.imageUrl ?? ''),
                title: Text(plant.nombreColoquial.isNotEmpty
                    ? plant.nombreColoquial[0]
                    : 'Sin nombre'),
                trailing: IconButton(
                  icon: const Icon(Icons.download),
                  onPressed: () => downloadQR(plant),
                ),
              );
            },
          );
        },
      ),
    );
  }
}