import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import './home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: ((context, snapshot) {
        if (snapshot.hasError) {
          print('Something Went Wrong');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'CRUD',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const HomePage(),
            debugShowCheckedModeBanner: false,
          );
        }

        return const Center(
          child: CircularProgressIndicator(
            color: Colors.red,
          ),
        );
      }),
    );
  }
}
