import 'Estilo.dart';
abstract class Videojuego<T> { // Se añade <T> aquí
  final String nombre;
  final String codigo;
  final Estilo estilo;
  final double precioCompra;
  final double precioAlquiler;

  final Map<String, T> _puntuacions = {};

  Videojuego(this.nombre, this.codigo, this.estilo, this.precioCompra, this.precioAlquiler);

  void puntuar(String email, T puntuacio) {
    _puntuacions[email] = puntuacio;
  }

  Map<String, T> get puntuacions => _puntuacions;

  String mostrarHighscores();
  String Reto();
}