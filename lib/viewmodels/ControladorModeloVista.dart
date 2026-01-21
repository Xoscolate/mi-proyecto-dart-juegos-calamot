import '../models/Jugador.dart';
import '../models/Videojuego.dart';
import '../models/Equipo.dart';
import 'package:dart_juegos_calamot/utils/askData.dart';
import 'package:dart_juegos_calamot/utils/calamotException.dart';

class ControladorModeloVista {
  final List<Jugador> _jugadores = []; //lista de jugadores
  final List<Videojuego> _juegos = []; //juegos

  Jugador? usuarioCorrecto; // esto comienza nulo pero con la funcion entrar le asigno si es correcto

  void entrar(String emailIntroducido, String contrasena) {
    Jugador? encontrado;
    for (var jugador in _jugadores) {
      if (jugador.email == emailIntroducido &&
          jugador.contrasena == contrasena) {
        encontrado = jugador;
      }
    }
    if (encontrado != null) {
      usuarioCorrecto = encontrado;
    } else {
      throw CalamotException("Email o contrasenya incorrectes.");
    }
  }

  void verificarFormatoEmail(String email) {
    if (!email.isValidEmail()) {
      throw CalamotException("El format de l'email '$email' no és vàlid.");
    }
  }

  void registrar(String email, String nick, String contrasena,) {
    verificarFormatoEmail(email);
    bool yaExiste = false;
    for (var j in _jugadores) {
      if (j.email == email) {
        yaExiste = true;
      }
    }
    if (yaExiste) {
      throw CalamotException("Aquest correu electrònic ja està registrat.");
    } else {
      Jugador nuevoJugador = Jugador(
          email: email,
          nick: nick,
          contrasena: contrasena
      );

      _jugadores.add(nuevoJugador);
    }
  }
}

