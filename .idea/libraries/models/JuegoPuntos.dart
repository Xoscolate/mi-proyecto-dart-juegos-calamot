class JocPunts extends Videojoc<int> {

  JocPunts(super.nombre, super.codigo, this.estilo, this.precioCompra, this.precioAlquiler);

  @override
  String ensenarHighScores() {
    var lista = puntuaciones.entries.toList();

    lista.sort((a, b) => b.value.compareTo(a.value)); //Ordenar lista de mayor a menor

    StringBuffer sb = StringBuffer(); // Utilizo stringBuffer porque se va a modificar muy amenudo
    sb.writeln("Top Jugadores:");
    for (var entry in llista.take(10)) {
      sb.writeln("${entry.key}: ${entry.value} puntos");
    }
    return sb.toString();
  }
  }



