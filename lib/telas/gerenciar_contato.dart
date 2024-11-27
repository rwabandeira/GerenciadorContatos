import 'package:flutter/material.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart'; // Importar o pacote para a máscara

import '../modelos/contato.dart';
import '../banco_dados/db.dart';

class GerenciarContato extends StatefulWidget {
  final Contato? contato; // Contato opcional para alteração, null se for criação

  const GerenciarContato({super.key, this.contato});

  @override
  State<GerenciarContato> createState() => _GerenciarContatoState();
}

class _GerenciarContatoState extends State<GerenciarContato> {
  final TextEditingController _nomeController = TextEditingController();
  final MaskedTextController _telefoneController = MaskedTextController(mask: '(00) 00000-0000'); // Máscara inicial para celular
  final TextEditingController _emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Adicionando chave para validação do formulário

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

  void _atualizarMascaraTelefone() {
    String telefone = _telefoneController.text.replaceAll(RegExp(r'\D'), ''); // Remover caracteres não numéricos
    if (telefone.length == 3) {
      // Caso o DDD tenha sido preenchido (exemplo: 011), mantém a máscara padrão
      _telefoneController.updateMask('(00) 00000-0000'); // Máscara celular
    } else if (telefone.length == 4) {
      // Verificando o início do número após o DDD
      if (telefone[2] == '9') {
        // Se o terceiro caractere (dígito após o DDD) for "9", é celular
        _telefoneController.updateMask('(00) 00000-0000');
      } else {
        // Caso contrário, é telefone fixo
        _telefoneController.updateMask('(00) 0000-0000');
      }
    }
  }

  Future<void> _salvarContato() async {
    if (_formKey.currentState?.validate() ?? false) {
      final contato = Contato(
        id: widget.contato?.id, // Se for uma alteração, mantém o ID do contato original
        nome: _nomeController.text,
        telefone: _telefoneController.text,
        email: _emailController.text,
      );
      if (contato.id == null) {
        // Se o ID for null, é uma inclusão
        await DB.instancia.inserirContato(contato);
      } else {
        // Se o ID não for null, é uma alteração
        await DB.instancia.atualizarContato(contato);
      }
      Navigator.pop(context, contato); // Retorna o contato atualizado para a tela anterior
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contato == null ? 'Cadastrar Contato' : 'Alterar Contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Associando o formulário à chave para validação
          child: Column(
            children: [
              // Campo Nome
              TextFormField(
                controller: _nomeController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o nome.';
                  }
                  return null;
                },
              ),
              // Campo Telefone com máscara dinâmica e validação
              TextFormField(
                controller: _telefoneController,
                decoration: const InputDecoration(labelText: 'Telefone'),
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  _atualizarMascaraTelefone(); // Atualizar a máscara quando o texto mudar
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o telefone.';
                  }
                  // Remover máscara para verificar o número real
                  final telefone = value.replaceAll(RegExp(r'\D'), ''); // Remove caracteres não numéricos
                  if (telefone.length != 10 && telefone.length != 11) {
                    return 'O telefone deve ter 10 (fixo) ou 11 (celular) dígitos.';
                  }
                  return null;
                },
              ),
              // Campo E-mail com validação
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
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
                    onPressed: _salvarContato,
                    child: const Text('Salvar'),
                  ),
                  // Botão Cancelar
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
