class Trip {
  const Trip({
    required this.baseFare,
    required this.distanceRate,
    required this.timeRate,
    required this.distance,
    required this.time,
    required this.demand,
    required this.demandMultiplier,
    required this.vehicle,
    required this.vehicleMultiplier,
    required this.isStudent,
    required this.totalFare,
  });
  final double baseFare;
  final double distanceRate;
  final double timeRate;
  final double distance;
  final double time;
  final String demand;
  final double demandMultiplier;
  final String vehicle;
  final double vehicleMultiplier;
  final bool isStudent;
  final double totalFare;
}
