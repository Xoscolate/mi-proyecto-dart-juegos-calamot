import 'package:dart_juegos_calamot/views/TiendaVista.dart';
import '../viewmodels/ControladorModeloVista.dart';
import '../utils/askData.dart';
import '../utils/calamotException.dart';
import '../models/videojuego.dart';
import 'package:dart_juegos_calamot/models/Licencia.dart';
import 'package:dart_juegos_calamot/models/TiposLicencia.dart';


class Anadiramigos {
  static void anadirAmigos (ControladorModeloVista controlador){
  askData.mostrarMensaje("-- ANADIR AMIGOS --");
  askData.mostrarMensaje("Que amigo quieres añadir");
  String email = askData.pedirString("");
  controlador.anadirAmigo(email);
  askData.mostrarMensaje("Amigo añadido...");

}
}