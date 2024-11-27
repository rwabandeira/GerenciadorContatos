import 'package:flutter/material.dart';
import 'gerenciar_contato.dart';  // Alterado para GerenciarContato
import 'listar_contato.dart';

class MenuPrincipal extends StatelessWidget {
  const MenuPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu Principal')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Gerenciador de Contatos',
              style: TextStyle(
                fontSize: 24, 
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Image.asset('assets/imagem_menu.png', height: 200),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const GerenciarContato()),
                  ),
                  child: const Text('Cadastrar'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => Navigator.push(
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
