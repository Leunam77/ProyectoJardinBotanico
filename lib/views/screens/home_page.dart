import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jardin_botanico/views/screens/home_button.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);
  @override
  HomePageScreenState createState() => HomePageScreenState();
}

class HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Transform.scale(
              scale: 1.5,
              child: Image.asset(
                  'assets/images/sylvain-sarrailh-undertheleafs.jpg'),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return SvgPicture.asset(
                  'assets/images/figuraHomePage.svg',
                  width: constraints.maxWidth,
                );
              },
            ),
          ),
          const Positioned(
            top: 530,
            right: 0,
            left: 0,
            child: Center(
              child: SizedBox(
                width: 308,
                height: 86,
                child: Center(
                  child: Text(
                    'Jardín Botánico \n “Martín Cárdenas”',
                    style: TextStyle(
                      fontFamily: 'Lexend',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                      fontSize: 28,
                      height: 35 / 28,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          const Positioned(
            top: 530 + 80,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 236,
                height: 40,
                child: Center(
                  child: Text(
                    'Abre la puerta al paraíso botánico de Cochabamba',
                    style: TextStyle(
                      fontFamily: 'Lexend',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      height: 20 / 16,
                      color: Color(0xFF91A37F),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 530 + 80 + 100,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeButtonPage(),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xFF569033)),
                  overlayColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return const Color(0xFF457025);
                      }
                      return Colors.transparent;
                    },
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  elevation: MaterialStateProperty.all(5), // Sombra
                ),
                child: const Text(
                  'Empezar',
                  style: TextStyle(
                    fontFamily: 'Lexend',
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
