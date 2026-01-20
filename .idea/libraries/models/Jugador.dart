class Jugador {
  final String email; // Identificador único
  String nick;
  final DateTime fechaCreacion;


  final List<String> amigos = []; // Emails de amigos
  final List<Licencia> licencias = []; // Licencias compradas/alquiladas

  Jugador({required this.email, required this.nick})
      : fechaCreacion = DateTime.now();


}