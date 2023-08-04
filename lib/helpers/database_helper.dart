import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:roledrilling_app/models/reporte_model.dart';

class DatabaseHelper {
  static const _databaseName = "ReporteDrillingApp.db";
  static const _databaseVersion = 2; // Cambiar la versión de la base de datos

  static const table = 'reportes_table';
  static const columnId = 'id'; // Cambiar el nombre de la columna de la clave primaria
  static const columnProyecto = 'proyecto';
  static const columnFecha = 'fecha';
  static const columnPozo = 'pozo';
  static const columnMaquina = 'maquina';
  static const columnTurno = 'turno';
  static const columnPerforista = 'perforista';
  static const columnAyudante1 = 'ayudante1';
  static const columnAyudante2 = 'ayudante2';
  static const columnSupervisor = 'supervisor';
  static const columnSupervisorSeguridad = 'supervisorSeguridad';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnProyecto TEXT,
        $columnFecha TEXT,
        $columnPozo TEXT,
        $columnMaquina TEXT,
        $columnTurno TEXT,
        $columnPerforista TEXT,
        $columnAyudante1 TEXT,
        $columnAyudante2 TEXT,
        $columnSupervisor TEXT,
        $columnSupervisorSeguridad TEXT
      )
    ''');
  }

  Future<int> insertReporte(Reporte reporte) async {
    Database db = await instance.database;
    return await db.insert(table, reporte.toMap());
  }

  Future<List<Reporte>> getReportes() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(table);
    return List.generate(maps.length, (i) {
      return Reporte(
        id: maps[i][columnId],
        proyecto: maps[i][columnProyecto],
        fecha: maps[i][columnFecha],
        pozo: maps[i][columnPozo],
        maquina: maps[i][columnMaquina],
        turno: maps[i][columnTurno],
        perforista: maps[i][columnPerforista],
        ayudante1: maps[i][columnAyudante1],
        ayudante2: maps[i][columnAyudante2],
        supervisor: maps[i][columnSupervisor],
        supervisorSeguridad: maps[i][columnSupervisorSeguridad],
      );
    });
  }

  Future<int> deleteReporte(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}