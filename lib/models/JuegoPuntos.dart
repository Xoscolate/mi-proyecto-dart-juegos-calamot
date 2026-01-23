import 'package:dart_juegos_calamot/utils/calamotException.dart';

import 'Videojuego.dart';

class JuegoPuntos extends Videojuego<int> {

  // Constructor corregido con super
  JuegoPuntos(super.nombre, super.codigo, super.estilo, super.precioCompra, super.precioAlquiler);

  @override
  String mostrarHighscores() {
    // Corregido: 'puntuacions' debe coincidir con el getter de Videojuego
    var lista = puntuacions.entries.toList();
    if(lista.isEmpty){
      throw CalamotException("No hay ahora mismo ninguna puntuación");
    }

    // Ordenamos de mayor a menor puntuación
    lista.sort((a, b) => b.value.compareTo(a.value));

    StringBuffer sb = StringBuffer();
    sb.writeln("--- Top Jugadores ---");

    for (var entry in lista.take(10)) {
      sb.writeln("${entry.key}: ${entry.value} puntos");
    }

    return sb.toString();
  }

  @override
  String Reto() => "¡Consigue 5000 puntos en una sola partida!";
}