extension EmailValidator on String {
  bool isValidEmail() {
    final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return emailRegExp.hasMatch(this); // 'this' es el String que estamos comprobando
  }
}