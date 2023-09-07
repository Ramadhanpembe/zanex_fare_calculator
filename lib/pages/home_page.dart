import 'dart:convert';
import 'dart:developer';
import 'dart:html' as html;
import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:zanex_fare_calculator/models/global_resources.dart';
import 'package:zanex_fare_calculator/models/pricer.dart';
import 'package:zanex_fare_calculator/models/trip.dart';
import 'package:zanex_fare_calculator/widgets/demand_checkbox_group.dart';
import 'package:zanex_fare_calculator/widgets/vehicle_checkbox_group.dart';

import '../widgets/input_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _baseFareController = TextEditingController();
  final _distanceRateController = TextEditingController();
  final _timeRateController = TextEditingController();
  final _bodabodaController = TextEditingController();
  final _bajajiController = TextEditingController();
  final _supaController = TextEditingController();
  final _primeController = TextEditingController();
  final _averageController = TextEditingController();
  final _mediumController = TextEditingController();
  final _highController = TextEditingController();
  final _studentController = TextEditingController();
  final _distanceTravelledController = TextEditingController();
  final _timeTakenController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'CONSTRAINTS',
            style: TextStyle(
              color: Colors.indigo,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: InputField(
                label: 'Base fare',
                controller: _baseFareController,
              ),
            ),
            Expanded(
              child: InputField(
                label: 'Distance rate',
                controller: _distanceRateController,
              ),
            ),
            Expanded(
              child: InputField(
                label: 'Time rate',
                controller: _timeRateController,
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Vehicle type multipliers',
            style: TextStyle(
              color: Colors.indigo,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: InputField(
                label: 'Bodaboda',
                controller: _bodabodaController,
                // padding: 4.0,
              ),
            ),
            Expanded(
              child: InputField(
                label: 'Bajaji',
                controller: _bajajiController,
                // padding: 4.0,
              ),
            ),
            Expanded(
              child: InputField(
                label: 'Supa',
                controller: _supaController,
                // padding: 4.0,
              ),
            ),
            Expanded(
              child: InputField(
                label: 'Prime',
                controller: _primeController,
                // padding: 4.0,
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Demand multipliers',
            style: TextStyle(
              color: Colors.indigo,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: InputField(
                label: 'Average',
                controller: _averageController,
              ),
            ),
            Expanded(
              child: InputField(
                label: 'Medium',
                controller: _mediumController,
              ),
            ),
            Expanded(
              child: InputField(
                label: 'High',
                controller: _highController,
              ),
            ),
            Expanded(
              child: InputField(
                label: 'Student multiplier',
                controller: _studentController,
              ),
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'VALUES',
            style: TextStyle(
              color: Colors.indigo,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: InputField(
                label: 'Distance travelled',
                controller: _distanceTravelledController,
              ),
            ),
            Expanded(
              child: InputField(
                label: 'Time taken',
                controller: _timeTakenController,
              ),
            ),
          ],
        ),
        Row(
          children: const [
            Expanded(child: VehicleCheckboxGroup()),
            Expanded(child: DemandCheckboxGroup()),
          ],
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 24.0, bottom: 12.0),
            child: ValueListenableBuilder(
              valueListenable: totalFareNotifier,
              builder: (_, fare, __) {
                return Text(
                  'Fare: ${fare.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                );
              },
            ),
          ),
        ),
        ValueListenableBuilder(
          valueListenable: vehicleTypeNotifier,
          builder: (_, vehicle, __) {
            return ValueListenableBuilder(
              valueListenable: demandNotifier,
              builder: (_, demand, __) {
                return ValueListenableBuilder(
                  valueListenable: studentNotifier,
                  builder: (_, isStudent, __) {
                    Map<String, double> multipliers = {
                      'bodaboda': double.tryParse(_bodabodaController.text) ?? 0.0,
                      'bajaji': double.tryParse(_bajajiController.text) ?? 0.0,
                      'supa': double.tryParse(_supaController.text) ?? 0.0,
                      'prime': double.tryParse(_primeController.text) ?? 0.0,
                      'average': double.tryParse(_averageController.text) ?? 0.0,
                      'medium': double.tryParse(_mediumController.text) ?? 0.0,
                      'high': double.tryParse(_highController.text) ?? 0.0,
                      'student': double.tryParse(_studentController.text) ?? 0.0,
                    };
                    final pricer = initPricer(vehicle, demand, isStudent, multipliers);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0, right: 12.0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(const Size(400, 50))),
                              child: const Text('CALCULATE FARE'),
                              onPressed: () {
                                //  call calculate method of pricer
                                Map<String, bool> variables = {
                                  vehicle: true,
                                  demand: true,
                                  'student': isStudent,
                                };
                                totalFareNotifier.value = pricer.calculateFare(
                                  distance:
                                      double.tryParse(_distanceTravelledController.text) ?? 0.0,
                                  time: double.tryParse(_timeTakenController.text) ?? 0.0,
                                  variables: variables,
                                );
                              },
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(const Size(400, 50))),
                              child: const Text('SAVE TRIP'),
                              onPressed: () {
                                //  save the trip to a .csv file
                                saveTrip(vehicle, demand, isStudent, multipliers);
                              },
                            ),
                          ),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 12.0, left: 12.0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(const Size(400, 50))),
                              child: const Text('DOWNLOAD FILE'),
                              onPressed: () async {
                                List<Trip> trips = await fm.getAllTrips();
                                downloadTrips(trips);
                                //  save the trip to a file or database, check which is easy!
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }

  Pricer initPricer(
      String vehicle, String demand, bool isStudent, Map<String, double> multipliers) {
    return Pricer(
      baseFare: double.tryParse(_baseFareController.text) ?? 0.0,
      distanceRate: double.tryParse(_distanceRateController.text) ?? 0.0,
      timeRate: double.tryParse(_timeRateController.text) ?? 0.0,
      multipliers: multipliers,
    );
  }

  void saveTrip(String vehicle, String demand, bool isStudent, Map<String, double> multipliers) {
    final trip = Trip(
      baseFare: double.tryParse(_baseFareController.text) ?? 0.0,
      distanceRate: double.tryParse(_distanceRateController.text) ?? 0.0,
      timeRate: double.tryParse(_timeRateController.text) ?? 0.0,
      distance: double.tryParse(_distanceTravelledController.text) ?? 0.0,
      time: double.tryParse(_timeTakenController.text) ?? 0.0,
      demand: demand.toUpperCase(),
      demandMultiplier: multipliers[demand]!,
      vehicle: vehicle.toUpperCase(),
      vehicleMultiplier: multipliers[vehicle]!,
      isStudent: isStudent,
      totalFare: totalFareNotifier.value,
    );
    fm.saveTrip(trip);
  }

  void downloadTrips(List<Trip> trips) {
    List<List<dynamic>> data = [
      [
        'Base Fare',
        'Distance Rate',
        'Time Rate',
        'Distance',
        'Time',
        'Demand',
        'Demand Multiplier',
        'Vehicle',
        'Vehicle Multiplier',
        'Is_Student',
        'Total Fare'
      ],
    ];

    for (var trip in trips) {
      data.add(
        [
          trip.baseFare,
          trip.distanceRate,
          trip.timeRate,
          trip.distance,
          trip.time,
          trip.demand,
          trip.demandMultiplier,
          trip.vehicle,
          trip.vehicleMultiplier,
          trip.isStudent,
          trip.totalFare,
        ],
      );
    }

    // write the data to a csv file
    final csvData = const ListToCsvConverter().convert(data);
    log(csvData);

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final filename = 'trips_$timestamp.csv';

    final blob = html.Blob([Uint8List.fromList((utf8.encode(csvData)))]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.AnchorElement(href: url)
      ..setAttribute('download', filename)
      ..click();
    html.Url.revokeObjectUrl(url);
  }
}
