import '../viewmodels/ControladorModeloVista.dart';
import '../utils/askData.dart';
import '../utils/calamotException.dart';
import '../models/videojuego.dart';


class TiendaVista {
  static void mostrarCatalogo(ControladorModeloVista controlador) {
    askData.mostrarMensaje("--- Filtro Tienda ---");
    askData.mostrarMensaje(
        "Estils: plataformes, shooter, cartes, simulacio o todos, Cual eliges?");
    String filtro = askData.pedirString("");
    if (filtro != "plataformes" && filtro != "shooter" && filtro != "cartes" && filtro != "simulacio" && filtro!= "todos"){
      throw CalamotException("Esa opcion no exsiste");
    }
    var juegosFiltrados = controlador.obtenerJuegosFiltrados(filtro);
    askData.mostrarMensaje("Juego encontrdos:");
    for (var j in juegosFiltrados){
      askData.mostrarMensaje("Nombre: ${j.nombre} Precio: ${j.precioCompra}") ;
    }
  }
}