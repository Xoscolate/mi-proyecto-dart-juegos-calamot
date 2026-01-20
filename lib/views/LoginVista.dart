import 'dart:io';
import '../viewmodels/ControladorModeloVista.dart';

class LoginView {
  static void mostrarMenuLogin(ControladorModeloVista controlador) {
    print("\n--- INICIO DE SESIÓN ---");
    stdout.write("Introduce tu e-mail para entrar: ");

    String email = stdin.readLineSync() ?? "";

    controlador.verificarFormatoEmail(email);


    bool exito = controlador.entrar(email);

    if (exito) {
      print("Login correcto");

    } else {
      print("Error: El usuario no existe. Inténtalo de nuevo.");
    }
  }
}