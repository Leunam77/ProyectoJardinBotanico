import 'package:flutter/material.dart';
import 'package:jardin_botanico/controllers/plant_controller.dart';
import 'package:jardin_botanico/models/plant_model.dart';
import 'package:jardin_botanico/views/screens/plant_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:logging/logging.dart';
import 'dart:async';

class QRViewExample extends StatefulWidget {
  final PlantModel? plant;

  const QRViewExample({super.key, this.plant});

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final _logger = Logger('CameraScreen');
  final PlantController plantController = PlantController();
  bool showIcon = false;
  String plantName = 'No disponible';
  Timer? _timer;
  bool lastScanValida = true;
  // In QRViewExampleState
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if (scanData.code != null) {
        try {
          bool esValida = await plantController.esPlantaValida(scanData.code!);
          String nombreCientifico = '';
          if (esValida) {
            nombreCientifico =
                await plantController.obtenerNombreCientifico(scanData.code!);
          }

          setState(() {
            result = scanData;
            lastScanValida = esValida;
            if (esValida) {
              plantName = nombreCientifico;
              showIcon = true;
              _timer?.cancel();

              // Inicia un nuevo temporizador
              _timer = Timer(const Duration(seconds: 6), () {
                setState(() {
                  showIcon = false;
                });
              });
            } else {
              plantName = 'No disponible';
              showIcon = false;
            }
          });
        } catch (e) {
          _logger.warning('Error al escanear: ${e.toString()}');
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0), // Cambia la altura aquí
        child: AppBar(
          title: const Text(
            'Escaner de código QR',
            style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: const Color.fromARGB(255, 6, 168, 0),
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 350,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              // Agrega este widget
              color: const Color.fromARGB(
                  255, 23, 57, 0), // Establece el color de fondo a verde
              child: Center(
                child: (result != null)
                    ? SizedBox(
                        width: 230,
                        child: showIcon
                            ? FloatingActionButton(
                                onPressed: () {
                                  if (result != null && result!.code != null) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PlantScreen(plantId: result!.code!),
                                      ),
                                    );
                                  } else {
                                    // Maneja el caso en que result.code es null
                                    _logger
                                        .warning('El código escaneado es null');
                                  }
                                },
                                backgroundColor:
                                    const Color.fromARGB(255, 43, 105, 1),
                                child: Text(
                                  'Nombre: $plantName',
                                  overflow:
                                      TextOverflow.ellipsis, // Añade esta línea
                                  style: const TextStyle(
                                      color: Colors
                                          .white), // Establece el color del texto a blanco
                                ),
                              )
                            : Center(
                                child: Text(
                                  lastScanValida
                                      ? 'Esperando escaner...'
                                      : "Código no válido",
                                  style: const TextStyle(
                                      color: Colors
                                          .white), // Establece el color del texto a blanco
                                ),
                              ),
                      )
                    : const Text(
                        'Esperando escaner...',
                        style: TextStyle(
                            color: Colors
                                .white), // Establece el color del texto a blanco
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    _timer?.cancel();
    super.dispose();
  }
}
