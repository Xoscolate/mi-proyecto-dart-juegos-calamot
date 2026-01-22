import 'package:dart_juegos_calamot/views/TiendaVista.dart';

import '../viewmodels/ControladorModeloVista.dart';
import '../utils/askData.dart';
import '../utils/calamotException.dart';
import '../models/Videojuego.dart';
import 'package:dart_juegos_calamot/models/Licencia.dart';
import 'package:dart_juegos_calamot/models/TiposLicencia.dart';
import 'package:dart_juegos_calamot/models/Jugador.dart';
import '../utils/askData.dart';



class ListarAmigos {
  static void listarAmigosVista(ControladorModeloVista controlador){
    askData.mostrarMensaje("--- Amigos agregados ---");
    controlador.amigosAgregados();





}

static void mostrarAmigo(Jugador j){
    askData.mostrarMensaje("Nombre: ${j.nick} Email: ${j.email} Fecha de creacion: ${j.fechaCreacion}");
    askData.mostrarMensaje("---------------------------------------------------------------------------");
}


}