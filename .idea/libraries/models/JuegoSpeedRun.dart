class Juegospeedrun extends Videojuego<double> {

  Juegospeedrun(super.nombre, super.codigo, super.estilo, super.precioCompra, super.precioAlquiler);

  @override
  String ensenarHighScores() {
    var lista = puntuacions.entries.toList();


    lista.sort((a, b) => a.value.compareTo(b.value));

    StringBuffer sb = StringBuffer();
    sb.writeln("Corredores más rápidos:");
    for (var entry in llista.take(10)) {
      sb.writeln("${entry.key}: ${entry.value} segundos");
    }
    return sb.toString();
  }

  @override
  String getRepteDelDia() => "Acaba el nivel en 2 minutos";
}
