import 'package:bullbear/core/utils/app_colors.dart';
import 'package:bullbear/features/presentation/bloc/manage_local_data/local_stock_data_bloc.dart';
import 'package:bullbear/features/presentation/widgets/alertdialog_custom.dart';
import 'package:bullbear/features/presentation/widgets/snak_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistPage extends StatelessWidget {
  const WatchlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => LocalStockDataBloc()..add(LoadLocalData()),
        child: BlocConsumer<LocalStockDataBloc, LocalStockDataState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is LocalStockDataLoaded) {
              return ListView.builder(
                itemCount: state.data.length,
                itemBuilder: (context, index) {
                  final data = state.data[index];
                  return Padding(
                    padding: const EdgeInsets.all(6),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.11,
                      width: MediaQuery.of(context).size.width * 0.90,
                      decoration: BoxDecoration(
                        color: AppColors.primarycolor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.5), spreadRadius: 2, blurRadius: 10, offset: const Offset(0, 5), blurStyle: BlurStyle.normal),
                        ],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: ListTile(
                          title: Text(
                            data.companyName!,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 1),
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                customAlertDialog(
                                  context: context,
                                  title: 'Remove',
                                  message: 'Remove from watchlist',
                                  firstButtonAction: () => Navigator.pop(context),
                                  firstButtonText: 'Cancel',
                                  secondButtonAction: () {
                                    context.read<LocalStockDataBloc>().add(DeleteData(data.id!));
                                     showCustomSnackbar(context, 'Removed from watchlist', 'The stock removed from watchlist', Colors.green);
                                    context.read<LocalStockDataBloc>().add(LoadLocalData());
                                    Navigator.pop(context);
                                  },
                                  secondButtonText: 'Remove',
                                );
                              },
                              icon: const Icon(Icons.bookmark)),
                          subtitle: Text('Stock rate: ₹${data.stockPrice}'),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is LocalStockDataLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LocalStockDataFailed) {
              return const Center(
                child: Text('Failed'),
              );
            }
            return const Center(
              child: Text('Error'),
            );
          },
        ),
      ),
    );
  }
}
