import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bullbear/features/data/datasource/api_service.dart';
import 'package:bullbear/features/data/models/model.dart';
import 'package:equatable/equatable.dart';

part 'get_server_data_event.dart';
part 'get_server_data_state.dart';

class GetServerDataBloc extends Bloc<GetServerDataEvent, GetServerDataState> {
  GetServerDataBloc() : super(GetServerDataInitial()) {
    on<LoadServerData>(_onLoadServerData);
  }

  Future<void> _onLoadServerData(LoadServerData event, Emitter<GetServerDataState> emit) async {
    try {
    
      emit(GetServerDataLoading());

  
      await Future.delayed(const Duration(milliseconds: 600));

    
      final List<Stock> data = await fetchStockData(event.query);

      if (data.isNotEmpty) {
        emit(GetServerDataLoaded(data));
      } else {
        emit(GetServerDataFailed('No data found for ${event.query}'));
      }
    } catch (e) {
      emit(GetServerDataFailed(e.toString()));
    }
  }
}
