import 'package:flutter/material.dart';
import 'package:zanex_fare_calculator/data/firestore_manager.dart';

final vehicleTypeNotifier = ValueNotifier<String>('');
final demandNotifier = ValueNotifier<String>('');
final studentNotifier = ValueNotifier<bool>(false);
final totalFareNotifier = ValueNotifier<double>(0.0);

late final FirestoreManager fm;
