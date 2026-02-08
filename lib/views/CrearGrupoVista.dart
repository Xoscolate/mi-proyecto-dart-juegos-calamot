import 'package:dart_juegos_calamot/views/TiendaVista.dart';

import '../viewmodels/ControladorModeloVista.dart';
import '../utils/askData.dart';
import '../utils/calamotException.dart';
import '../models/Videojuego.dart';
import 'package:dart_juegos_calamot/models/Licencia.dart';
import 'package:dart_juegos_calamot/models/TiposLicencia.dart';
import 'package:dart_juegos_calamot/models/Jugador.dart';
import '../utils/askData.dart';

class Creargrupovista {
  static void CrearGrupo(ControladorModeloVista controlador) {
    controlador.recuperarGrupoDelSistema();

    if (controlador.grupoActual.isNotEmpty) {
      askData.mostrarMensaje("Actualmente estas en el grupo ${controlador.nombreGrupoActual}");
      askData.mostrarMensaje("Que quieres hacer: (1) Meter a mas gente (2) Salir del grupo (3) Ver jugadores del grupo");
      String numero = askData.pedirString("Escoge:");
      controlador.unoODos(numero);

      if (numero == "1") {
        controlador.hayEspacioEnElGrupo();
        controlador.mostrarJugadoresConEseJuego(controlador.licenciaActiva!.idVideojuego, controlador);
        String email = askData.pedirString("Que jugador quieres para tu grupo");
        controlador.existeJugador(email);
        controlador.yaEstaEnGrupo(email);
        controlador.jugadorYaTieneGrupoEnSistema(email);
        controlador.anadirJugadorGrupo(email);

        controlador.guardarGrupoEnSistema();
        askData.mostrarMensaje("Jugador anadido correctamente");

      } else if (numero == "2") {
        controlador.salirDelGrupoOficial();
        askData.mostrarMensaje("Has salido del grupo.");

      } else if (numero == "3") {
        for (var j in controlador.grupoActual) {
          askData.mostrarMensaje("${j.nick}, ");
        }
      }
    } else {
      controlador.puedeCrearGrupo();
      controlador.hayEspacioEnElGrupo();
      controlador.hayJugadoresEnElSistema(controlador.licenciaActiva!.idVideojuego);

      askData.mostrarMensaje("--- CREACION DE GRUPOS ---");
      controlador.mostrarJugadoresConEseJuego(controlador.licenciaActiva!.idVideojuego, controlador);

      String email = askData.pedirString("Que jugador quieres para tu grupo");
      controlador.existeJugador(email);

      String nombreGrupo = askData.pedirString("Que nombre quieres para el grupo");

      controlador.nombreGrupoDisponible(nombreGrupo);

      controlador.anadirNombreGrupo(nombreGrupo);
      controlador.anadirJugadorGrupo(email);

      controlador.guardarGrupoEnSistema();

      askData.mostrarMensaje("Jugador anadido correctamente");
    }
  }

  static void mostrarJugadores(Jugador j, ControladorModeloVista controlador) {
    if (j.email != controlador.usuarioCorrecto!.email) {
      askData.mostrarMensaje("Nombre: ${j.nick} Email: ${j.email} Fecha de creacion: ${j.fechaCreacion}");
      askData.mostrarMensaje("---------------------------------------------------------------------------");
    }
  }
}
