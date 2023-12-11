import 'package:flutter/material.dart';
import 'package:jardin_botanico/views/widgets/icon_nav.dart'; 
import 'package:flutter_svg/flutter_svg.dart';


class HomeButtonPage extends StatefulWidget {
  const HomeButtonPage({Key? key}) : super(key: key);

  @override
  HomeButtonPageState createState() => HomeButtonPageState();
}

class HomeButtonPageState extends State<HomeButtonPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Home'),
    Text('Business'),
    Text('School'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Button Page'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
     bottomNavigationBar: Stack(
        children: [
          BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'Business',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school),
                label: 'School',
              ),
              // ... otros items
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          ),
          Positioned(
            bottom: 0,
            left: _selectedIndex *
                60.0, // Ajusta este valor según el tamaño de tus íconos y el espaciado que desees
            child: SvgPicture.asset('assets/images/barrita.svg'),
          ),
        ],
      ),
    );
  }
}
