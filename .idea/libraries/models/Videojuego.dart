abstract class Videojuego<T> { //clase maestra <T>
final String nombre;
final String codigo;
final Estilo estilo;
final double precioCompra;
final double precioAlquiler;

final Map<String, T> _puntuacions = {}; //cada juego se puntua de diferente manera
Videojoc(this.nombre, this.codigo, this.estilo, this.precioCompra, this.precioAlquiler);

void puntuar(String email, T puntuacio) {
  _puntuacions[email] = puntuacio;
}

Map<String, T> get puntuacions => _puntuacions;

String ensenarHighScores();
String Reto();
}
