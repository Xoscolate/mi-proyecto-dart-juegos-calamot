import 'package:dart_juegos_calamot/models/JuegoPuntos.dart';
import 'package:dart_juegos_calamot/models/JuegoSpeedRun.dart';
import 'package:dart_juegos_calamot/views/DarJuego.dart';

import '../models/Jugador.dart';
import '../models/Videojuego.dart';
import '../models/Equipo.dart';
import 'package:dart_juegos_calamot/utils/askData.dart';
import 'package:dart_juegos_calamot/utils/calamotException.dart';
import 'package:dart_juegos_calamot/models/Estilo.dart';
import 'package:dart_juegos_calamot/models/Licencia.dart';
import 'package:dart_juegos_calamot/models/TiposLicencia.dart';
import 'package:dart_juegos_calamot/views/DarJuego.dart';
import 'package:dart_juegos_calamot/views/ListarAmigos.dart';

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
    if(usuarioCorrecto == null){
      throw CalamotException("Error inesperado");
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

  bool amigoExsiste (String email){
    for (var j in _jugadores) {
      if(email == j.email){
        return true;
      }
    }
    return false;

    }
  void tienesLicencia(String licencia) {
    bool yaLoTiene = false;

    for (var l in usuarioCorrecto!.licencias) {
      if (l.id == licencia) {
        yaLoTiene = true;
      }
    }

    if (!yaLoTiene) {
      throw CalamotException("No tienes este juego en tu biblioteca");
    }
  }

  void tienesJuego(String idJuego) {
    bool yaLoTiene = false;

    for (var l in usuarioCorrecto!.licencias) {
      if (l.idVideojuego == idJuego) {
        yaLoTiene = true;
      }
    }

    if (yaLoTiene) {
      throw CalamotException("Ya tienes este juego en tu biblioteca");
    }
  }
    void anadirAmigo (String email){
    if (usuarioCorrecto == null) {
      throw CalamotException("usuario inexsisitente");
    }
    if(!amigoExsiste(email)){
      throw CalamotException("Ese amigo es inexsistente");
    }
    if (usuarioCorrecto!.email == email) {
      throw CalamotException("No puedes ser tu propio amigo, buscate alguno loquete.");
    }

    usuarioCorrecto!.amigos.add(email);
    for(var j in _jugadores){
      if (j.email == email){
        j.amigos.add(email);
      }
    }
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

    void darJuego(String idLicencia, String emailAmigo){
      if (usuarioCorrecto == null) {
        throw CalamotException("usuario inexsisitente");
      }
    }

    void validacionCambios (String idLicenciaADonar, String emailDestinatario){
      Licencia? licEncontrada;
      for (var lic in usuarioCorrecto!.licencias) {
        if (lic.id == idLicenciaADonar) {
          licEncontrada = lic;
        }
      }

      if (licEncontrada == null) {
        throw CalamotException("No tienes esta licencia.");
      }

      if (licEncontrada.cambiosRestantes <= 0) {
        throw CalamotException("Esta licencia no se puede dar a un amigo.");
      }
    }
  void ejecutarTraspaso(String idLicencia, String emailAmigo) {
    String idBuscado = idLicencia.trim();
    String emailBuscado = emailAmigo.trim().toLowerCase();
    Licencia? licenciaParaMover;
    for (var lic in usuarioCorrecto!.licencias) {
      if (lic.id == idBuscado) {
        licenciaParaMover = lic;
      }
    }
    if (licenciaParaMover != null) {
      if (!licenciaParaMover.intentarTransferencia()) {
        throw CalamotException("Lo siento no tienes mas transferencias restantes.");
      }
      bool entregado = false;
      for (var j in _jugadores) {
        if (j.email.trim().toLowerCase() == emailBuscado) {
          j.licencias.add(licenciaParaMover);
          entregado = true;
        }
      }
      if (entregado) {
        usuarioCorrecto!.licencias.remove(licenciaParaMover);
      } else {
        throw CalamotException("No se ha encontrado al jugador con ese email");
      }
    } else {
      throw CalamotException("No se ha encontrado la licencia con ese ID");
    }
  }





  void amigoTieneEseJuego(String idLicencia, String amigo) {
    bool loTiene = false;
    String codigo = "";
    for (var lic in usuarioCorrecto!.licencias) {
      if (lic.id == idLicencia) {
        codigo = lic.idVideojuego;
      }
    }
    Jugador? receptor;
    for (var jug in _jugadores) {
      if (jug.email == amigo) {
        receptor = jug;
      }
    }
    if (receptor != null) {
      for (var l in receptor.licencias) {
        if (l.idVideojuego == codigo) {
          loTiene = true;
        }
      }
    }
    if (loTiene) {
      throw CalamotException("Tu amigo ya tiene ese juego en su biblioteca");
    }
  }

  void amigosAgregados() {
    if (usuarioCorrecto?.amigos.isEmpty ?? true) {
      throw CalamotException("Ahora mismo no tienes amigos");
    }

    for (String a in usuarioCorrecto!.amigos) {
      for (var j in _jugadores) {
        if (a == j.email) {
          ListarAmigos.mostrarAmigo(j);
        }
      }
    }
  }

    void mostrarAmigos(){

      if (usuarioCorrecto?.amigos.isEmpty ?? true) {
        throw CalamotException("Ahora mismo no tienes amigos");
    }

    for (String a in usuarioCorrecto!.amigos){
      for(var j in _jugadores){
        if (a == j.email){
          DarJuego.mostrarAmigos(j);
        }
      }
    }
    }

  void juegosQueTienes() {
    if (usuarioCorrecto?.licencias.isEmpty ?? true) {
      throw CalamotException("Ahora mismo no tienes licencias");
    }
    for (var a in usuarioCorrecto!.licencias) {
      for (var j in _juegos) {
        if (a.idVideojuego == j.codigo) {
          DarJuego.mostrarJuegos(j, a);
        }
      }
    }
  }

    void exsisteAmigo(String emailBuscar){
    bool exsiste = false;
    for (String email in usuarioCorrecto!.amigos) {
      if (email == emailBuscar) {
        exsiste = true;
         }
      }
    if (!exsiste){
      throw CalamotException("No exsiste ese amigo");
    }
    }





}

