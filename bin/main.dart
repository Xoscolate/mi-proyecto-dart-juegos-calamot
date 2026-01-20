// Importas tus modelos usando el nombre de tu proyecto definido en pubspec.yaml
import 'package:dart_juegos_calamot/models/videojuego.dart';
import 'package:dart_juegos_calamot/models/jugador.dart';
import 'package:dart_juegos_calamot/viewmodels/ControladorModeloVista.dart';

void main(List<String> arguments) {
  print('=== BIENVENIDO A JUEGOS CALAMOT ===');
  final controlador = ControladorModeloVista();
  bool salir = false;
  while (salir) {
    print('[E] Login');
    print('[R] Registrarse');
    print('[T] Cerrar App');
  }
}