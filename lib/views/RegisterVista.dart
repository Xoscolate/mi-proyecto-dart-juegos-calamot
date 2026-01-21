import 'package:dart_juegos_calamot/viewmodels/ControladorModeloVista.dart';

import '../models/jugador.dart';
import '../utils/askData.dart';
import '../utils/calamotException.dart';
import 'package:dart_juegos_calamot/viewmodels/ControladorModeloVista.dart';
import 'package:dart_juegos_calamot/utils/askData.dart';

void vistaRegistro(ControladorModeloVista controlador) {
  String email = askData.pedirString("Email");
  String nick = askData.pedirString("Nick");
  String pass = askData.pedirString("Contrasenya");

  try {
    controlador.registrar(email, nick, pass);
    askData.mostrarMensaje("Usuari $nick creat con éxito.");
  } on CalamotException catch (e) {
    askData.mostrarError(e.missatge);
  }
}