part of 'local_stock_data_bloc.dart';

sealed class LocalStockDataState extends Equatable {
  const LocalStockDataState();

  @override
  List<Object> get props => [];
}

final class LocalStockDataInitial extends LocalStockDataState {}

final class LocalStockDataLoading extends LocalStockDataState {}

final class LocalStockDataLoaded extends LocalStockDataState {
  final List<LocalStock> data;
 const LocalStockDataLoaded(this.data);
}

final class LocalStockDataFailed extends LocalStockDataState {}
