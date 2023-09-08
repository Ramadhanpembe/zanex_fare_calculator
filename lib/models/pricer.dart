class Pricer {
  const Pricer({
    required this.baseFare,
    required this.distanceRate,
    required this.timeRate,
    required this.multipliers,
  });

  final double baseFare;
  final double distanceRate;
  final double timeRate;
  // Records the values (multipliers) of constraints the user has set. Example, `{'bodaboda': 1.5}`
  final Map<String, double> multipliers;

  double calculateFare({
    double distance = 0,
    double time = 0,
    required baseFare,
    required distanceRate,
    required timeRate,
    required multipliers,

    // Records whether a user has checked or unchecked the checkbox. Example, `{'bodaboda': true}`
    Map<String, bool> variables = const {},
  }) {
    List<String> keys = [];
    for (var entry in variables.entries) {
      if (entry.value == true) {
        keys.add(entry.key);
      }
    }
    double totalFare = baseFare + (distanceRate * distance) + (timeRate * time);
    for (var key in keys) {
      totalFare *= multipliers[key] ?? 1;
    }
    totalFare *= 1.18;
    return totalFare;
  }
}

//
// bool isBodaboda = false,
//     bool isBajaji = false,
// bool isSupa = false,
//     bool isPrime = false,
// bool isAverageDemand = false,
//     bool isMediumDemand = false,
// bool isHighDemand = false,
//     bool isStudent = false,

// required this.bodabodaMultiplier,
// required this.bajajiMultiplier,
// required this.supaMultiplier,
// required this.primeMultiplier,

// final double bodabodaMultiplier;
// final double bajajiMultiplier;
// final double supaMultiplier;
// final double primeMultiplier;
