import '../viewmodels/ControladorModeloVista.dart';
import '../utils/askData.dart';
import '../utils/calamotException.dart';
import '../models/videojuego.dart';


class TiendaVista {
  static void mostrarCatalogoFiltro(ControladorModeloVista controlador) {
    askData.mostrarMensaje("--- Filtro Tienda ---");
    askData.mostrarMensaje(
        "Estils: plataformes, shooter, cartes, simulacio o todos, Cual eliges?");
    String filtro = askData.pedirString("");
    if (filtro != "plataformes" && filtro != "shooter" && filtro != "cartes" &&
        filtro != "simulacio" && filtro != "todos") {
      throw CalamotException("Esa opcion no exsiste");
    }
    var juegosFiltrados = controlador.obtenerJuegosFiltrados(filtro);
    askData.mostrarMensaje("Juego encontrdos:");
    for (var j in juegosFiltrados) {
      askData.mostrarMensaje("Nombre: ${j.nombre} Precio: ${j
          .precioCompra}"); // el ${} es para juntar el texto junto a variables
    }
  }

  static void mostrarCatalogo(ControladorModeloVista controlador) {
    var juegos = controlador.todosLosJuegos;

    if (juegos.isEmpty) {
      askData.mostrarMensaje("No hay nada en tienda");
    } else {
      for (var j in juegos) {
        askData.mostrarMensaje("Nombre: ${j.nombre} Precio: ${j.precioCompra}  ID: ${j.codigo}");
      }
    }
  }
}