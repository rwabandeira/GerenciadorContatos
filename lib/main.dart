import 'package:flutter/material.dart';
import 'telas/menu_principal.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  databaseFactory = databaseFactoryFfi;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciador de Contatos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MenuPrincipal(),
    );
  }
}