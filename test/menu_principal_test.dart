import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gerenciador_contatos/telas/menu_principal.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  // # TESTE 01
  databaseFactory = databaseFactoryFfi;
  testWidgets('Verifica se o título e botões estão na tela inicial', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: MenuPrincipal()));

    // Verificar título
    expect(find.text('Gerenciador de Contatos'), findsOneWidget);

    // Verificar botões
    expect(find.text('Cadastrar'), findsOneWidget);
    expect(find.text('Listar'), findsOneWidget);
  });

  // # TESTE 02
  testWidgets('Navegar para a "Cadastrar Contato" ao clicar em "Cadastrar"', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MenuPrincipal(),
      routes: {'/gerenciar_contato': (context) => Scaffold(body: Text('Cadastrar Contatos'))},
    ));

    // Clicar no botão "Cadastrar"
    await tester.tap(find.text('Cadastrar'));
    await tester.pumpAndSettle();

    // Verificar se navegou para a tela Cadastrar Contato
    expect(find.text('Cadastrar Contato'), findsOneWidget);
  });

  // # TESTE 03
  testWidgets('Navegar para a "Listar Contatos" ao clicar em "Listar"', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: MenuPrincipal(),
      routes: {'/listar_contato': (context) => Scaffold(body: Text('Listar Contatos'))},
    ));

    // Clicar no botão "Listar"
    await tester.tap(find.text('Listar'));
    await tester.pumpAndSettle();

    // Verificar se navegou para a tela Listar Contatos
    expect(find.text('Listar Contatos'), findsOneWidget);
  });
}
