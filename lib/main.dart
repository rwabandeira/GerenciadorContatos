import 'package:flutter/material.dart';
import 'telas/menu_principal.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io' show Platform; // Import para verificar a plataforma
import 'banco_dados/db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa a fábrica de banco de dados FFI (para plataformas que não suportam o sqflite nativo)
  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(MyApp());
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
