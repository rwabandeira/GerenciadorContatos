import 'package:flutter/material.dart';
import '../banco_dados/db.dart';
import '../modelos/contato.dart';
import 'gerenciar_contato.dart';

class ListarContato extends StatefulWidget {
  const ListarContato({super.key});

  @override
  State<ListarContato> createState() => _ListarContatoState();
}

class _ListarContatoState extends State<ListarContato> {
  List<Contato> _contatos = [];
  int? _contatoExpandido; // Para armazenar o ID do contato expandido

  // Carregar os contatos do banco de dados
  Future<void> _carregarContatos() async {
    final contatos = await DB.instancia.buscarContatos();
    setState(() {
      _contatos = contatos;
    });
  }

  @override
  void initState() {
    super.initState();
    _carregarContatos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listar Contatos')
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: _contatos.length,
          itemBuilder: (context, index) {
            final contato = _contatos[index];
            final expandido = _contatoExpandido == contato.id;

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  ListTile(
                    title: Text(contato.nome),
                    onTap: () {
                      setState(() {
                        _contatoExpandido =
                            expandido ? null : contato.id; // Alterna a expansão
                      });
                    },
                  ),
                  if (expandido) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Telefone: ${contato.telefone}'),
                          Text('E-mail: ${contato.email}'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          GerenciarContato(contato: contato),
                                    ),
                                  ).then((_) => _carregarContatos());
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  final confirmacao = await _confirmarExclusao(
                                      context, contato.id!);
                                  if (confirmacao == true) {
                                    await DB.instancia
                                        .excluirContato(contato.id!);
                                    _carregarContatos();
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<bool?> _confirmarExclusao(BuildContext context, int id) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Deseja excluir o contato?'),
        content: const Text('Essa ação não pode ser desfeita.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Não'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Sim'),
          ),
        ],
      ),
    );
  }
}
