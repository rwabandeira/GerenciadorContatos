import 'package:flutter/material.dart';

// Estilos para o Genérico
class GenericoEstilos {
  static final ButtonStyle estiloBotao = ElevatedButton.styleFrom(
    backgroundColor: Colors.orange,
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
    textStyle: const TextStyle(fontSize: 18),
  );

  static final BoxDecoration estiloFundoGradiente = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.blue[400]!, Colors.blue[900]!],
    ),
  );
}

// Estilos para o MenuPrincipal
class MenuPrincipalEstilos {
  static const TextStyle estiloTitulo = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Colors.white,
    shadows: [
      Shadow(
        color: Colors.black,
        blurRadius: 4,
        offset: Offset(2, 2),
      ),
    ],
  );
}

// Estilos para a tela GerenciarContato
class GerenciarContatoEstilos {
  static const TextStyle estiloTextoGerenciarContato = TextStyle(
    fontSize: 18,
    color: Colors.white,
  );

  static const InputDecoration decoracaoCampoTextoGerenciarContato = InputDecoration(
    labelText: 'Nome',
    labelStyle: TextStyle(color: Colors.black),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    errorStyle: TextStyle(color: Colors.white),
  );
}

// Estilos para a tela ListarContato
class ListarContatoEstilos {
  static const TextStyle estiloTextoListarContato = TextStyle(
    fontSize: 18,
    color: Colors.white,
  );
}