import 'package:flutter/material.dart';
import 'package:zanex_fare_calculator/models/global_resources.dart';

import 'checkbox_item.dart';

class VehicleCheckboxGroup extends StatefulWidget {
  const VehicleCheckboxGroup({Key? key}) : super(key: key);

  @override
  State<VehicleCheckboxGroup> createState() => _VehicleCheckboxGroupState();
}

class _VehicleCheckboxGroupState extends State<VehicleCheckboxGroup> {
  Map<int, bool> states = {
    1: false,
    2: false,
    3: false,
    4: false,
  };
  List<String> labels = ['bodaboda', 'bajaji', 'supa', 'prime'];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'VEHICLE TYPE',
            style: TextStyle(
              color: Colors.indigo,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        CheckboxItem(
            label: 'Bodaboda',
            isChecked: states[1]!,
            onChanged: (value) => handleCheckboxChange(value!, 1)),
        CheckboxItem(
          label: 'Bajaji',
          isChecked: states[2]!,
          onChanged: (value) => handleCheckboxChange(value!, 2),
        ),
        CheckboxItem(
          label: 'Supa',
          isChecked: states[3]!,
          onChanged: (value) => handleCheckboxChange(value!, 3),
        ),
        CheckboxItem(
          label: 'Prime',
          isChecked: states[4]!,
          onChanged: (value) => handleCheckboxChange(value!, 4),
        ),
      ],
    );
  }

  void handleCheckboxChange(bool newValue, int checkboxID) {
    setState(() {
      states[1] = false;
      states[2] = false;
      states[3] = false;
      states[4] = false;

      for (var state in states.entries) {
        if (state.key == checkboxID) {
          if (newValue) {
            states[checkboxID] = true;
            vehicleTypeNotifier.value = labels[checkboxID - 1];
          } else {
            states[checkboxID] = false;
          }
        }
      }
    });
  }
}
