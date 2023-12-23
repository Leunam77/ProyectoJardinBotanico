import 'package:flutter/material.dart';
import 'package:jardin_botanico/views/screens/create_screen.dart';
class HamburgerMenu extends StatelessWidget {
  const HamburgerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: <Widget>[
        ListTile(
          title: const Text('Registrar planta'),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CreatePlantForm()),
            );
          },
        ),
        ListTile(
          title: const Text('Agregar Categoría'),
          onTap: () {
            // Actualiza el estado de la aplicación
            // ...
            // Luego cierra el drawer
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Editar planta'),
          onTap: () {
            // Actualiza el estado de la aplicación
            // ...
            // Luego cierra el drawer
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: const Text('Descargar QR'),
          onTap: () {
            // Actualiza el estado de la aplicación
            // ...
            // Luego cierra el drawer
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
