part of 'local_stock_data_bloc.dart';

sealed class LocalStockDataEvent extends Equatable {
  const LocalStockDataEvent();

  @override
  List<Object> get props => [];
}

class LoadLocalData extends LocalStockDataEvent {}

class AddData extends LocalStockDataEvent {
  final Stock data;
  const AddData(this.data);
}

class DeleteData extends LocalStockDataEvent {
  final int id;
 const DeleteData(this.id);
}
