import 'Licencia.dart';
class Jugador {
  final String email; // Identificador único
  String nick;
  final DateTime fechaCreacion;
  final String contrasena; // Identificador único



  final List<String> amigos = [];
  final List<Licencia> licencias = [];

  Jugador({required this.email, required this.nick, required this.contrasena})
      : fechaCreacion = DateTime.now();

  @override
  String toString() {
    return 'Jugador: $nick ($email) - Amigos: ${amigos.length} - Juegos: ${licencias.length}';
  }
}
