part of 'get_server_data_bloc.dart';

sealed class GetServerDataEvent extends Equatable {
  const GetServerDataEvent();

  @override
  List<Object> get props => [];
}

class LoadServerData extends GetServerDataEvent {
  final String query;

  const LoadServerData(this.query);
}