import 'package:cripto_rotor/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class LabeledRowWidget extends StatelessWidget {
  final String label;
  final TextEditingController rotorController; // Controlador para el cableado del rotor.
  final TextEditingController notchController; // Controlador para el notch.
  final double fieldWidth;
  final double smallFieldWidth;

  const LabeledRowWidget({
    super.key,
    required this.label,
    required this.rotorController,
    required this.notchController, // Nuevo controlador para el notch.
    required this.fieldWidth,
    required this.smallFieldWidth,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    final double fieldWidth = screenWidth * 0.64;
    final double smallFieldWidth = screenWidth * 0.22;
    
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: fieldWidth,
          child: TextFieldWidget(
            controller: rotorController,
            label: label,
          ),
        ),
        const SizedBox(width: 10),
        const Text(
          ',',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: smallFieldWidth,
          child: TextFieldWidget(
            controller: notchController,
            label: '', // Etiqueta para el notch.
          ),
        ),
      ],
    );
  }
}
