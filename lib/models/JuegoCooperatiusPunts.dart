import 'Videojuego.dart';
import 'Estilo.dart';

class JuegoCooperatiusPunts extends Videojuego<int> {

  JuegoCooperatiusPunts(String nombre, String codigo, Estilo estilo, double precioCompra, double precioAlquiler)
      : super(nombre, codigo, estilo, precioCompra, precioAlquiler);

  @override
  String mostrarHighscores() {
    var lista = puntuacions.entries.toList();

    lista.sort((a, b) => b.value.compareTo(a.value));

    StringBuffer sb = StringBuffer();
    sb.writeln("\n--- RÀNQUING EQUIPS: $nombre ---");

    for (var entry in lista.take(10)) {
      sb.writeln("Equip '${entry.key}': ${entry.value} punts totals");
    }

    if (lista.isEmpty) {
      sb.writeln("Encara no hi ha puntuacions registrades.");
    }

    return sb.toString();
  }

  @override
  String Reto() {
    return "¡Aconsegueix 5000 punts sumant el treball de tot l'equip!";
  }
}