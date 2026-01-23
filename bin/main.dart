import 'package:dart_juegos_calamot/models/videojuego.dart';
import 'package:dart_juegos_calamot/models/jugador.dart';
import 'package:dart_juegos_calamot/viewmodels/ControladorModeloVista.dart';
import 'package:dart_juegos_calamot/utils/askData.dart';
import 'package:dart_juegos_calamot/views/A%C3%B1adirAmigos.dart';
import 'package:dart_juegos_calamot/views/ComprarJuegoVista.dart';
import 'package:dart_juegos_calamot/views/DarJuego.dart';
import 'package:dart_juegos_calamot/views/ListarAmigos.dart';
import 'package:dart_juegos_calamot/views/LoginVista.dart';
import 'package:dart_juegos_calamot/views/RegisterVista.dart';
import 'package:dart_juegos_calamot/utils/calamotException.dart';
import 'package:dart_juegos_calamot/views/TiendaVista.dart';
import 'package:dart_juegos_calamot/views/PreJuego.dart';

void main(List<String> arguments) {
  askData.mostrarMensaje(" --- CALAMOT JUEGOS ---");

  final controlador = ControladorModeloVista();
  bool salir = false;
  bool juego = false;

  while (!salir) {
    if (controlador.usuarioCorrecto == null) {
      String opcion = askData.pedirString("[E] Entrar | [R] Registrar | [S] Sortir").toUpperCase();
      if (opcion == "E") {
        LoginVista.mostrarMenuLogin(controlador);
      } else if (opcion == "R") {
        vistaRegistro(controlador);
      } else if (opcion == "S") {
        salir = true;
      }else if (opcion != "E" || opcion != "R" || opcion != "S"){
        askData.mostrarMensaje("Esa opcion no exsiste");
      }
    } else if (controlador.usuarioCorrecto != null && !juego) {
      String nombre = controlador.usuarioCorrecto!.nick;
      controlador.inicializarTienda();
      askData.mostrarMensaje("\n--- MENÚ PRINCIPAL: $nombre ---");
      String opcion = askData.pedirString(
          "[J] Jugar | [B] Lista de Botiga | [C] Comprar | [L] Llogar | [P] Provar "
              "| [D] Donar | [A] Amics | [F] Fer amic | [E] Enrera | [T] Tancar"
      ).toUpperCase();

      try {
        if (opcion == "J") {
          if(Prejuego.preJuegoVista(controlador)){
            juego = true;
          }
        } else if (opcion == "B") {
          TiendaVista.mostrarCatalogo(controlador);
        } else if (opcion == "C" || opcion == "L" || opcion == "P") {
          Comprarjuegovista.adquirirLicenciaVista(opcion,controlador);
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
          salir = true;
        }
      } on CalamotException catch (e) {
        askData.mostrarError(e.missatge);
      }
    }else if (controlador.usuarioCorrecto != null && juego){
      askData.mostrarMensaje("HAS ENTRADO");
      askData.mostrarMensaje("\n--- HAS ENTRADO AL JUEGO ---");
      String opcion = askData.pedirString(
          "[H] Highscores | [G] Grup | [P] Puntuació | [E] Enrera | [T] Tancar App"
      ).toUpperCase();
      try {
        if(opcion == "H"){

        }else if (opcion == "G"){

        }else if (opcion == "P"){

        }else if (opcion == "E"){
          controlador.usuarioCorrecto = null;
          controlador.juegoActivo = null;
          juego = false;
          askData.mostrarMensaje("Sessió tancada.");
        }else if (opcion == "T"){
          salir = true;

        }
      }on CalamotException catch (e) {
  askData.mostrarError(e.missatge);
  }



    }
  }
}