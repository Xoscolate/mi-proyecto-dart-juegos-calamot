import 'package:dart_juegos_calamot/models/videojuego.dart';
import 'package:dart_juegos_calamot/models/jugador.dart';
import 'package:dart_juegos_calamot/viewmodels/ControladorModeloVista.dart';
import 'package:dart_juegos_calamot/utils/askData.dart';
import 'package:dart_juegos_calamot/views/A%C3%B1adirAmigos.dart';
import 'package:dart_juegos_calamot/views/ComprarJuegoVista.dart';
import 'package:dart_juegos_calamot/views/CrearGrupoVista.dart';
import 'package:dart_juegos_calamot/views/DarJuego.dart';
import 'package:dart_juegos_calamot/views/ListarAmigos.dart';
import 'package:dart_juegos_calamot/views/LoginVista.dart';
import 'package:dart_juegos_calamot/views/RegisterVista.dart';
import 'package:dart_juegos_calamot/utils/calamotException.dart';
import 'package:dart_juegos_calamot/views/TiendaVista.dart';
import 'package:dart_juegos_calamot/views/PreJuego.dart';
import 'package:dart_juegos_calamot/views/CrearPuntuacionVista.dart';
import 'package:dart_juegos_calamot/views/PuntuacionVista.dart';
import 'package:dart_juegos_calamot/views/VistaLogin.dart';
import 'package:dart_juegos_calamot/views/VistaMenuPrincipal.dart';
import 'package:dart_juegos_calamot/views/VistaPartida.dart';




void main(List<String> arguments) {
  askData.mostrarMensaje(" --- CALAMOT JUEGOS ---");
  final controlador = ControladorModeloVista();
  controlador.inicializarUsuariosPrueba();

  while (!controlador.salir) {
    if (controlador.usuarioCorrecto == null) {
      VistaLogin.mostrar(controlador);
    }
    else if (controlador.usuarioCorrecto != null && !controlador.juego) {
      VistaMenuPrincipal.mostrar(controlador);
    }
    else if (controlador.usuarioCorrecto != null && controlador.juego) {
      VistaPartida.mostrar(controlador);
    }
  }
}