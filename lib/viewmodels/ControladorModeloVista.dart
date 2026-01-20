import '../models/Jugador.dart';
import '../models/Videojuego.dart';
import '../models/Equipo.dart';
import 'package:dart_juegos_calamot/utils/askData.dart';
import 'package:dart_juegos_calamot/utils/calamotException.dart';

class ControladorModeloVista {
  final List<Jugador> _jugadores = []; //lista de jugadores
  final List<Videojuego> _juegos = []; //juegos

  Jugador? usuarioCorrecto; // esto comienza nulo pero con la funcion entrar le asigno si es correcto

  bool entrar(String emailIntroducido) {
    //metodo para el login
    for (var jugador in _jugadores) {
      if (jugador.email == emailIntroducido) {
        usuarioCorrecto = jugador;
        return true;
      }
    }
    return false;
  }

  void verificarFormatoEmail(String email) {
    if (!email.isValidEmail()) {
      throw CalamotException("El format de l'email '$email' no és vàlid.");
    }
  }
}