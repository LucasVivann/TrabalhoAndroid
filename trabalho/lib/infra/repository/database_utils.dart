import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseUtils {
  static Future<void> deleteDatabaseFile() async {
    String path = join(await getDatabasesPath(), 'clientes.db');
    await deleteDatabase(path);
  }
}
