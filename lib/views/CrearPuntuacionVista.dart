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

    if (controlador.juegoActivo is JuegoCooperativo){
      if (controlador.grupoActual.isEmpty){
        throw CalamotException("No tienes ningun equipo actualmente");
      }
      askData.mostrarMensaje("--- PUNTUACION EN EQUIPO ---");
      int total = 0;
      for (var i in controlador.grupoActual){
        int puntuacion = askData.pedirInt("Puntuacion de ${i.nick}: ");
        total = total + puntuacion;
      }

      controlador.registrarPuntuacioPartidaCoperativo(total.toString());

    }if(controlador.juegoActivo is JuegoPuntos){

  var puntuacion = askData.pedirString("Cual ha sido tu puntuación: ");
  controlador.registrarPuntuacioPartida(puntuacion);
  askData.mostrarMensaje("Puntuacion registrada");

  }
    if (controlador.juegoActivo is JuegoSpeedRun) {
      int segundos = askData.pedirInt("¿Cuántos segundos has tardado?");
      controlador.registrarPuntuacioPartida(segundos.toString());
      askData.mostrarMensaje("Tiempo registrado");
    }

    if (controlador.juegoActivo is JuegoVictoriesDerrotes) {
      String resultado = askData.pedirString("¿Has ganado la partida? (S/N)").toUpperCase();
      if (resultado == "S" || resultado == "N") {
        controlador.registrarPuntuacioPartida(resultado);
        askData.mostrarMensaje("Resultado registrado");
      } else {
        throw CalamotException("Error: Solo puedes poner S o N");
      }
    }


}}