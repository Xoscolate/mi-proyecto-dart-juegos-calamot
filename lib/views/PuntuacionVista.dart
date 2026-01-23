import 'package:dart_juegos_calamot/views/TiendaVista.dart';

import '../viewmodels/ControladorModeloVista.dart';
import '../utils/askData.dart';
import '../utils/calamotException.dart';
import '../models/Videojuego.dart';
import 'package:dart_juegos_calamot/models/Licencia.dart';
import 'package:dart_juegos_calamot/models/TiposLicencia.dart';
import 'package:dart_juegos_calamot/models/Jugador.dart';
import '../utils/askData.dart';



class Puntuacionvista {
  static void HighScoresVista(ControladorModeloVista controlador){
    String puntuaciones = controlador.obtenerTablaPuntuaciones();
    askData.mostrarMensaje(puntuaciones);
  }
}