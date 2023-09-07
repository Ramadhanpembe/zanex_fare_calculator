import 'package:flutter/material.dart';

class CheckboxItem extends StatefulWidget {
  const CheckboxItem({
    super.key,
    required this.label,
    required this.isChecked,
    required this.onChanged,
  });

  final String label;
  final bool isChecked;
  final void Function(bool?)? onChanged;

  @override
  State<CheckboxItem> createState() => _CheckboxItemState();
}

class _CheckboxItemState extends State<CheckboxItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Checkbox(
            value: widget.isChecked,
            onChanged: widget.onChanged,
          ),
        ),
        Text(widget.label),
      ],
    );
  }
}
