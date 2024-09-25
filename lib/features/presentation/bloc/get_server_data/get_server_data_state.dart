part of 'get_server_data_bloc.dart';

sealed class GetServerDataState extends Equatable {
  const GetServerDataState();

  @override
  List<Object> get props => [];
}

final class GetServerDataInitial extends GetServerDataState {}

final class GetServerDataLoading extends GetServerDataState {}

final class GetServerDataLoaded extends GetServerDataState {
   final List<Stock> data;
  GetServerDataLoaded(this.data);
}

final class GetServerDataFailed extends GetServerDataState {
  final String errorMsg;

   GetServerDataFailed(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}
