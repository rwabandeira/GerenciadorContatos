import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import '../modelos/contato.dart';
import '../banco_dados/db.dart';
import '../estilos/estilo.dart';

class GerenciarContato extends StatefulWidget {
  final Contato? contato; // Contato que será gerenciado (pode ser nulo para um novo contato)
  const GerenciarContato({super.key, this.contato});

  @override
  State<GerenciarContato> createState() => _GerenciarContatoState();
}

class _GerenciarContatoState extends State<GerenciarContato> {
  // Controladores para os campos de texto
  final TextEditingController _nomeController = TextEditingController();
  final MaskedTextController _telefoneController = MaskedTextController(mask: '(00) 00000-0000'); // Máscara inicial para celular
  final TextEditingController _emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Chave para o formulário

  @override
  void initState() {
    super.initState();
    // Se um contato for passado para a tela, preenche os campos com os dados do contato
    if (widget.contato != null) {
      _nomeController.text = widget.contato!.nome;
      _telefoneController.text = widget.contato!.telefone;
      _emailController.text = widget.contato!.email;
    }
  }

  // Função para atualizar a máscara do telefone dinamicamente
  void _atualizarMascaraTelefone() {
    String telefone = _telefoneController.text.replaceAll(RegExp(r'\D'), ''); // Remove caracteres não numéricos
    if (telefone.length == 3) {
      _telefoneController.updateMask('(00) 00000-0000'); // Define a máscara para celular
    } else if (telefone.length == 4) {
      if (telefone[2] == '9') {
        _telefoneController.updateMask('(00) 00000-0000'); // Mantém a máscara para celular
      } else {
        _telefoneController.updateMask('(00) 0000-0000'); // Define a máscara para telefone fixo
      }
    }
  }

  // Função para salvar o contato no banco de dados
  Future<void> _salvarContato() async {
    if (_formKey.currentState?.validate() ?? false) { // Valida o formulário
      // Cria um objeto Contato com os dados dos campos
      final contato = Contato(
        id: widget.contato?.id,
        nome: _nomeController.text,
        telefone: _telefoneController.text,
        email: _emailController.text,
      );
      if (contato.id == null) {
        await DB.instancia.inserirContato(contato); // Insere um novo contato
      } else {
        await DB.instancia.atualizarContato(contato); // Atualiza um contato existente
      }
      Navigator.pop(context, contato); // Fecha a tela e retorna o contato
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Define o título da AppBar de acordo com a ação (cadastrar ou alterar)
        title: Text(widget.contato == null ? 'Cadastrar Contato' : 'Alterar Contato'),
        backgroundColor: Colors.blue[400], // Cor da AppBar
      ),
      body: Container( // Adicione o Container para o gradiente
        decoration: GenericoEstilos.estiloFundoGradiente, // Aplica o estilo de fundo gradiente
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // Define a chave do formulário
            child: Column(
              children: [
                // Campo Nome
                TextFormField(
                  controller: _nomeController,
                  style: GerenciarContatoEstilos.estiloTextoGerenciarContato, // Aplica o estilo de texto
                  decoration: GerenciarContatoEstilos.decoracaoCampoTextoGerenciarContato, // Aplica a decoração do campo
                  validator: (value) { // Validação do campo nome
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o nome.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10), // Espaçamento vertical
                // Campo Telefone
                TextFormField(
                  controller: _telefoneController,
                  style: GerenciarContatoEstilos.estiloTextoGerenciarContato, // Aplica o estilo de texto
                  decoration: GerenciarContatoEstilos.decoracaoCampoTextoGerenciarContato.copyWith(labelText: 'Telefone'), // Aplica a decoração do campo
                  keyboardType: TextInputType.phone,
                  onChanged: (value) { // Chama a função para atualizar a máscara do telefone a cada mudança
                    _atualizarMascaraTelefone();
                  },
                  validator: (value) { // Validação do campo telefone
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o telefone.';
                    }
                    // Remover máscara para verificar o número real
                    final telefone = value.replaceAll(RegExp(r'\D'), '');
                    if (telefone.length != 10 && telefone.length != 11) {
                      return 'O telefone deve ter 10 (fixo) ou 11 (celular) dígitos.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10), // Espaçamento vertical
                // Campo E-mail
                TextFormField(
                  controller: _emailController,
                  style: GerenciarContatoEstilos.estiloTextoGerenciarContato, // Aplica o estilo de texto
                  decoration: GerenciarContatoEstilos.decoracaoCampoTextoGerenciarContato.copyWith(labelText: 'E-mail'), // Aplica a decoração do campo
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) { // Validação do campo email
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o e-mail.';
                    }
                    final emailRegExp = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                    if (!emailRegExp.hasMatch(value)) {
                      return 'Por favor, insira um e-mail válido.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Botão Salvar
                    ElevatedButton(
                      style: GenericoEstilos.estiloBotao, // Aplica o estilo de botão
                      onPressed: _salvarContato, // Chama a função para salvar o contato
                      child: const Text('Salvar', style: TextStyle(color: Colors.white)),
                    ),
                    // Botão Cancelar
                    ElevatedButton(
                      style: GenericoEstilos.estiloBotao, // Aplica o estilo de botão
                      onPressed: () => Navigator.pop(context), // Fecha a tela
                      child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}