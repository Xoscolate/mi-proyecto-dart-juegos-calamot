import 'dart:io';

import 'package:dart_juegos_calamot/utils/calamotException.dart';


extension EmailValidator on String {
  bool isValidEmail() {

    final emailValidaciones = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'); // esto lo he mirado por internet pero sirve para comprobar el formato del mail
    //utilizo final porque no quiero cambios en la validacion (buenas practicas).
    return emailValidaciones.hasMatch(this);
  }
}


class askData {
  static int pedirInt(String etiqueta) {
    String entrada = pedirString(etiqueta);
    int? valor = int.tryParse(entrada);

    if (valor == null) {
      throw CalamotException("Has de introducir un número entero válido.");
    }

    return valor;
  }

  static String pedirString(String etiqueta) {
    stdout.write("$etiqueta: ");
    return stdin.readLineSync() ?? "";
  }

  static void mostrarMensaje(String mensaje) {
    print(mensaje);
  }

  static void mostrarError(String error) {
    print("ERROR: $error");
  }

  static String pedirPassword(String etiqueta) {
    stdout.write("$etiqueta: ");

    stdin.echoMode = false; // Esto lo he mirado en la ia para que la contraseña no se vea cuando inciias sesion
    String password = stdin.readLineSync() ?? "";
    stdin.echoMode = true;

    print("");

    return password;
  }
}
