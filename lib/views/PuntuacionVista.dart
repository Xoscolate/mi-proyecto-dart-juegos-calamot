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
      var listaPuntos = controlador.obtenerDatosPuntuaciones();
      String nombreJuego = controlador.juegoActivo!.nombre;
      if (controlador.juegoActivo is JuegoPuntos){
      askData.mostrarMensaje("PUNTACIONES TOP 10 DE ${nombreJuego}");
      for(var i in listaPuntos) {
        askData.mostrarMensaje("${i.key}: ${i.value}");
      }
      }else if(controlador.juegoActivo is JuegoCooperativo){
        askData.mostrarMensaje("PUNTACIONES TOP 10 DE ${nombreJuego} (SUS EQUIPOS):");
        for(var i in listaPuntos) {
          askData.mostrarMensaje("${i.key}: ${i.value}");
        }
      }
    }
}