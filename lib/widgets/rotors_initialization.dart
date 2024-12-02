import 'package:cripto_rotor/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class RotorInitializationRow extends StatelessWidget {
  final List<TextEditingController> controllers;
  final double fieldWidth;

  const RotorInitializationRow({
    super.key,
    required this.controllers,
    required this.fieldWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: controllers.map((controller) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0), 
              child: SizedBox(
                width: fieldWidth,
                child: TextFieldWidget(
                  controller: controller,
                  label: '',
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(width: 20),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            '1, 2, 3 \nrespectivamente',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
