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
  List<Contato> _contatos = []; // Lista para armazenar os contatos
  int? _idContatoExpandido; // ID do contato que está expandido (se houver)

  // Carregar os contatos do banco de dados
  Future<void> _carregarContatos() async {
    final contatos = await DB.instancia.listarContatos(); // Busca os contatos no banco de dados
    setState(() {
      _contatos = contatos; // Atualiza a lista de contatos
    });
  }

  @override
  void initState() {
    super.initState();
    _carregarContatos(); // Carrega os contatos ao iniciar a tela
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listar Contatos')
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder( // Widget para exibir a lista de contatos
          itemCount: _contatos.length, // Número de contatos na lista
          itemBuilder: (context, index) { // Constrói cada item da lista
            final contato = _contatos[index]; // Contato da posição atual
            final expandido = _idContatoExpandido == contato.id; // Verifica se o contato está expandido

            return Card( // Widget para exibir cada contato em um cartão
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  ListTile( // Widget para exibir o nome do contato
                    title: Text(contato.nome),
                    onTap: () { // Expande ou recolhe o contato ao clicar
                      setState(() {
                        _idContatoExpandido =
                            expandido ? null : contato.id;
                      });
                    },
                  ),
                  if (expandido) ...[ // Exibe os detalhes do contato se estiver expandido
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Telefone: ${contato.telefone}'), // Exibe o telefone
                          Text('E-mail: ${contato.email}'), // Exibe o email
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton( // Botão para editar o contato
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push( // Navega para a tela de gerenciamento de contato
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          GerenciarContato(contato: contato), // Passa o contato para edição
                                    ),
                                  ).then((_) => _carregarContatos()); // Recarrega os contatos após voltar da edição
                                },
                              ),
                              IconButton( // Botão para excluir o contato
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  final confirmacao = await _confirmarExclusao( // Exibe um diálogo de confirmação
                                      context, contato.id!);
                                  if (confirmacao == true) { // Exclui o contato se confirmado
                                    await DB.instancia
                                        .excluirContato(contato.id!);
                                    _carregarContatos(); // Recarrega os contatos após a exclusão
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

  // Função para exibir um diálogo de confirmação de exclusão
  Future<bool?> _confirmarExclusao(BuildContext context, int id) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Deseja excluir o contato?'),
        content: const Text('Essa ação não pode ser desfeita.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // Retorna false (não excluir)
            child: const Text('Não'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true), // Retorna true (excluir)
            child: const Text('Sim'),
          ),
        ],
      ),
    );
  }
}