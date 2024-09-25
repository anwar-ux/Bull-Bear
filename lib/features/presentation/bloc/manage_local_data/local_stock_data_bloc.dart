import 'package:bloc/bloc.dart';
import 'package:bullbear/features/data/datasource/hive_db.dart';
import 'package:bullbear/features/data/models/hive_model.dart';
import 'package:bullbear/features/data/models/model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'local_stock_data_event.dart';
part 'local_stock_data_state.dart';

class LocalStockDataBloc extends Bloc<LocalStockDataEvent, LocalStockDataState> {
  LocalStockDataBloc() : super(LocalStockDataInitial()) {
    on<LoadLocalData>(_onLoadLocalData);
    on<DeleteData>(_onDeleteData);
    on<AddData>(_onAddData);
  }

  void _onLoadLocalData(LoadLocalData event, Emitter<LocalStockDataState> emit) async {
    try {
      emit(LocalStockDataLoading());
      List<LocalStock> data = await getAllLocalData();
      emit(LocalStockDataLoaded(data));
    } catch (e) {
      emit(LocalStockDataFailed());
    }
  }

  void _onAddData(AddData event, Emitter<LocalStockDataState> emit) async {
    try {
      final data = LocalStock(companyName: event.data.companyName, stockPrice: event.data.stockPrice);
      await addData(data);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _onDeleteData(DeleteData event, Emitter<LocalStockDataState> emit) async {
    try {
      await deleteData(event.id);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
