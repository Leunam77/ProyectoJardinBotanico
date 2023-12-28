import 'package:flutter/material.dart';
import 'package:jardin_botanico/models/services/firebase_service.dart';
import 'package:jardin_botanico/views/screens/home_page.dart';
import 'package:firebase_performance/firebase_performance.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseService().initializeFirebase();
  final Trace myTrace =
      (await FirebaseService.performance).newTrace('app_trace');
  await myTrace.start();

  runApp(const MyApp());
  // Detén el trazo cuando la aplicación se cierre
  WidgetsBinding.instance.addObserver(LifecycleEventHandler(
    resumeCallBack: () async => await myTrace.stop(),
  ));
}

class LifecycleEventHandler extends WidgetsBindingObserver {
  LifecycleEventHandler({required this.resumeCallBack});

  final Future Function() resumeCallBack;

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        await resumeCallBack();
        break;
      default:
        break;
    }
  }
} 

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePageScreen(),
    );
  }
}
