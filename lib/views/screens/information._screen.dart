import 'package:flutter/material.dart';
import 'package:jardin_botanico/controllers/garden_info_controller.dart';
import 'package:jardin_botanico/models/garden_info_model.dart';
import 'package:jardin_botanico/views/screens/hamgurber_menu.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InformationScreen extends StatelessWidget {
  final GardenInfoController controller = GardenInfoController();

  InformationScreen({super.key});
  Future<bool> _launchUrl(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          title: const Text(
            'Información',
            style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
          actions: <Widget>[
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return const HamburgerMenu();
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<GardenInfo?>(
        future: controller.getGardenInfo(),
        builder: (BuildContext context, AsyncSnapshot<GardenInfo?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            GardenInfo gardenInfo = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.all(8.0),
              children: <Widget>[
                Card(
                  child: ListTile(
                    title: const Center(
                      child: Text(
                        'Jardín Botánico Martín Cardenas',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    subtitle: Center(
                      child: Text(
                        gardenInfo.descripcion,
                        style: const TextStyle(
                          fontSize: 17.0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Card(
                  child: SizedBox(
                    height: 250, // Define la altura de la tarjeta
                    width: double
                        .infinity, // Hace que la tarjeta tenga el ancho máximo
                    child: Image(
                      image: NetworkImage(gardenInfo.imageURLInfo ?? ''),
                      fit: BoxFit
                          .cover, // Hace que la imagen se adapte a la tarjeta
                    ),
                  ),
                ),
                const SizedBox(height: 70),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: const Icon(FontAwesomeIcons
                              .facebook), // Asegúrate de tener un ícono de Facebook
                          onPressed: () async {
                            final url = Uri.parse(gardenInfo.linkFacebook);
                            if (!await _launchUrl(url)) {
                              throw 'Could not launch $url';
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(FontAwesomeIcons
                              .instagram), // Asegúrate de tener un ícono de Instagram
                          onPressed: () async {
                            final url = Uri.parse(gardenInfo.linkInstagram);
                            if (!await _launchUrl(url)) {
                              throw 'Could not launch $url';
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(FontAwesomeIcons
                              .tiktok), // Asegúrate de tener un ícono de TikTok
                          onPressed: () async {
                            final url = Uri.parse(gardenInfo.linkTikTok);
                            if (!await _launchUrl(url)) {
                              throw 'Could not launch $url';
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(FontAwesomeIcons
                              .phone), // Asegúrate de tener un ícono de teléfono
                          onPressed: () async {
                            final url = Uri.parse('tel:${gardenInfo.numero}');
                            if (!await _launchUrl(url)) {
                              throw 'Could not launch $url';
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(FontAwesomeIcons
                              .locationDot), // Asegúrate de tener un ícono de teléfono
                          onPressed: () async {
                            final url = Uri.parse(gardenInfo.direccionMaps);
                            if (!await _launchUrl(url)) {
                              throw 'Could not launch $url';
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Text('No data');
          }
        },
      ),
    );
  }
}
