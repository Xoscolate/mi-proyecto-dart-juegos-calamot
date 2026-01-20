import 'Licencia.dart';
class Jugador {
  final String email; // Identificador único
  String nick;
  final DateTime fechaCreacion;


  final List<String> amigos = [];        // Lista de emails (Strings) [3]
  final List<Licencia> licencias = [];  // Lista de Objetos Licencia [3]

  Jugador({required this.email, required this.nick})
      : fechaCreacion = DateTime.now();

  @override
  String toString() {
    return 'Jugador: $nick ($email) - Amigos: ${amigos.length} - Juegos: ${licencias.length}';
  }
}
