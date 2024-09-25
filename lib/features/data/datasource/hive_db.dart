import 'package:bullbear/features/data/models/hive_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> addData(LocalStock value) async {
  try {
    final allDB = await Hive.openBox<LocalStock>('bullbear_db');
    final int id = await allDB.add(value);
    value.id = id;
    await allDB.put(id, value);
    debugPrint(value.companyName);
    await allDB.close();
  } catch (e) {
    debugPrint("Error adding data: $e");
  }
}

Future<List<LocalStock>> getAllLocalData() async {
  try {
    final allDB = await Hive.openBox<LocalStock>('bullbear_db');
    final dataList = List<LocalStock>.from(allDB.values);
    return dataList;
  } catch (e) {
    debugPrint(e.toString());
    return [];
  }
}

Future<void> deleteData(id) async {
  try {
    final allDB = await Hive.openBox<LocalStock>('bullbear_db');
    allDB.delete(id);
   // await allDB.close();
  } catch (e) {
    debugPrint(e.toString());
  }
}
