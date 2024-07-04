import 'package:sqflite/sqflite.dart' as sql;

class SqliteConnection {
  Future<sql.Database> db() async {
    return sql.openDatabase(
      'servicos.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database, version);
      },
    );
  }

  Future<void> createTables(sql.Database database, int version) async {
    await database.execute("""CREATE TABLE clientes(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        nome TEXT,
        documento TEXT,
        telefone TEXT,
        email TEXT
      )
      """);
  }
}
