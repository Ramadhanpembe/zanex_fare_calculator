import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/trip.dart';

class FirestoreManager {
  late final FirebaseFirestore _db;

  FirestoreManager() {
    _init();
  }

  void _init() => _db = FirebaseFirestore.instance;

  void saveTrip(Trip trip) async {
    await _db.collection('trips').add({
      'base_fare': trip.baseFare,
      'distance_rate': trip.distanceRate,
      'time_rate': trip.timeRate,
      'distance': trip.distance,
      'time': trip.time,
      'demand': trip.demand,
      'demand_multiplier': trip.demandMultiplier,
      'vehicle': trip.vehicle,
      'vehicle_multiplier': trip.vehicleMultiplier,
      'is_student': trip.isStudent,
      'total_fare': trip.totalFare,
    });
  }

  Future<List<Trip>> getAllTrips() async {
    List<Trip> trips = [];
    final CollectionReference tripColRef = _db.collection('trips');
    final QuerySnapshot querySnapshot = await tripColRef.get();
    final List<QueryDocumentSnapshot> tripDocs = querySnapshot.docs;
    for (var doc in tripDocs) {
      trips.add(
        Trip(
          baseFare: doc['base_fare'],
          distanceRate: doc['distance_rate'],
          timeRate: doc['time_rate'],
          distance: doc['distance'],
          time: doc['time'],
          demand: doc['demand'],
          demandMultiplier: doc['demand_multiplier'],
          vehicle: doc['vehicle'],
          vehicleMultiplier: doc['vehicle_multiplier'],
          isStudent: doc['is_student'],
          totalFare: doc['total_fare'],
        ),
      );
    }
    return trips;
  }
}
