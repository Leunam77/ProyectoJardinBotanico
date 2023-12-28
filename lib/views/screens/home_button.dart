import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jardin_botanico/views/screens/camera_screen.dart';
import 'package:jardin_botanico/views/screens/home_screen.dart';
import 'package:jardin_botanico/views/screens/information._screen.dart';
import 'package:jardin_botanico/views/screens/search_plants.dart';

class HomeButtonPage extends StatefulWidget {
  const HomeButtonPage({Key? key}) : super(key: key);

  @override
  HomeButtonPageState createState() => HomeButtonPageState();
}

class HomeButtonPageState extends State<HomeButtonPage> {
  int _selectedIndex = 0;
  final positions = [
    const Offset(15, -13),
    const Offset(107, -13),
    const Offset(195, -13),
    const Offset(285, -13),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedIndex == 1
          ? const QRViewExample()
          : _selectedIndex == 3
              ? InformationScreen()
              : _selectedIndex == 2
                  ? const SearchPlantsPage()
                  : _selectedIndex == 0
                      ? HomePagePlants()
                      : const Text('Error'),
      bottomNavigationBar: Stack(
        children: <Widget>[
          Theme(
            data: Theme.of(context).copyWith(
              canvasColor: const Color.fromARGB(255, 23, 57, 0),
            ),
            child: BottomNavigationBar(
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
                  icon: Icon(Icons.info_outline_rounded),
                  label: 'Información',
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              unselectedItemColor: const Color.fromARGB(255, 245, 245, 245),
              selectedItemColor: const Color.fromARGB(255, 182, 227, 0),
            ),
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
