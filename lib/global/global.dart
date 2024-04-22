ajustarTexto(texto){
  return texto.toString().replaceAll(RegExp(r'[()]'), "").toString();
}