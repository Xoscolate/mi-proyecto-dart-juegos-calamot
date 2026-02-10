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

class VistaLogin {
  static void mostrar(ControladorModeloVista controlador) {
    controlador.inicializarTienda();
    String opcion = askData.pedirString("[E] Entrar | [R] Registrar | [S] Sortir").toUpperCase();
    if (opcion == "E") {
      LoginVista.mostrarMenuLogin(controlador);
    } else if (opcion == "R") {
      vistaRegistro(controlador);
    } else if (opcion == "S") {
      controlador.salir = true;
    } else {
      askData.mostrarMensaje("Esa opcion no exsiste");
    }
  }
}