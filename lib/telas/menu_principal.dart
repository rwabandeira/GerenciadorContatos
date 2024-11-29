import 'package:flutter/material.dart';
import 'gerenciar_contato.dart';
import 'listar_contato.dart';

class MenuPrincipal extends StatelessWidget {
  const MenuPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Widget que define a estrutura básica da tela
      body: Center( // Centraliza o conteúdo na tela
        child: Column( // Organiza os elementos em uma coluna
          mainAxisAlignment: MainAxisAlignment.center, // Alinha os elementos no centro verticalmente
          children: <Widget>[ // Lista de widgets que serão exibidos na tela
            Text( // Widget para exibir o título
              'Gerenciador de Contatos',
              style: TextStyle( // Define o estilo do texto
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20), // Espaçamento vertical
            Image.asset('assets/imagem_menu.png', height: 200), // Exibe uma imagem
            SizedBox(height: 40), // Espaçamento vertical
            Row( // Organiza os botões em uma linha
              mainAxisAlignment: MainAxisAlignment.center, // Alinha os botões no centro horizontalmente
              children: [
                ElevatedButton( // Botão para cadastrar um novo contato
                  onPressed: () => Navigator.push( // Navega para a tela de gerenciamento de contato
                    context,
                    MaterialPageRoute(builder: (context) => const GerenciarContato()),
                  ),
                  child: const Text('Cadastrar'),
                ),
                const SizedBox(width: 20), // Espaçamento horizontal
                ElevatedButton( // Botão para listar os contatos
                  onPressed: () => Navigator.push( // Navega para a tela de listagem de contatos
                    context,
                    MaterialPageRoute(builder: (context) => const ListarContato()),
                  ),
                  child: const Text('Listar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}