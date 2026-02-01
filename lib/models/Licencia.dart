import 'dart:math';

enum TipoLicencia { compra, alquiler, prueba }

class Licencia {
  final String id;
  final String idVideojuego;
  final TipoLicencia tipo;

  int _cambiosDePropietarioRestantes;
  int _tiempoDeJuegoRestante;

  Licencia._(this.id, this.idVideojuego, this.tipo,
      this._cambiosDePropietarioRestantes, this._tiempoDeJuegoRestante);


  factory Licencia.compra(String idVideojuego) {
    return Licencia._(
        _generarIdAleatorio(),
        idVideojuego,
        TipoLicencia.compra,
        3,
        -1
    );
  }

  factory Licencia.alquiler(String idVideojuego) {
    return Licencia._(
        _generarIdAleatorio(),
        idVideojuego,
        TipoLicencia.alquiler,
        0,
        -1
    );
  }

  factory Licencia.prueba(String idVideojuego) {
    return Licencia._(
        _generarIdAleatorio(),
        idVideojuego,
        TipoLicencia.prueba,
        0,
        3
    );
  }


  void restarTiempoJugado() {
    if (_tiempoDeJuegoRestante > 0) {
      _tiempoDeJuegoRestante--;
    }
  }

  bool intentarTransferencia() {
    if (_cambiosDePropietarioRestantes > 0) {
      _cambiosDePropietarioRestantes--;
      return true;
    }
    return false;
  }


  static String _generarIdAleatorio() {  //Hacer el check para ver que no se repitan licencias
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    Random rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        10, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  // Getters para acceder a la info privada
  int get cambiosRestantes => _cambiosDePropietarioRestantes;
  int get tiempoRestante => _tiempoDeJuegoRestante;
}