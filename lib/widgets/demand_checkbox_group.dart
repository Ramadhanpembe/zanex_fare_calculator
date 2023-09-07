import 'package:flutter/material.dart';
import 'package:zanex_fare_calculator/models/global_resources.dart';

import 'checkbox_item.dart';

class DemandCheckboxGroup extends StatefulWidget {
  const DemandCheckboxGroup({Key? key}) : super(key: key);

  @override
  State<DemandCheckboxGroup> createState() => _DemandCheckboxGroupState();
}

class _DemandCheckboxGroupState extends State<DemandCheckboxGroup> {
  Map<int, bool> states = {
    1: false,
    2: false,
    3: false,
  };
  bool isChecked = false;
  List<String> labels = ['average', 'medium', 'high'];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'DEMAND',
            style: TextStyle(
              color: Colors.indigo,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        CheckboxItem(
          label: 'Average',
          isChecked: states[1]!,
          onChanged: (value) => handleCheckboxChange(value!, 1),
        ),
        CheckboxItem(
          label: 'Medium',
          isChecked: states[2]!,
          onChanged: (value) => handleCheckboxChange(value!, 2),
        ),
        CheckboxItem(
          label: 'High',
          isChecked: states[3]!,
          onChanged: (value) => handleCheckboxChange(value!, 3),
        ),
        CheckboxItem(
          label: 'Student',
          isChecked: isChecked,
          onChanged: (value) => handleCheckboxChange(value!, 100),
        ),
      ],
    );
  }

  void handleCheckboxChange(bool newValue, int checkboxID) {
    if (checkboxID == 100) {
      studentNotifier.value = newValue;
      setState(() => isChecked = newValue);
      return;
    }

    setState(() {
      states[1] = false;
      states[2] = false;
      states[3] = false;

      for (var state in states.entries) {
        if (state.key == checkboxID) {
          if (newValue) {
            states[checkboxID] = true;
            demandNotifier.value = labels[checkboxID - 1];
          } else {
            states[checkboxID] = false;
          }
        }
      }
    });
  }
}
