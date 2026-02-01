import 'package:dart_juegos_calamot/views/TiendaVista.dart';

import '../viewmodels/ControladorModeloVista.dart';
import '../utils/askData.dart';
import '../utils/calamotException.dart';
import '../models/Videojuego.dart';
import 'package:dart_juegos_calamot/models/Licencia.dart';
import 'package:dart_juegos_calamot/models/TiposLicencia.dart';
import 'package:dart_juegos_calamot/models/Jugador.dart';
import '../utils/askData.dart';



class Crearpuntuacionvista {
  static void CrearPuntuacion(ControladorModeloVista controlador) {

  var puntuacion = askData.pedirString("Cual ha sido tu puntuación: ");
  controlador.registrarPuntuacioPartida(puntuacion);
  askData.mostrarMensaje("Puntuacion registrada");

  }
}