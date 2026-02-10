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


class VistaMenuPrincipal {
  static void mostrar(ControladorModeloVista controlador) {
    String nombre = controlador.usuarioCorrecto!.nick;
    controlador.inicializarTienda();
    askData.mostrarMensaje("\n--- MENÚ PRINCIPAL: $nombre ---");
    String opcion = askData.pedirString(
        "[J] Jugar | [B] Lista de Botiga | [C] Comprar | [L] Llogar | [P] Provar "
            "| [D] Donar | [A] Amics | [F] Fer amic | [E] Enrera | [T] Tancar"
    ).toUpperCase();

    try {
      if (opcion == "J") {
        if (Prejuego.preJuegoVista(controlador)) {
          controlador.juego = true;
        }
      } else if (opcion == "B") {
        TiendaVista.mostrarCatalogo(controlador);
      } else if (opcion == "C" || opcion == "L" || opcion == "P") {
        Comprarjuegovista.adquirirLicenciaVista(opcion, controlador);
      } else if (opcion == "D") {
        DarJuego.darJuegoVista(controlador);
      } else if (opcion == "A") {
        ListarAmigos.listarAmigosVista(controlador);
      } else if (opcion == "F") {
        Anadiramigos.anadirAmigos(controlador);
      } else if (opcion == "E") {
        controlador.usuarioCorrecto = null;
        askData.mostrarMensaje("Sessió tancada.");
      } else if (opcion == "T") {
        controlador.salir = true;
      }
    } on CalamotException catch (e) {
      askData.mostrarError(e.missatge);
    }
  }
}