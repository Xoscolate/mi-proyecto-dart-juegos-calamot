import 'package:dart_juegos_calamot/views/CrearGrupoVista.dart';
import 'package:dart_juegos_calamot/views/DarJuego.dart';

import '../models/Jugador.dart';
import '../models/Videojuego.dart';
import '../models/Equipo.dart';
import 'package:dart_juegos_calamot/utils/askData.dart';
import 'package:dart_juegos_calamot/utils/calamotException.dart';
import 'package:dart_juegos_calamot/models/Estilo.dart';
import 'package:dart_juegos_calamot/models/Licencia.dart';
import 'package:dart_juegos_calamot/views/DarJuego.dart';
import 'package:dart_juegos_calamot/views/ListarAmigos.dart';

class ControladorModeloVista {
  final List<Jugador> _jugadores = []; //lista de jugadores
  final List<Videojuego<dynamic>> _juegos = [];
  List<Videojuego<dynamic>> get  todosLosJuegos => _juegos; // lo utilizo como forma simple de ver todos los juegos en tienda
  Jugador? usuarioCorrecto; // esto comienza nulo pero con la funcion entrar le asigno si es correcto
  Videojuego? juegoActivo;// Este es para saber a que juego se esta jugando
  Licencia? licenciaActiva;
  List<Licencia> get licencias => usuarioCorrecto!.licencias;
  String? nombreGrupoActual;
  List<Jugador> grupoActual = [];

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
      _juegos.add(JuegoPuntos("Doom Eternal","doom",Estilo.shooter,39.99,4.99));
      _juegos.add(JuegoCooperativo("Hell Divers","hd",Estilo.shooter,59.99,4.99));
      _juegos.add(JuegoSpeedRun("Sonic Mania","sonic",Estilo.plataformes,39.99,4.99));
      _juegos.add(JuegoVictoriesDerrotes("Street Fighter","st",Estilo.simulacio,59.99,4.99));


    }
  }

  void finalizarSesionJuego() {
    if (usuarioCorrecto != null && juegoActivo != null) {

      // 1. Buscamos la licencia del juego que se estaba jugando
      for (var i = 0; i < usuarioCorrecto!.licencias.length; i++) {
        var lic = usuarioCorrecto!.licencias[i];

        if (lic.idVideojuego == juegoActivo!.codigo) {

          if (lic.tipo == TipoLicencia.prueba ) {
            lic.restarTiempoJugado();
            
            if (lic.tiempoRestante == 0) {
              usuarioCorrecto!.licencias.removeAt(i);
              askData.mostrarMensaje("¡Atención! La demo de ${juegoActivo!.nombre} ha finalizado y se ha eliminado de tu biblioteca.");
            }
          }
        }
      }
    }
  }
  void inicializarUsuariosPrueba() {
    if (_jugadores.isEmpty) {
      _jugadores.add(Jugador(
        nick: "o",
        email: "o@gmail.com",
        contrasena: "o",
      ));

      _jugadores.add(Jugador(
        nick: "a",
        email: "a@gmail.com",
        contrasena: "a",
      ));

      _jugadores.add(Jugador(
        nick: "e",
        email: "e@gmail.com",
        contrasena: "e",
      ));
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

  void activarJuego(String licencia){
    juegoActivo = null;
    licenciaActiva = null;
    for(var l in licencias){
      if (l.id == licencia){
        licenciaActiva = l;

      }

      }
    if (licenciaActiva == null) {
      throw CalamotException("No s'ha trobat la llicència indicada.");

    }
    for (var v in _juegos) {
      if (v.codigo == licenciaActiva!.idVideojuego) {
        juegoActivo = v;
      }
    }
    if (juegoActivo == null) {
      throw CalamotException("El joc d'aquesta llicència no existeix a la botiga.");
    }

    }

  void registrarPuntuacioPartida(String puntuacionString) {
    if (juegoActivo is JuegoPuntos) {
      int? puntos = int.tryParse(puntuacionString);
      if (puntos == null) throw CalamotException("La puntuación debe ser un número");

      juegoActivo!.puntuar(usuarioCorrecto!.email, puntos);
    }

    if (juegoActivo is JuegoSpeedRun) {
      int? segundos = int.tryParse(puntuacionString);
      if (segundos == null) throw CalamotException("Los segundos deben ser un número");

      juegoActivo!.puntuar(usuarioCorrecto!.email, Duration(seconds: segundos));
    }

    if (juegoActivo is JuegoVictoriesDerrotes) {
      bool victoria = puntuacionString == "S";
      List<bool> lista = (juegoActivo as JuegoVictoriesDerrotes)
          .puntuacions[usuarioCorrecto!.email] ?? [];

      lista.add(victoria);
      juegoActivo!.puntuar(usuarioCorrecto!.email, lista);
    }
  }
  void registrarPuntuacioPartidaCoperativo(String puntuacionString) {
    if (usuarioCorrecto == null) {
      throw CalamotException("Has d'estar loguejat per puntuar.");
    }
    if (juegoActivo == null) {
      throw CalamotException("No hi ha cap joc seleccionat per rebre punts.");
    }
    int? puntos = int.tryParse(puntuacionString);
    if (puntos == null) {
      throw CalamotException("ERROR esta puntuacion no es correcta en este juego de puntos");
    }
    juegoActivo!.puntuar(nombreGrupoActual!, puntos);
  }




  List<MapEntry<String, dynamic>> obtenerDatosPuntuaciones() { //utilizo dynamic porque como hay diferentes tipos de puntuaciones luego las declaro.

    if (juegoActivo == null) {
        throw CalamotException("ERROR: no hay juego");
      }
      return juegoActivo!.obtenerDatosHighscores();
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

  void existeJugador(String emailBuscar) {
    bool existe = false;

    for (var j in _jugadores) {
      if (j.email == emailBuscar) {
        existe = true;
        break;
      }
    }

    if (!existe) {
      throw CalamotException("No existe ese jugador en el sistema.");
    }
  }

    bool puedeCrearGrupo(){
    bool cooperativo = false;
    if(juegoActivo is JuegoCooperativo){
      cooperativo = true;
    }else{
      throw CalamotException("Lo siento este juego no es cooperativo");
    }
    return cooperativo;
    }

    void hayEspacioEnElGrupo(){
    if(grupoActual!.length >= 4){
      throw CalamotException("Lo siento los grupos no pueden ser mayor a 4");
    }
    }



    void hayJugadoresEnElSistema(String idVideojuego){
    int hayJugadores = 0;
      for (var j in _jugadores){
        for(var l in j.licencias){
          if(l.idVideojuego == idVideojuego){
            hayJugadores++;
          }
        }
      }
      if(hayJugadores <= 1){
        throw CalamotException("No hay mas jugadores en el sistema con ese juego excepto tu");
      }

    }

    void mostrarJugadoresConEseJuego(String idVideojuego, ControladorModeloVista controlador) {
      for (var j in _jugadores) {
        for (var l in j.licencias) {
          if (l.idVideojuego == idVideojuego) {

            Creargrupovista.mostrarJugadores(j, controlador);
          }
        }
      }
    }

    void unoODos(String numero){
      if (numero != "1" && numero != "2" && numero != "3") {
        throw CalamotException("No exsiste esa opcion");
    }
    }

  void anadirJugadorGrupo(String email) {
    for (var j in _jugadores) {
      if (j.email == email) {
        grupoActual.add(j);
      }
    }

    bool yaEstoy = false;
    for (var j in grupoActual) {
      if (j.email == usuarioCorrecto!.email) {
        yaEstoy = true;
      }
    }

    if (yaEstoy == false) {
      grupoActual.add(usuarioCorrecto!);
    }
  }

    void anadirNombreGrupo (String nombre){
      nombreGrupoActual = nombre;
    }





void yaEstaEnGrupo (String email){
  for(var j in grupoActual ){
    if(j.email == email){
      throw CalamotException("Ese jugador ya esta en el grupo");
    }
  }
}







}

