// rotor.dart
class Rotor {
  final String alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final String wiring;
  final String notch;
  int position = 0;

  Rotor(this.wiring, this.notch);

  void setPosition(String positionChar) {
    position = alphabet.indexOf(positionChar);
  }

  String encode(String letter, {bool reverse = false}) {
    int letterIdx = (alphabet.indexOf(letter) + position) % 26;
    if (reverse) {
      // Decodificación
      letterIdx = wiring.indexOf(alphabet[letterIdx]);
      return alphabet[(letterIdx - position + 26) % 26];
    } else {
      // Codificación
      letter = wiring[letterIdx];
      return alphabet[(alphabet.indexOf(letter) - position + 26) % 26];
    }
  }

  bool step() {
    position = (position + 1) % 26;
    return position == alphabet.indexOf(notch);
  }
}

// reflector.dart
class Reflector {
  final String alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final String wiring;

  Reflector(this.wiring);

  String reflect(String letter) {
    int idx = alphabet.indexOf(letter);
    return wiring[idx];
  }
}

// plugboard.dart
class Plugboard {
  final Map<String, String> wiring;

  Plugboard([Map<String, String>? wiring]) : wiring = wiring ?? {};

  String swap(String letter) {
    return wiring[letter] ?? letter;
  }
}

class Enigma {
  final List<Rotor> rotors;
  Reflector reflector;
  Plugboard plugboard;
  final String alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

  Enigma(this.rotors, this.reflector, this.plugboard);

  void setRotorPositions(List<String> positions) {
    for (int i = 0; i < rotors.length; i++) {
      rotors[i].setPosition(positions[i]);
    }
  }

  String process(String text) {
    String result = '';

    for (var char in text.split('')) {
      if (!alphabet.contains(char)) {
        result += char;
        continue;
      }

      // Paso 1: Plugboard inicial
      char = plugboard.swap(char);

      // Paso 2: A través de los rotores (derecha a izquierda)
      for (var rotor in rotors.reversed) {
        char = rotor.encode(char);
      }

      // Paso 3: A través del reflector
      char = reflector.reflect(char);

      // Paso 4: A través de los rotores (izquierda a derecha)
      for (var rotor in rotors) {
        char = rotor.encode(char, reverse: true);
      }

      // Paso 5: Plugboard final
      char = plugboard.swap(char);

      result += char;

      // Paso 6: Avanzar rotores
      stepRotors();
    }
    return result;
  }

  void stepRotors() {
    bool carry = true;
    for (var rotor in rotors) {
      if (carry) {
        carry = rotor.step();
      } else {
        break;
      }
    }
  }
}
