import 'package:dart_juegos_calamot/views/TiendaVista.dart';

import '../viewmodels/ControladorModeloVista.dart';
import '../utils/askData.dart';
import '../utils/calamotException.dart';
import '../models/Videojuego.dart';
import 'package:dart_juegos_calamot/models/Licencia.dart';
import 'package:dart_juegos_calamot/models/TiposLicencia.dart';
import 'package:dart_juegos_calamot/models/Jugador.dart';
import '../utils/askData.dart';
import 'package:dart_juegos_calamot/views/LoginVista.dart';
import 'package:dart_juegos_calamot/views/RegisterVista.dart';
import 'package:dart_juegos_calamot/viewmodels/ControladorModeloVista.dart';
import 'package:dart_juegos_calamot/views/PreJuego.dart';
import 'package:dart_juegos_calamot/views/ComprarJuegoVista.dart';
import 'package:dart_juegos_calamot/views/DarJuego.dart';
import 'package:dart_juegos_calamot/views/ListarAmigos.dart';
import 'package:dart_juegos_calamot/views/AñadirAmigos.dart';
import 'package:dart_juegos_calamot/views/PuntuacionVista.dart';
import 'package:dart_juegos_calamot/views/CrearPuntuacionVista.dart';
import 'package:dart_juegos_calamot/views/CrearGrupoVista.dart';



class VistaPartida {
  static void mostrar(ControladorModeloVista controlador) {
    askData.mostrarMensaje("\n--- HAS ENTRADO AL JUEGO: ${controlador.juegoActivo!.nombre} ---");
    askData.mostrarMensaje(">>> EL RETO: ${controlador.juegoActivo!.Reto()} <<<");
    String opcion = askData.pedirString(
        "[H] Highscores | [G] Grup | [P] Puntuació | [E] Enrera | [T] Tancar App"
    ).toUpperCase();

    try {
      if (opcion == "H") {
        Puntuacionvista.HighScoresVista(controlador);
      } else if (opcion == "G") {
        Creargrupovista.CrearGrupo(controlador);
      } else if (opcion == "P") {
        Crearpuntuacionvista.CrearPuntuacion(controlador);
      } else if (opcion == "E") {
        controlador.finalizarSesionJuego();
        controlador.usuarioCorrecto = null;
        controlador.juegoActivo = null;
        controlador.grupoActual = [];
        controlador.nombreGrupoActual = null;
        controlador.juego = false;
        askData.mostrarMensaje("Sessió tancada.");
      } else if (opcion == "T") {
        controlador.salir = true;
      }
    } on CalamotException catch (e) {
      askData.mostrarError(e.missatge);
    }
  }
}