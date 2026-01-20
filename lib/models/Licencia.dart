import 'dart:math';

// Enum ajustado al enunciado
enum TipoLicencia { compra, alquiler, prueba }

class Licencia {
  final String id;
  final String idVideojuego;
  final TipoLicencia tipo;

  int _cambiosDePropietarioRestantes;
  int _tiempoDeJuegoRestante;

  // Constructor privado [cite: 65]
  Licencia._(this.id, this.idVideojuego, this.tipo,
      this._cambiosDePropietarioRestantes, this._tiempoDeJuegoRestante);

  // --- FACTORIES (Cumplen con los puntos 3 y 23 del enunciado) ---

  factory Licencia.compra(String idVideojuego) {
    return Licencia._(
        _generarIdAleatorio(),
        idVideojuego,
        TipoLicencia.compra,
        3, // Empieza en 3 cambios [cite: 22]
        -1 // Tiempo infinito
    );
  }

  factory Licencia.alquiler(String idVideojuego) {
    return Licencia._(
        _generarIdAleatorio(),
        idVideojuego,
        TipoLicencia.alquiler,
        0, // 0 cambios [cite: 22]
        -1 // Tiempo infinito
    );
  }

  factory Licencia.prueba(String idVideojuego) {
    return Licencia._(
        _generarIdAleatorio(),
        idVideojuego,
        TipoLicencia.prueba,
        0, // 0 cambios [cite: 22]
        3  // Límite de 3 horas
    );
  }

  // --- MÉTODOS ---

  // Se resta 1h cada vez que se cierra el juego [cite: 25]
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

  // Generador aleatorio de 10 caracteres
  static String _generarIdAleatorio() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    Random rnd = Random();
    return String.fromCharCodes(Iterable.generate(
        10, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  // Getters para acceder a la info privada
  int get cambiosRestantes => _cambiosDePropietarioRestantes;
  int get tiempoRestante => _tiempoDeJuegoRestante;
}