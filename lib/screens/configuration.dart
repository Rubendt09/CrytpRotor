import 'package:cripto_rotor/enigma.dart';
import 'package:cripto_rotor/screens/crypto_rotor';
import 'package:cripto_rotor/widgets/custom_button.dart';
import 'package:cripto_rotor/widgets/custom_text_field.dart';
import 'package:cripto_rotor/widgets/label_row_rotors.dart';
import 'package:cripto_rotor/widgets/rotors_initialization.dart';
import 'package:flutter/material.dart';

class RotorConfigScreen extends StatelessWidget {
  RotorConfigScreen({super.key});

  // Controladores para los campos de configuración
  final TextEditingController _rotor1Controller = TextEditingController();
  final TextEditingController _rotor2Controller = TextEditingController();
  final TextEditingController _rotor3Controller = TextEditingController();

  final TextEditingController _rotor1NotchController = TextEditingController();
  final TextEditingController _rotor2NotchController = TextEditingController();
  final TextEditingController _rotor3NotchController = TextEditingController();

  final TextEditingController _reflectorController = TextEditingController();
  final List<TextEditingController> _initializationControllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double smallFieldWidth = screenWidth * 0.2;
    final double fieldWidth = screenWidth * 0.64;
    final double buttonWidth = screenWidth * 0.6;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00264D), Color(0xFF005680)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Configuración de los rotores',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                LabeledRowWidget(
                  label: 'Rotor 1',
                  rotorController: _rotor1Controller,
                  notchController: _rotor1NotchController,
                  smallFieldWidth: smallFieldWidth,
                  fieldWidth: fieldWidth,
                ),
                const SizedBox(height: 20),
                LabeledRowWidget(
                  label: 'Rotor 2',
                  rotorController: _rotor2Controller,
                  notchController: _rotor2NotchController,
                  smallFieldWidth: smallFieldWidth,
                  fieldWidth: fieldWidth,
                ),
                const SizedBox(height: 20),
                LabeledRowWidget(
                  label: 'Rotor 3',
                  rotorController: _rotor3Controller,
                  notchController: _rotor3NotchController,
                  smallFieldWidth: smallFieldWidth,
                  fieldWidth: fieldWidth,
                ),
                const SizedBox(height: 20),
                TextFieldWidget(
                  controller: _reflectorController,
                  label: 'Reflector',
                ),
                const SizedBox(height: 20),
                const Text(
                  'Inicio de los rotores',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                RotorInitializationRow(
                  controllers: _initializationControllers,
                  fieldWidth: 80,
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: buttonWidth,
                  child: ButtonWidget(
                    label: 'Guardar Cambios',
                    onPressed: () {
                      // Crear configuración de Enigma basada en los datos del usuario
                      final updatedEnigma = Enigma(
                        [
                          Rotor(_rotor1Controller.text, _rotor1NotchController.text),
                          Rotor(_rotor2Controller.text, _rotor2NotchController.text),
                          Rotor(_rotor3Controller.text, _rotor3NotchController.text),
                        ],
                        Reflector(_reflectorController.text),
                        Plugboard({}), // Sin conexiones de plugboard para este ejemplo
                      );

                      updatedEnigma.setRotorPositions(
                        _initializationControllers.map((c) => c.text).toList(),
                      );

                      // Navegar a la pantalla de cifrado
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CryptoRotorScreen(enigma: updatedEnigma),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
