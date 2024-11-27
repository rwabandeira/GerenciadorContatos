import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../modelos/contato.dart';

class DB {
  DB._();
  static final DB instancia = DB._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _inicializarBanco();
    return _database!;
  }

  Future<Database> _inicializarBanco() async {
    final caminho = await getDatabasesPath();
    final db = openDatabase(
      join(caminho, 'contatos.db'),
      onCreate: (db, version) {
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

  // Método para inserir um contato
  Future<int> inserirContato(Contato contato) async {
    final db = await database;
    return await db.insert('contatos', contato.paraMapa());
  }

  // Método para listar todos os contatos
  Future<List<Contato>> listarContatos() async {
    final db = await database;
    final resultado = await db.query('contatos');
    return resultado.map((mapa) => Contato.deMapa(mapa)).toList();
  }

  // Método para buscar todos os contatos (id é opcional)
  Future<List<Contato>> buscarContatos() async {
    final db = await database;
    final resultado = await db.query('contatos');
    return resultado.map((mapa) => Contato.deMapa(mapa)).toList();
  }

  // Método para atualizar um contato específico
  Future<int> atualizarContato(Contato contato) async {
    final db = await database;
    return await db.update(
      'contatos',
      contato.paraMapa(),
      where: 'id = ?',
      whereArgs: [contato.id],
    );
  }

  // Método para excluir um contato pelo ID
  Future<int> excluirContato(int id) async {
    final db = await database;
    return await db.delete('contatos', where: 'id = ?', whereArgs: [id]);
  }
}
