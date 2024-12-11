import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:gerenciador_contatos/telas/gerenciar_contato.dart';
import 'package:gerenciador_contatos/modelos/contato.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // # TESTE 01
  testWidgets('Widgets são renderizados corretamente', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: GerenciarContato()));

    expect(find.byType(TextFormField), findsNWidgets(3));
    expect(find.text('Nome'), findsOneWidget);
    expect(find.text('Telefone'), findsOneWidget);
    expect(find.text('E-mail'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Salvar'), findsOneWidget);
    expect(find.widgetWithText(ElevatedButton, 'Cancelar'), findsOneWidget);
  });

  // # TESTE 02
  testWidgets('Validação do nome', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: GerenciarContato()));
    final nomeField = find.byType(TextFormField).first;

    await tester.enterText(nomeField, '');
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, 'Salvar'));
    await tester.pump();
    expect(find.text('Por favor, insira o nome.'), findsOneWidget);

    await tester.enterText(nomeField, 'Nome Válido');
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, 'Salvar'));
    await tester.pump();
    expect(find.text('Por favor, insira o nome.'), findsNothing);
  });

  // # TESTE 03
  testWidgets('Validação do telefone', (WidgetTester tester) async {
    // Testa com o campo vazio
    await tester.pumpWidget(const MaterialApp(home: GerenciarContato()));
    final telefoneField = find.byType(TextFormField).at(1);

    await tester.enterText(telefoneField, '');
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, 'Salvar'));
    await tester.pumpAndSettle();
    expect(find.text('Por favor, insira o telefone.'), findsOneWidget);

    // Testa com um número inválido (poucos dígitos)
    await tester.enterText(telefoneField, '(11) 1234-5');
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, 'Salvar'));
    await tester.pumpAndSettle();
    expect(find.text('O telefone deve ter 10 (fixo) ou 11 (celular) dígitos.'), findsOneWidget);

    // Testa com um número válido (celular)
    await tester.enterText(telefoneField, '(11) 91234-5678');
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, 'Salvar'));
    await tester.pumpAndSettle();
    expect(find.text('O telefone deve ter 10 (fixo) ou 11 (celular) dígitos.'), findsNothing);

    // Testa com um número válido (fixo)
    await tester.enterText(telefoneField, '(11) 1234-5678');
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, 'Salvar'));
    await tester.pumpAndSettle();
    expect(find.text('O telefone deve ter 10 (fixo) ou 11 (celular) dígitos.'), findsNothing);
  });

  // # TESTE 04
  testWidgets('Validação do email', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: GerenciarContato()));
    final emailField = find.byType(TextFormField).at(2);

    // Testa com o campo vazio
    await tester.enterText(emailField, '');
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, 'Salvar'));
    await tester.pump();
    expect(find.text('Por favor, insira o e-mail.'), findsOneWidget);

    // Testa com um e-mail inválido
    await tester.enterText(emailField, 'email_invalido');
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, 'Salvar'));
    await tester.pump();
    expect(find.text('Por favor, insira um e-mail válido.'), findsOneWidget);

    // Testa com um e-mail válido
    await tester.enterText(emailField, 'email@valido.com');
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, 'Salvar'));
    await tester.pump();
    expect(find.text('Por favor, insira um e-mail válido.'), findsNothing);
  });

  // # TESTE 05
  testWidgets('Campos são preenchidos ao alterar um contato existente', (WidgetTester tester) async {
    final contato = Contato(id: 1, nome: 'João Silva', telefone: '(11) 91234-5678', email: 'joao@email.com');

    await tester.pumpWidget(MaterialApp(home: GerenciarContato(contato: contato)));

    expect(find.text('João Silva'), findsOneWidget);
    expect(find.text('(11) 91234-5678'), findsOneWidget);
    expect(find.text('joao@email.com'), findsOneWidget);
  });

  // # TESTE 06
  testWidgets('Botão Cancelar fecha a tela sem salvar alterações', (WidgetTester tester) async {
    bool foiChamado = false;

    await tester.pumpWidget(MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          body: ElevatedButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const GerenciarContato()),
              );
              foiChamado = true;
            },
            child: const Text('Abrir GerenciarContato'),
          ),
        ),
      ),
    ));

    await tester.tap(find.text('Abrir GerenciarContato'));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ElevatedButton, 'Cancelar'));
    await tester.pumpAndSettle();

    expect(foiChamado, isTrue);
  });

  // # TESTE 07
  testWidgets('Botão Salvar salva o contato com dados válidos', (WidgetTester tester) async {
    databaseFactory = databaseFactoryFfi;
    final contato = Contato(id: null, nome: 'Maria Silva', telefone: '(11) 98765-4321', email: 'maria@email.com');

    await tester.pumpWidget(MaterialApp(
      home: GerenciarContato(contato: contato),
    ));

    await tester.enterText(find.byType(TextFormField).at(0), 'Maria Silva');
    await tester.enterText(find.byType(TextFormField).at(1), '(11) 98765-4321');
    await tester.enterText(find.byType(TextFormField).at(2), 'maria@email.com');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Salvar'));
    await tester.pumpAndSettle();

    expect(find.text('Cadastrar Contato'), findsNothing);
  });
}