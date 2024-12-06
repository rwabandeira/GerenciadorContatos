import 'package:flutter/material.dart';
import 'db.dart'; // Importando a classe DB que contém os métodos de acesso ao banco
import '../modelos/contato.dart'; // Importando a classe Contato

class DebugPage extends StatefulWidget {
  @override
  _DebugPageState createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  // Lista para armazenar os contatos recuperados do banco de dados
  List<Contato> _contatos = [];

  @override
  void initState() {
    super.initState();
    // Carregar os contatos do banco assim que a tela for iniciada
    _carregarContatos();
  }

  // Método para carregar os contatos do banco de dados
  Future<void> _carregarContatos() async {
    List<Contato> contatos = await DB.instancia.listarContatos();
    setState(() {
      _contatos = contatos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela de Depuração'),
      ),
      body: _contatos.isEmpty
          ? Center(child: CircularProgressIndicator()) // Exibe um carregando enquanto os dados estão sendo buscados
          : ListView.builder(
              itemCount: _contatos.length,
              itemBuilder: (context, index) {
                final contato = _contatos[index];
                return ListTile(
                  title: Text(contato.nome), // Exibe o nome do contato
                  subtitle: Text('Telefone: ${contato.telefone}\nEmail: ${contato.email}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      // Exclui o contato ao clicar no ícone
                      await DB.instancia.excluirContato(contato.id!);
                      _carregarContatos(); // Recarrega a lista de contatos após exclusão
                    },
                  ),
                );
              },
            ),
    );
  }
}
