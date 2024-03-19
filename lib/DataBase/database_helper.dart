import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:developer' as developer;

class DataBaseHelper {
  static const id = "id";
  static const userName = "userName";
  static const userEmail = "userEmail";
  static const userNumber = "userNumber";
  static const userGender = "userGender";
  static const userSkills = "userSkills";

  static const _tableName = "todoTable";
  static const _databaseName = "todoDatabase.db";
  static const _databaseVersion = 1;

  //! Here first
  DataBaseHelper._private();

  static final dataBaseHelper = DataBaseHelper._private();

  Database? _database;

  //!  First we get the dataBase..
  Future<Database> get getDatabase async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await initalize();
      return _database!;
    }
  }

  //! Let's _initalize the databse

  Future initalize() async {
    Directory directory = await getApplicationCacheDirectory();
    var path = join(directory.path, _databaseName);
    developer.log(path.toString());
    _database = await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
    return _database;
  }

  //! Create the Database

  Future _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE $_tableName($id INTEGER PRIMARY KEY,$userName TEXT,$userEmail TEXT,$userNumber TEXT,$userGender TEXT,$userSkills TEXT )''');
  }

  //! Insert Query

  Future insert(Map<String, dynamic> userData) async {
    var database = await dataBaseHelper.getDatabase;
    if (kDebugMode) {
      print(userData);
    }
    return await database.insert(_tableName, userData);
  }

  //! Fecth The Data..
  Future fetchUser() async {
    var database = await dataBaseHelper.getDatabase;
    List userList = await database.query(_tableName);
    developer.log(userList.toString());
    return userList;
  }

//! When we are using the StreamBuilder for showing the Data.
  Stream getUserList() {
    return Stream.fromFuture(fetchUser());
  }

//! Serch User .
  Future<List<Map<String, dynamic>>> searchUser(String queryData) async {
    var database = await dataBaseHelper.getDatabase;
    List<Map<String, dynamic>> allData = await database.query(_tableName);

    List<Map<String, dynamic>> getData = allData.where((element) {
      var name = element['userName'].toString().toLowerCase();
      return name.contains(queryData);
    }).toList();
    print(getData.toList());
    return getData.toList();
  }

//! Delete the Use Details from DB

  Future<int> deleteUser(int userDeletID) async {
    var db = await dataBaseHelper.getDatabase;
    return await db
        .delete(_tableName, where: "$id = ? ", whereArgs: [userDeletID]);
  }

//! Update User Details
  Future updateUserDetails(
      Map<String, dynamic> userData, int userUpdateID) async {
    var db = await dataBaseHelper.getDatabase;
    print("userData : $userData");
    print("userUpdateID : $userUpdateID");
    return await db.update(_tableName, userData,
        where: '$id = ?', whereArgs: [userUpdateID]);
  }
}

GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();
