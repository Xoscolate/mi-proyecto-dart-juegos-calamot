import 'package:dart_juegos_calamot/views/TiendaVista.dart';

import '../viewmodels/ControladorModeloVista.dart';
import '../utils/askData.dart';
import '../utils/calamotException.dart';
import '../models/Videojuego.dart';
import 'package:dart_juegos_calamot/models/Licencia.dart';
import 'package:dart_juegos_calamot/models/TiposLicencia.dart';
import 'package:dart_juegos_calamot/models/Jugador.dart';


class DarJuego {
  static void darJuegoVista (ControladorModeloVista controlador){
    askData.mostrarMensaje("--- Dart Juego ---");
    askData.mostrarMensaje("A que amigo quieres dar el juego");
    controlador.mostrarAmigos();
    String amigoEmail = askData.pedirString("Escoge: ");
    controlador.exsisteAmigo(amigoEmail);
    askData.mostrarMensaje("Que juego quieres dar (licencia de tu juego):");
    controlador.juegosQueTienes();
    String juego = askData.pedirString("Licencia: ").toLowerCase();
    controlador.amigoTieneEseJuego(juego, amigoEmail);
    controlador.validacionCambios(juego, amigoEmail);
    controlador.ejecutarTraspaso(juego, amigoEmail);
    askData.mostrarMensaje("Transferencia hecha correctamente");


  }



  static void mostrarAmigos(Jugador amigo){
    askData.mostrarMensaje("Nick: ${amigo.nick} Email: ${amigo.email}");
  }

  static void mostrarJuegos(Videojuego juego, Licencia licencia){
    askData.mostrarMensaje("Nombre: ${juego.nombre} Codigo: ${juego.codigo} Licencia: ${licencia.id}");
  }


}