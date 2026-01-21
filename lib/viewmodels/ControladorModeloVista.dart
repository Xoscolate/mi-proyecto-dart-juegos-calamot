import 'package:dart_juegos_calamot/models/JuegoPuntos.dart';
import 'package:dart_juegos_calamot/models/JuegoSpeedRun.dart';

import '../models/Jugador.dart';
import '../models/Videojuego.dart';
import '../models/Equipo.dart';
import 'package:dart_juegos_calamot/utils/askData.dart';
import 'package:dart_juegos_calamot/utils/calamotException.dart';
import 'package:dart_juegos_calamot/models/Estilo.dart';
import 'package:dart_juegos_calamot/models/Licencia.dart';
import 'package:dart_juegos_calamot/models/TiposLicencia.dart';

class ControladorModeloVista {
  final List<Jugador> _jugadores = []; //lista de jugadores
  final List<Videojuego<dynamic>> _juegos = [];
  List<Videojuego<dynamic>> get  todosLosJuegos => _juegos; // lo utilizo como forma simple de ver todos los juegos en tienda
  Jugador? usuarioCorrecto; // esto comienza nulo pero con la funcion entrar le asigno si es correcto
  List<Licencia> get licencias => usuarioCorrecto!.licencias;


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
    emailExsiste(email);
      Jugador nuevoJugador = Jugador(
          email: email,
          nick: nick,
          contrasena: contrasena
      );

      _jugadores.add(nuevoJugador);
    }


  void emailExsiste (String email){
    bool yaExiste = false;
    for (var j in _jugadores) {
      if (j.email == email) {
        yaExiste = true;
      }
    }
      if (yaExiste) {
        throw CalamotException("Este correo ya exsiste.");
      }
  }



  void inicializarTienda() {
    if (_juegos.isEmpty) {
      _juegos.add(Juegospeedrun("Mario Bros","mario",Estilo.plataformes,29.99,2.99));
      _juegos.add(JuegoPuntos("Doom Eternal","doom",Estilo.shooter,39.99,4.99));

    }
  }

  bool exsisteId(String id){
    for (var j in _juegos) {
      if (j.codigo == id){
        return true;
      }
      }
    return false;
    }

  void adquirirLicencia(String tipo, ControladorModeloVista controlador, String id){
    Licencia licencia; //inicializo la licencia (internamente genera todo)
    if(!exsisteId(id)){
      throw CalamotException("No exsiste ese juego en nuestra tienda");
    }
    if (tipo == "C"){
      licencia = Licencia.compra(id);
      askData.mostrarMensaje("Has comprado el juego con exito :)");
    }else if (tipo == "L"){
      licencia = Licencia.alquiler(id);
      askData.mostrarMensaje("Has alquilado el juego con exito :)");

    }else if (tipo == "P"){
      licencia = Licencia.prueba(id);
      askData.mostrarMensaje("Has adquirido la prueba del juego con exito :)");
    }else{
      throw CalamotException("Error inesperado");
    }
    usuarioCorrecto!.licencias.add(licencia);

  }

  List<Videojuego<dynamic>> obtenerJuegosFiltrados(String filtro) {
    List<Videojuego<dynamic>> listaFiltrada = []; // esta es la lista de lo que le pedimos
    for (var juego in _juegos) {
      String estiloDelJuego = juego.estilo.name.toLowerCase();
      if (filtro == "todos" || estiloDelJuego == filtro) {
        listaFiltrada.add(juego);
      }
    }
    return listaFiltrada;
    }


}

