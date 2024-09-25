import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'hive_model.g.dart';

@HiveType(typeId: 0)
class LocalStock {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? companyName;
  @HiveField(2)
  String? stockPrice;

  LocalStock({
    this.id,
    @required this.companyName,
    @required this.stockPrice,
  });
}
