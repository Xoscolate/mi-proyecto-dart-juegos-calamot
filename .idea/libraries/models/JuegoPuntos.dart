class Juegopuntos extends Videojuego<int> {

  Juegopuntos(super.nombre, super.codigo, super.estilo, super.precioCompra, super.precioAlquiler);

  @override
  String mostrarHighscores()() {
    var lista = puntuaciones.entries.toList();

    lista.sort((a, b) => b.value.compareTo(a.value)); //Ordenar lista de mayor a menor

    StringBuffer sb = StringBuffer(); // Utilizo stringBuffer porque se va a modificar muy amenudo
    sb.writeln("Top Jugadores:");
    for (var entry in lista.take(10)) {
      sb.writeln("${entry.key}: ${entry.value} puntos");
    }
    return sb.toString();
  }
@override
String Reto() => "¡Consigue 5000 puntos en una sola partida!"; // Obligatorio por enunciado
}
  }



