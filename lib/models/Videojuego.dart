import 'Estilo.dart';
import 'package:dart_juegos_calamot/utils/calamotException.dart';

sealed class Videojuego<T> { // Restringimos T a números (int/double), la sealed class para hacer la clase cerrada
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

  @override
  bool mejorPuntuacion(int nueva, int actual) {
    return nueva > actual;
  }

  @override
  List<MapEntry<String, int>> obtenerDatosHighscores() {
    var lista = puntuacions.entries.toList();
    lista.sort((a, b) => b.value.compareTo(a.value));
    return lista.take(10).toList(); //El take (10) es para que solo coga los 10 primero de la lista
  }

  @override
  String Reto() => "¡Supera los 5000 puntos!";
}

class JuegoCooperativo extends Videojuego<int> {
  JuegoCooperativo(super.nombre, super.codigo, super.estilo, super.precioCompra, super.precioAlquiler);

  @override
  bool mejorPuntuacion(int nueva, int actual) => nueva > actual;

  @override
  List<MapEntry<String, int>> obtenerDatosHighscores() {
    var lista = puntuacions.entries.toList();
    // Ordenamos de mayor a menor puntuación de equipo
    lista.sort((a, b) => b.value.compareTo(a.value));
    return lista.take(10).toList();
  }

  @override
  String Reto() => "Formeu un equip i supereu el rècord del grup dominant!";
}

class JuegoSpeedRun extends Videojuego<Duration> {
  JuegoSpeedRun(super.nombre, super.codigo, super.estilo, super.precioCompra, super.precioAlquiler);

  @override
  bool mejorPuntuacion(Duration nueva, Duration actual) {
    return nueva < actual;
  }

  @override
  List<MapEntry<String, Duration>> obtenerDatosHighscores() {
    var lista = puntuacions.entries.toList();
    lista.sort((a, b) => a.value.compareTo(b.value)); //Aqui la lista es de mayor a menor
    return lista.take(10).toList();
  }

  @override
  String Reto() => "Acaba el nivell en el menor temps possible!";
}

class JuegoVictoriesDerrotes extends Videojuego<List<bool>> {
  JuegoVictoriesDerrotes(super.nombre, super.codigo, super.estilo, super.precioCompra, super.precioAlquiler);

  @override
  bool mejorPuntuacion(List<bool> nueva, List<bool> actual) {
    return true;
  }

  @override
  List<MapEntry<String, List<bool>>> obtenerDatosHighscores() {
    var lista = puntuacions.entries.toList();

    lista.sort((a, b) {
      // 1. Calculamos porcentajes
      double winRateA = _calcularPorcentaje(a.value);
      double winRateB = _calcularPorcentaje(b.value);

      if (winRateA != winRateB) {
        return winRateB.compareTo(winRateA); // Mayor porcentaje arriba
      }

      // 2. Empate: Quien tenga más victorias totales
      int victoriasA = a.value.where((v) => v == true).length;
      int victoriasB = b.value.where((v) => v == true).length;
      return victoriasB.compareTo(victoriasA);
    });

    return lista.take(10).toList();
  }

  double _calcularPorcentaje(List<bool> partida) { //Con este metodo devuelvo el porcentaje con el formato double
    if (partida.isEmpty) return 0.0;
    int victorias = partida.where((v) => v == true).length;
    return (victorias / partida.length) * 100;
  }

  @override
  String Reto() => "Guanya tantes partides com puguis per dominar el rànquing!";
}
