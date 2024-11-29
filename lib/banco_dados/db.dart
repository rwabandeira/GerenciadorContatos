import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../modelos/contato.dart';

class DB {
  // Cria uma instância única da classe DB (Singleton)
  DB._();
  static final DB instancia = DB._();

  Database? _database;

  // Obtém a instância do banco de dados, criando-o se necessário
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _inicializarBanco();
    return _database!;
  }

  // Inicializa a conexão com o banco de dados e cria a tabela 'contatos'
  Future<Database> _inicializarBanco() async {
    // Obtém o caminho onde o banco de dados será armazenado
    final caminho = await getDatabasesPath();
    final db = openDatabase(
      join(caminho, 'contatos.db'),
      onCreate: (db, version) {
        // Cria a tabela 'contatos' com os campos: id, nome, telefone e email
        db.execute('''
          CREATE TABLE contatos(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nome TEXT,
            telefone TEXT,
            email TEXT
          )
        ''');
      },
      version: 1,
    );
    return db;
  }

  // (C)Insere um novo contato no banco de dados
  Future<int> inserirContato(Contato contato) async {
    final db = await database;
    return await db.insert('contatos', contato.paraMapa());
  }

  // (R)Lista todos os contatos armazenados no banco de dados
  Future<List<Contato>> listarContatos() async {
    final db = await database;
    final resultado = await db.query('contatos');
    return resultado.map((mapa) => Contato.deMapa(mapa)).toList();
  }

  // (U)Atualiza as informações de um contato existente
  Future<int> atualizarContato(Contato contato) async {
    final db = await database;
    return await db.update(
      'contatos',
      contato.paraMapa(),
      where: 'id = ?',
      whereArgs: [contato.id],
    );
  }

  // (D)Exclui um contato do banco de dados
  Future<int> excluirContato(int id) async {
    final db = await database;
    return await db.delete('contatos', where: 'id = ?', whereArgs: [id]);
  }
}