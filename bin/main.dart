import 'package:dart_juegos_calamot/models/videojuego.dart';
import 'package:dart_juegos_calamot/models/jugador.dart';
import 'package:dart_juegos_calamot/viewmodels/ControladorModeloVista.dart';
import 'package:dart_juegos_calamot/utils/askData.dart';
import 'package:dart_juegos_calamot/views/LoginVista.dart';
import 'package:dart_juegos_calamot/views/RegisterVista.dart';

void main(List<String> arguments) {
  askData.mostrarMensaje(" --- CALAMOT JUEGOS ---");

  final controlador = ControladorModeloVista();
  bool salir = false;

  while (!salir) {
    if (controlador.usuarioCorrecto == null) {
      askData.mostrarMensaje("");
      String opcion = askData.pedirString("[E] Entrar | [R] Registrar | [S] Sortir").toUpperCase();

      if (opcion == "E") {
          LoginVista.mostrarMenuLogin(controlador);
      } else if (opcion == "R") {
        vistaRegistro(controlador);
      } else if (opcion == "S") {
        salir = true;
      }
    }
  }
}
