import 'package:dart_juegos_calamot/views/TiendaVista.dart';

import '../viewmodels/ControladorModeloVista.dart';
import '../utils/askData.dart';
import '../utils/calamotException.dart';
import '../models/videojuego.dart';
import 'package:dart_juegos_calamot/models/Licencia.dart';
import 'package:dart_juegos_calamot/models/TiposLicencia.dart';


class Comprarjuegovista {
  static void adquirirLicenciaVista(String tipo, ControladorModeloVista controlador){
    askData.mostrarMensaje("--- Juegos Disponibles ---");
    TiendaVista.mostrarCatalogo(controlador);
    askData.mostrarMensaje("Introduce el ID del juego");
    String idJuego = askData.pedirString("");
    controlador.adquirirLicencia(tipo, controlador, idJuego);
  }

}