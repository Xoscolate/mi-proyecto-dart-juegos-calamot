class Equipo {
  final String nombre;
  final List<String> miembros; // Lista de emails de los miembros
  Equipo(this.nombre, this.miembros);

  @override
  String toString() {
    return 'Equipo: $nombre | Miembros: ${miembros.length}';
  }
}