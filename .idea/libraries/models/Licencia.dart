class Licencia {
  final String id;
  final String idVideojuego;
  final TipoLicencia tipo;

  // Atributos privados mutables
  int _cambiosDePropietarioRestantes;
  int _tiempoDeJuegoRestante;

  // --- CAMBIO CLAVE: CONTADOR ESTÁTICO ---
  // Al ser static, este valor se guarda en la "fábrica", no en la tarjeta.
  // Empieza en 0 y subirá a 1, 2, 3...
  static int _contadorGlobal = 0;

  // Constructor Privado
  Licencia._(this.id, this.idVideojuego, this.tipo, this._cambiosDePropietarioRestantes, this._tiempoDeJuegoRestante);

  // --- FACTORIES (Usan el nuevo generador) ---

  factory Licencia.compra(String idVideojuego) {
    return Licencia._(
        _generarIdSecuencial(), // Llamamos al método que hace el +1
        idVideojuego,
        TipoLicencia.compra,
        3,
        -1
    );
  }

  factory Licencia.alquiler(String idVideojuego) {
    return Licencia._(
        _generarIdSecuencial(),
        idVideojuego,
        TipoLicencia.alquiler,
        0,
        -1
    );
  }

  factory Licencia.prueba(String idVideojuego) {
    return Licencia._(
        _generarIdSecuencial(),
        idVideojuego,
        TipoLicencia.prueba,
        0,
        3
    );
  }

  // --- MÉTODOS Y GETTERS ---

  int get cambiosRestantes => _cambiosDePropietarioRestantes;
  int get tiempoRestante => _tiempoDeJuegoRestante;

  void restarTiempoJugado() {
    if (_tiempoDeJuegoRestante == -1) return;
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

  // --- NUEVO GENERADOR SIMPLE (+1) ---
  static String _generarIdSecuencial() {
    _contadorGlobal++; // Sumamos 1 al contador global

    // Lo convertimos a String porque la variable 'final String id' espera texto.
    // El ID será "1", luego "2", luego "3"...
    return _contadorGlobal.toString();
  }
}