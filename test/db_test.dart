import 'package:flutter_test/flutter_test.dart';
import 'package:gerenciador_contatos/modelos/contato.dart';
import 'package:gerenciador_contatos/banco_dados/db.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // # TESTE 01
  // Inicializa o ambiente do sqflite_common_ffi para testes
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  // Cria uma instância do banco de dados
  final db = DB();

  group('Teste de operações no banco de dados:', () {
    test('Insere contato no banco de dados', () async {
      // Criação de um contato para teste
      final contato = Contato(
        nome: 'Carlos Alberto de Nobrega',
        telefone: '(11) 91234-5678',
        email: 'carlos@mail.com',
      );

      // Inserção no banco de dados
      final id = await db.inserirContato(contato);

      // Verifica se o ID retornado não é nulo e maior que zero
      expect(id, isNotNull);
      expect(id, greaterThan(0));
    });

    test('Lista contatos do banco de dados', () async {
      // Recupera os contatos armazenados
      final contatos = await db.listarContatos();

      // Verifica se retorna uma lista de contatos
      expect(contatos, isA<List<Contato>>());

      // Caso existam contatos, verifica o primeiro da lista
      if (contatos.isNotEmpty) {
        final primeiroContato = contatos.first;
        expect(primeiroContato.nome, isNotEmpty);
        expect(primeiroContato.telefone, isNotEmpty);
        expect(primeiroContato.email, isNotEmpty);
      }
    });

    test('Atualiza informações de um contato existente', () async {
      // Insere um contato para teste
      final contato = Contato(
        nome: 'Amado',
        telefone: '(11) 91234-5678',
        email: 'amado@mail.com',
      );
      final id = await db.inserirContato(contato);

      // Atualiza as informações do contato
      final contatoAtualizado = Contato(
        id: id,
        nome: 'Amado Batista',
        telefone: '(11) 98765-4321',
        email: 'amado.batista@mail.com',
      );

      final rowsAffected = await db.atualizarContato(contatoAtualizado);

      // Verifica se a atualização foi bem-sucedida
      expect(rowsAffected, 1);

      // Recupera os contatos para confirmar a atualização
      final contatos = await db.listarContatos();
      final contatoConfirmado =
          contatos.firstWhere((c) => c.id == id, orElse: () => throw Exception('Contato não encontrado'));
      expect(contatoConfirmado.nome, 'Amado Batista');
      expect(contatoConfirmado.telefone, '(11) 98765-4321');
      expect(contatoConfirmado.email, 'amado.batista@mail.com');
    });

    test('Exclui um contato do banco de dados', () async {
      // Insere um contato para teste
      final contato = Contato(
        nome: 'Fabio Junior',
        telefone: '(11) 91234-5678',
        email: 'fj@mail.com',
      );
      final id = await db.inserirContato(contato);

      // Exclui o contato
      final rowsDeleted = await db.excluirContato(id);

      // Verifica se a exclusão foi bem-sucedida
      expect(rowsDeleted, 1);

      // Confirma que o contato não está mais no banco de dados
      final contatos = await db.listarContatos();
      final contatoExistente = contatos.any((c) => c.id == id);
      expect(contatoExistente, false);
    });
  });
}
