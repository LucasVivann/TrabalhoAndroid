import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteRepository {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'clientes.db');
    return await openDatabase(
      path,
      version: 3,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE IF NOT EXISTS clientes(id INTEGER PRIMARY KEY, nome TEXT, documento TEXT, telefone TEXT, email TEXT)",
        );
        await db.execute(
          "CREATE TABLE IF NOT EXISTS servicos(id INTEGER PRIMARY KEY, cliente TEXT, descricao TEXT, data TEXT, horas INTEGER, valor_unitario REAL, valor_total REAL)",
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 3) {
          await db.execute(
            "ALTER TABLE servicos ADD COLUMN cliente TEXT",
          );
          await db.execute(
            "ALTER TABLE servicos ADD COLUMN descricao TEXT",
          );
          await db.execute(
            "ALTER TABLE servicos ADD COLUMN data TEXT",
          );
          await db.execute(
            "ALTER TABLE servicos ADD COLUMN horas INTEGER",
          );
          await db.execute(
            "ALTER TABLE servicos ADD COLUMN valor_unitario REAL",
          );
          await db.execute(
            "ALTER TABLE servicos ADD COLUMN valor_total REAL",
          );
        }
      },
    );
  }

  static Future<void> saveCliente(
      String nome, String documento, String telefone, String email) async {
    final db = await database;

    await db.insert(
      'clientes',
      {
        'nome': nome,
        'documento': documento,
        'telefone': telefone,
        'email': email,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getClientes() async {
    final db = await database;
    return await db.query('clientes');
  }

  static Future<void> saveServico(String cliente, String descricao, String data,
      int horas, double valorUnitario) async {
    final db = await database;
    final valorTotal = horas * valorUnitario;

    await db.insert(
      'servicos',
      {
        'cliente': cliente,
        'descricao': descricao,
        'data': data,
        'horas': horas,
        'valor_unitario': valorUnitario,
        'valor_total': valorTotal,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getServicos() async {
    final db = await database;
    return await db.query('servicos');
  }
}
