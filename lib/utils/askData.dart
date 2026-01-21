import 'dart:io';
extension EmailValidator on String {
  bool isValidEmail() {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this); // 'this' es el String que estamos comprobando
  }
}


class askData {

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
}
