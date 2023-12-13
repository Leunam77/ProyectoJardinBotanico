import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jardin_botanico/views/screens/camera_screen.dart';
import 'package:jardin_botanico/views/screens/information._screen.dart';

class HomeButtonPage extends StatefulWidget {
  const HomeButtonPage({Key? key}) : super(key: key);

  @override
  HomeButtonPageState createState() => HomeButtonPageState();
}

class HomeButtonPageState extends State<HomeButtonPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home'),
    Text('Camera'),
    Text('Search'),
    Text('Information'),
  ];
  final positions = [
    const Offset(15, -12),
    const Offset(108, -12),
    const Offset(200, -12),
    const Offset(290, -12),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Button Page'),
      ),
      body: _selectedIndex == 1
        ? const QRViewExample()
        : _selectedIndex == 3
              ? InformationScreen()
              : Center(
                  child: _widgetOptions.elementAt(_selectedIndex),
                ),
      
      bottomNavigationBar: Stack(
        children: <Widget>[
          BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Inicio',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.camera_alt),
                label: 'Cámara',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Buscar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.info),
                label: 'Información',
              ),
            ],
            backgroundColor:
                const Color.fromARGB(255, 255, 0, 0), // color de fondo
            currentIndex: _selectedIndex,
            onTap: (index) {
              // switch (index) {
              //   case 1: // índice del ítem de la cámara
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => const QRViewExample()),
              //     );
              //     break;
              //   // manejar otros índices si es necesario...
              // }
              setState(() {
                _selectedIndex = index;
              });
            },

            unselectedItemColor: const Color.fromARGB(
                255, 0, 0, 0), // color de los ítems no seleccionados
            selectedItemColor: const Color.fromARGB(255, 33, 72, 243),
          ),
          Positioned(
            top: positions[_selectedIndex].dy,
            left: positions[_selectedIndex].dx,
            child: SvgPicture.asset('assets/images/barrita.svg'),
          ),
        ],
      ),
    );
  }
}
