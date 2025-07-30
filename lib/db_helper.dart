import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'shahd.db');
    Database myDb = await openDatabase(path, onCreate: _onCreate,version: 7 );
    return myDb;
  }
  // _onUpgrade(Database db,int oldVersion,int newVersion)async
  // {
  //   print("=========ON UPGRADE============");
  //   await db.execute("ALTER TABLE notes ADD COLUMN color TEXT ");
  //
  // }

  _onCreate(Database db, int version) async {
    Batch batch =db.batch();

    batch.commit();
    batch.execute('''
   CREATE TABLE "tasks"(
   "id" INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
   "task" TEXT NOT NULL,
   "date" TEXT NOT NULL
   )
      ''');
    //==========To Add Another Table=============
    //  batch.execute('''
    // CREATE TABLE "students"(
    // "id" INTEGER  NOT NULL PRIMARY KEY AUTOINCREMENT,
    // "title" TEXT NOT NULL,
    // "note" TEXT NOT NULL
    // )
    // ''');

    await batch.commit();
    print("==========Create Database And table===========");
  }
// ============SELECT==============
  readData(String sql) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.rawQuery(sql);
    return response;
  }

  //============INSERT==============
  insertData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawInsert(sql);
    return response;
  }

  //============UPDATE==============
  updateData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawUpdate(sql);
    return response;
  }
  //============DELETE==============
  deleteData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawDelete(sql);
    return response;
  }

  myDeleteDtaBase() async
  {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'shahd.db');
    await deleteDatabase(path);


  }

//============================================
  // ============SELECT==============
  read(String table) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.query(table);
    return response;
  }

  //============INSERT==============
  insert(String table,Map<String,Object> values) async {
    Database? myDb = await db;
    int response = await myDb!.insert(table,values);
    return response;
  }

  //============UPDATE==============
  update(String table,Map<String,Object>values,String myWhere) async {
    Database? myDb = await db;
    int response = await myDb!.update(table,values,where: myWhere );
    return response;
  }
  //============DELETE==============
  delete(String table,String myWhere) async {
    Database? myDb = await db;
    int response = await myDb!.delete(table,where: myWhere);
    return response;
  }








}