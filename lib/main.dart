import 'package:flutter/material.dart';
import 'package:jardin_botanico/models/services/firebase_service.dart';
import 'package:jardin_botanico/views/screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseService();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
