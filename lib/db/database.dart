import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tarea8/model/evento.dart';

class EventDatabase {
  static final EventDatabase instance = EventDatabase._init();

  static Database? _database;

  EventDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB("event.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTERGER PRIMARY KEY AUTOINCREMENT';
    const stringType = "Text NOT NULL";

    await db.execute('''
CREATE TABLE $tableEventos(
  ${EventField.id} $idType,
  ${EventField.title} $stringType,
  ${EventField.fecha} $stringType,
  ${EventField.descripcion} $stringType,
  ${EventField.pathImage} $stringType,
  ${EventField.pathVoice} $stringType
)
''');

    Future<Evento> create(Evento evento) async {
      final db = await instance.database;
      final json = evento.toJson();
      const columns =
          '${EventField.title},${EventField.fecha},${EventField.descripcion},${EventField.pathImage},${EventField.pathVoice}';
      final values =
          '${json[EventField.title]},${json[EventField.fecha]},${json[EventField.descripcion]},${json[EventField.pathImage]},${json[EventField.pathVoice]}';
      final id = await db
          .rawInsert('INSERT INTO table_name ($columns) VALUES ($values)');

      return evento.copy(id: id);
    }

    Future<Evento> readEvento(int id) async {
      final db = await instance.database;
      final maps = await db.query(tableEventos,
          columns: EventField.values,
          where: '${EventField.id} = ?',
          whereArgs: [id]);

      if(maps.isNotEmpty){
        return Evento.fromJson(maps.first);
      }else{
        throw Exception('ID $id not found');
      }
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
