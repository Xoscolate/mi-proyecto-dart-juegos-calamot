import 'package:dart_juegos_calamot/views/TiendaVista.dart';

import '../viewmodels/ControladorModeloVista.dart';
import '../utils/askData.dart';
import '../utils/calamotException.dart';
import '../models/Videojuego.dart';
import 'package:dart_juegos_calamot/models/Licencia.dart';
import 'package:dart_juegos_calamot/models/TiposLicencia.dart';
import 'package:dart_juegos_calamot/models/Jugador.dart';
import '../utils/askData.dart';



class Prejuego {
  static bool preJuegoVista(ControladorModeloVista controlador){
    askData.mostrarMensaje("--- Juegos disponibles ---");
    controlador.juegosQueTienes();
    String idJuego = askData.pedirString("Que juego quieres jugar (licencia): ");
    controlador.tienesLicencia(idJuego);
    return true;
  }
}