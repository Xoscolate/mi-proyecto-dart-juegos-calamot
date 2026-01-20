class Estadisticas { //Este moelo lo utilizo
  int victorias;
  int derrotas;

  Estadisticas(this.victorias, this.derrotas);

  double get porcentage {
    int total = victorias + derrotas;
    if (total == 0) return 0.0;
    return (victorias / total) * 100;
  }

}
