import 'Videojuego.dart';

class Juegospeedrun extends Videojuego<double> {

  Juegospeedrun(super.nombre, super.codigo, super.estilo, super.precioCompra, super.precioAlquiler);

  @override
  String mostrarHighscores() { // Nombre corregido según el punto 2 del enunciado
    // Convertimos las puntuaciones a lista para poder ordenar
    var lista = puntuacions.entries.toList();

    // ORDENACIÓN: En Speedrun, el menor tiempo (a) va antes que el mayor (b)
    lista.sort((a, b) => a.value.compareTo(b.value));

    StringBuffer sb = StringBuffer(); // Práctica recomendada para modificar strings
    sb.writeln("--- RÀNQUING SPEEDRUN (Més ràpids) ---");

    // Corregido de 'llista' a 'lista' y tomamos el top 10
    for (var entry in lista.take(10)) {
      sb.writeln("${entry.key}: ${entry.value} segons");
    }
    return sb.toString();
  }

  @override
  String Reto() => "Acaba el nivell en menys de 2 minuts (120 segons)"; // Coincide con tu clase base
}