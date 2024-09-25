// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalStockAdapter extends TypeAdapter<LocalStock> {
  @override
  final int typeId = 0;

  @override
  LocalStock read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalStock(
      id: fields[0] as int?,
      companyName: fields[1] as String?,
      stockPrice: fields[2] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, LocalStock obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.companyName)
      ..writeByte(2)
      ..write(obj.stockPrice);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalStockAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
