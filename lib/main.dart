import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zanex_fare_calculator/data/firestore_manager.dart';
import 'package:zanex_fare_calculator/firebase_options.dart';
import 'package:zanex_fare_calculator/pages/home_page.dart';

import 'models/global_resources.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  fm = FirestoreManager();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontalScrollController = ScrollController();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zanex Fare Calculator',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Zanex Fare Calculator'),
          centerTitle: true,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Scrollbar(
              controller: horizontalScrollController,
              trackVisibility: true,
              thumbVisibility: true,
              thickness: 7.0,
              radius: const Radius.circular(5.0),
              interactive: true,
              child: SingleChildScrollView(
                controller: horizontalScrollController,
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: 1400,
                  height: 600,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
                  child: const HomePage(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
