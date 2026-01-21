import 'dart:io';
import 'package:dart_juegos_calamot/utils/calamotException.dart';

import '../viewmodels/ControladorModeloVista.dart';
import 'package:dart_juegos_calamot/utils/askData.dart';

class LoginVista {
  static void mostrarMenuLogin(ControladorModeloVista controlador) {
    String mail = askData.pedirString("Correu electrònic");
    String contrasena = askData.pedirString("Contrasenya");
    try {
      controlador.entrar(mail, contrasena);
      askData.mostrarMensaje("Has iniciado Correctamente");
    } on CalamotException catch (e) {
      askData.mostrarError(e.missatge);
    } catch (e) {
      askData.mostrarError("Error inesperado: $e");
    }
  }
}