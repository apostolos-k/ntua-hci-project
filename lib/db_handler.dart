import 'package:my_car_wallet/models/car.dart';
import 'package:my_car_wallet/models/event.dart';
import 'package:my_car_wallet/models/photo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDatabase();
    return null;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationSupportDirectory();
    String path = join(documentDirectory.path,
        'wallet.db'); //we use the method join() which is inside the package path to join the given path into a single path, so for example we would get databasepath/database.db.
    var db = await openDatabase(path,
        version: 1,
        onCreate:
            _createDatabase); //onCreate() callback: It will be called when the database is created for the first time, and it will execute the above SQL query
    return db;
  }

  _createDatabase(Database db, int version) async {
    // creating table in database
    await db.execute(
      "CREATE TABLE car(id INTEGER PRIMARY KEY AUTOINCREMENT, displayname TEXT NOT NULL, brand TEXT NOT NULL, model TEXT NOT NULL, type TEXT NOT NULL, mileage TEXT NOT NULL, plate TEXT NOT NULL)",
    );
    await db.execute(
      "CREATE TABLE event(id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT NOT NULL, alarmTime TEXT NOT NULL, displayName TEXT NOT NULL, car TEXT NOT NULL, contactInfo TEXT NOT NULL, location TEXT NOT NULL, description TEXT NOT NULL)",
    );
    await db.execute(
        "CREATE TABLE photoLicense(id INTEGER PRIMARY KEY AUTOINCREMENT, photoName TEXT NOT NULL)");
    await db.execute(
        "CREATE TABLE photoKteo(id INTEGER PRIMARY KEY AUTOINCREMENT, photoName TEXT NOT NULL)");
    await db.execute(
        "CREATE TABLE photoInsurance(id INTEGER PRIMARY KEY AUTOINCREMENT, photoName TEXT NOT NULL)");
    await db.execute(
        "CREATE TABLE photoExhaust(id INTEGER PRIMARY KEY AUTOINCREMENT, photoName TEXT NOT NULL)");
    await db.execute(
        "CREATE TABLE photoFees(id INTEGER PRIMARY KEY AUTOINCREMENT, photoName TEXT NOT NULL)");
    await db.execute(
        "CREATE TABLE photoRegistration(id INTEGER PRIMARY KEY AUTOINCREMENT, photoName TEXT NOT NULL)");
  }

  // Car Model
  Future<CarModel> insert(CarModel carModel) async {
    var dbClient = await db;
    await dbClient?.insert('car', carModel.toMap());
    return carModel;
  }

  Future<List<CarModel>> getDataList() async {
    await db;
    final List<Map<String, Object?>> QueryResult =
        await _db!.rawQuery('SELECT * FROM car');
    return QueryResult.map((e) => CarModel.fromMap(e)).toList();
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('car', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(CarModel carModel) async {
    var dbClient = await db;
    return await dbClient!.update('car', carModel.toMap(),
        where: 'id = ?', whereArgs: [carModel.id]);
  }

  // Event Model
  Future<EventModel> insertEvent(EventModel eventModel) async {
    var dbClient = await db;
    await dbClient?.insert('event', eventModel.toMap());
    return eventModel;
  }

  Future<List<EventModel>> getDataListEvent() async {
    await db;
    final List<Map<String, Object?>> QueryResult =
        await _db!.rawQuery('SELECT * FROM event');
    return QueryResult.map((e) => EventModel.fromMap(e)).toList();
  }

  Future<int> deleteEvent(int id) async {
    var dbClient = await db;
    return await dbClient!.delete('event', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateEvent(EventModel eventModel) async {
    var dbClient = await db;
    return await dbClient!.update('event', eventModel.toMap(),
        where: 'id = ?', whereArgs: [eventModel.id]);
  }

  // Photo License Model
  Future<Photo> saveL(Photo photo) async {
    var dbClient = await db;
    await dbClient?.insert('photoLicense', photo.toMap());
    return photo;
  }

  Future<List<Photo>> getPhotosL() async {
    await db;
    final List<Map<String, Object?>> QueryResult =
        await _db!.rawQuery('SELECT * FROM photoLicense');
    return QueryResult.map((e) => Photo.fromMap(e)).toList();
  }

  Future<int?> deletePhotoL() async {
    var dbClient = await db;
    return await dbClient?.rawDelete('DELETE FROM photoLicense');
  }

  // Photo Kteo Model
  Future<Photo> saveK(Photo photo) async {
    var dbClient = await db;
    await dbClient?.insert('photoKteo', photo.toMap());
    return photo;
  }

  Future<List<Photo>> getPhotosK() async {
    await db;
    final List<Map<String, Object?>> QueryResult =
        await _db!.rawQuery('SELECT * FROM photoKteo');
    return QueryResult.map((e) => Photo.fromMap(e)).toList();
  }

  Future<int?> deletePhotoK() async {
    var dbClient = await db;
    return await dbClient?.rawDelete('DELETE FROM photoKteo');
  }

  // Photo Insurance Model
  Future<Photo> saveI(Photo photo) async {
    var dbClient = await db;
    await dbClient?.insert('photoInsurance', photo.toMap());
    return photo;
  }

  Future<List<Photo>> getPhotosI() async {
    await db;
    final List<Map<String, Object?>> QueryResult =
        await _db!.rawQuery('SELECT * FROM photoInsurance');
    return QueryResult.map((e) => Photo.fromMap(e)).toList();
  }

  Future<int?> deletePhotoI() async {
    var dbClient = await db;
    return await dbClient?.rawDelete('DELETE FROM photoInsurance');
  }

  // Photo Exhaust Model
  Future<Photo> saveE(Photo photo) async {
    var dbClient = await db;
    await dbClient?.insert('photoExhaust', photo.toMap());
    return photo;
  }

  Future<List<Photo>> getPhotosE() async {
    await db;
    final List<Map<String, Object?>> QueryResult =
        await _db!.rawQuery('SELECT * FROM photoExhaust');
    return QueryResult.map((e) => Photo.fromMap(e)).toList();
  }

  Future<int?> deletePhotoE() async {
    var dbClient = await db;
    return await dbClient?.rawDelete('DELETE FROM photoExhaust');
  }

  // Photo Fees Model
  Future<Photo> saveF(Photo photo) async {
    var dbClient = await db;
    await dbClient?.insert('photoFees', photo.toMap());
    return photo;
  }

  Future<List<Photo>> getPhotosF() async {
    await db;
    final List<Map<String, Object?>> QueryResult =
        await _db!.rawQuery('SELECT * FROM photoFees');
    return QueryResult.map((e) => Photo.fromMap(e)).toList();
  }

  Future<int?> deletePhotoF() async {
    var dbClient = await db;
    return await dbClient?.rawDelete('DELETE FROM photoFees');
  }

  // Photo Registration Model
  Future<Photo> saveR(Photo photo) async {
    var dbClient = await db;
    await dbClient?.insert('photoRegistration', photo.toMap());
    return photo;
  }

  Future<List<Photo>> getPhotosR() async {
    await db;
    final List<Map<String, Object?>> QueryResult =
        await _db!.rawQuery('SELECT * FROM photoRegistration');
    return QueryResult.map((e) => Photo.fromMap(e)).toList();
  }

  Future<int?> deletePhotoR() async {
    var dbClient = await db;
    return await dbClient?.rawDelete('DELETE FROM photoRegistration');
  }
}
