import 'Estilo.dart';
import 'package:dart_juegos_calamot/utils/calamotException.dart';

sealed class Videojuego<T> { // Restringimos T a números (int/double)
  final String nombre;
  final String codigo;
  final Estilo estilo;
  final double precioCompra;
  final double precioAlquiler;


  final Map<String, T> _puntuacions = {};

  Videojuego(this.nombre, this.codigo, this.estilo, this.precioCompra, this.precioAlquiler);
  bool mejorPuntuacion(T nueva, T actual);



  void puntuar(String email, T puntuacio) {
    if (!_puntuacions.containsKey(email)) { // Si este no ha jugado (no esta en la lista) se añade directo
      _puntuacions[email] = puntuacio;
    } else {
      if (mejorPuntuacion(puntuacio, _puntuacions[email]!)) {
        _puntuacions[email] = puntuacio;
      }
    }
  }


  Map<String, T> get puntuacions => _puntuacions;

  List<MapEntry<String, T>> obtenerDatosHighscores();
  String Reto();
}

// ---------------------------------------------------------
// JUEGO DE PUNTOS
// ---------------------------------------------------------
class JuegoPuntos extends Videojuego<int> {
  JuegoPuntos(super.nombre, super.codigo, super.estilo, super.precioCompra, super.precioAlquiler);

  // 2. ¡AQUÍ ESTÁ LA SOLUCIÓN! Tienes que implementar el método
  @override
  bool mejorPuntuacion(int nueva, int actual) {
    // En juegos de puntos, queremos que la nueva sea SUPERIOR a la actual
    return nueva > actual;
  }

  @override
  List<MapEntry<String, int>> obtenerDatosHighscores() {
    // ... tu lógica de ordenación
    var lista = puntuacions.entries.toList();
    lista.sort((a, b) => b.value.compareTo(a.value));
    return lista.take(10).toList();
  }

  @override
  String Reto() => "¡Supera los 5000 puntos!";
}
