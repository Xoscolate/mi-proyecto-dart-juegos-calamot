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
  Licencia? licenciaActiva; //Esto para saber que licencia esta activa
  List<Licencia> get licencias => usuarioCorrecto!.licencias; //Para mirar las licencias del usuario activo
  String? nombreGrupoActual; //Lo utilizo para guardar el nombre del grupo en el que esta el usuario actualmente
  List<Jugador> grupoActual = []; //Es la lista de jugadores del grupo activo
  Map<String, List<Jugador>> gruposGlobales = {};

  void entrar(String emailIntroducido, String contrasena) { // Metodo para entrar al programa con el mail y contraseñas
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

  void verificarFormatoEmail(String email) { // pequeño metodo que entra al askData y valida para el registrar
    if (!email.isValidEmail()) {
      throw CalamotException("El format de l'email '$email' no és vàlid.");
    }
  }


  void registrar(String email, String nick, String contrasena,) { //Pedimos al usuario esos datos y creamos al usuario y lo
    //guardamos en la lista de _jugadores
    verificarFormatoEmail(email);
    emailExsiste(email);
      Jugador nuevoJugador = Jugador(
          email: email,
          nick: nick,
          contrasena: contrasena
      );

      _jugadores.add(nuevoJugador);
    }


  void emailExsiste (String email){ //Miramos si ese mail ya esta en el programa
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



  void inicializarTienda() { //Es para que la tienda tenga juegos
    if (_juegos.isEmpty) {
      _juegos.add(JuegoPuntos("Doom Eternal","doom",Estilo.shooter,39.99,4.99));
      _juegos.add(JuegoCooperativo("Hell Divers","hd",Estilo.shooter,59.99,4.99));
      _juegos.add(JuegoSpeedRun("Sonic Mania","sonic",Estilo.plataformes,39.99,4.99));
      _juegos.add(JuegoVictoriesDerrotes("Street Fighter","st",Estilo.simulacio,59.99,4.99));


    }
  }

  void finalizarSesionJuego() { //Lo utilizo para que vaya comprobando si los usos se han acabado y si es asi pues te lo elimina de tu biblioteca
    //lista de licencias.
    if (usuarioCorrecto != null && juegoActivo != null) {

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
  void inicializarUsuariosPrueba() { // ESTO SE ELIMINARA
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

  bool exsisteId(String id){ //metodo booleano para ver si esa id exsiste (doom, hd...)
    for (var j in _juegos) {
      if (j.codigo == id){
        return true;
      }
      }
    return false;
    }

  void adquirirLicencia(String tipo, ControladorModeloVista controlador, String id){ //Creo la licencia y asi se te asigna de ese juego
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

  bool amigoExsiste (String email){ //metodo para comprobar ese mail
    for (var j in _jugadores) {
      if(email == j.email){
        return true;
      }
    }
    return false;

    }
  void tienesLicencia(String licencia) { //metodo para ver si esa licencia ya la tienes adquirida ( es para
    //comprobar si tienes ese juego en tu biblioteca).
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

  void activarJuego(String licencia){ //Para entrar a un juego, se necesita poner su licencia
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

  void registrarPuntuacioPartida(String puntuacionString) { //Este metodo es para el registro de puntos
    //de cada juego, cada juego se comporta de una manera distinta (puntos de mayor a menor, speedrun de menor a mayor
    //victorias derrotas muestra porcentaje y de mayor a menor, colaborativa de mayor a menor por grupos
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



  void tienesJuego(String idJuego) { //Comprobacion de si tienes el juego, aqui no miro la id de la licencia sino
    //la id del juego (no se pueden repetir el mismo tipo juego)
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
  void anadirAmigo (String email){ // Metodo para añadir amigo
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
        j.amigos.add(usuarioCorrecto!.email);
      }
    }
  }




  List<Videojuego<dynamic>> obtenerJuegosFiltrados(String filtro) { //Esto es para mirar en la tienda los juegos filtrados
    List<Videojuego<dynamic>> listaFiltrada = []; // esta es la lista de lo que le pedimos
    for (var juego in _juegos) {
      String estiloDelJuego = juego.estilo.name.toLowerCase();
      if (filtro == "todos" || estiloDelJuego == filtro) {
        listaFiltrada.add(juego);
      }
    }
    return listaFiltrada;
    }


    void validacionCambios (String idLicenciaADonar, String emailDestinatario){ //Metodo que se utiliza para cambiar
    // de licencia de un usuario a otro, comprueba los cambios restantes para que los de alquiler no se pasen o demos
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
  void ejecutarTraspaso(String idLicencia, String emailAmigo) { //Se ejecuta despues de mirar la validacion de cambios
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





  void amigoTieneEseJuego(String idLicencia, String amigo) { //Comrpueba si tu amigo tiene ese juego, no la misma licencia
    //sino que comrpueba el id del videojuego
    bool loTiene = false;
    String codigo = "";
    for (var lic in usuarioCorrecto!.licencias) {
      if (lic.id == idLicencia) {
        codigo = lic.idVideojuego;
      }
    }
    Jugador? receptor; // Esto es para guardar al amigo y entrar a sus licencias
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

  void amigosAgregados() { //Simplemente mira los amigos que tienes en tu lista
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

  void juegosQueTienes() { //Mira las licencias que tiene el usuario activo
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

    bool puedeCrearGrupo(){ //Este metodo lo cree porque si el juego no es cooperativo no deberias poder crear un juego
    bool cooperativo = false;
    if(juegoActivo is JuegoCooperativo){
      cooperativo = true;
    }else{
      throw CalamotException("Lo siento este juego no es cooperativo");
    }
    return cooperativo;
    }

    void hayEspacioEnElGrupo(){ // He hecho que los juegos no puedan ser mayor a 4 (tipico de los juegos).
    if(grupoActual!.length >= 4){
      throw CalamotException("Lo siento los grupos no pueden ser mayor a 4");
    }
    }



    void hayJugadoresEnElSistema(String idVideojuego){ //Miramos si hay jugadores con ese juego, porque si no hay nadie
    //con ese juego no puedes crear un grupo para ese juego
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

    void mostrarJugadoresConEseJuego(String idVideojuego, ControladorModeloVista controlador) { //Recorre los jugadores
    //con ese juego especifico para enseñartelos
      for (var j in _jugadores) {
        for (var l in j.licencias) {
          if (l.idVideojuego == idVideojuego) {

            Creargrupovista.mostrarJugadores(j, controlador);
          }
        }
      }
    }

    void unoODos(String numero){ //Solamente comprueba que sea una de esas opciones
      if (numero != "1" && numero != "2" && numero != "3") {
        throw CalamotException("No exsiste esa opcion");
    }
    }

  void anadirJugadorGrupo(String email) { // Despues de las comprobaciones añado al jugador al grupo
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

  void recuperarGrupoDelSistema() {
    if (usuarioCorrecto != null && grupoActual.isEmpty) {

      for (var nombre in gruposGlobales.keys) {
        List<Jugador> lista = gruposGlobales[nombre]!;

        for (var j in lista) {
          if (j.email == usuarioCorrecto!.email) {
            grupoActual = lista;
            nombreGrupoActual = nombre;
          }
        }
      }
    }
  }

  void nombreGrupoDisponible(String nombre) {
    if (gruposGlobales.containsKey(nombre)) {
      throw CalamotException("Ese nombre de grupo ya existe, elige otro.");
    }
  }

  void guardarGrupoEnSistema() {
    if (nombreGrupoActual != null) {
      gruposGlobales[nombreGrupoActual!] = List.from(grupoActual);
    }
  }

  void salirDelGrupoOficial() {
    if (nombreGrupoActual != null && gruposGlobales.containsKey(nombreGrupoActual)) {

      List<Jugador> lista = gruposGlobales[nombreGrupoActual!]!;
      Jugador? jugadorEncontrado;

      for (var j in lista) {
        if (j.email == usuarioCorrecto!.email) {
          jugadorEncontrado = j;
        }
      }

      if (jugadorEncontrado != null) {
        lista.remove(jugadorEncontrado);
      }

      if (lista.isEmpty) {
        gruposGlobales.remove(nombreGrupoActual);
      }
    }

    grupoActual = [];
    nombreGrupoActual = null;
  }

  void jugadorYaTieneGrupoEnSistema(String email) {
    for (var nombre in gruposGlobales.keys) {
      List<Jugador> lista = gruposGlobales[nombre]!;

      for (var j in lista) {
        if (j.email == email) {
          throw CalamotException("El jugador con email $email ya está en el grupo: $nombre");
        }
      }
    }
  }
}

