import 'package:bullbear/core/utils/app_colors.dart';
import 'package:bullbear/features/presentation/bloc/get_server_data/get_server_data_bloc.dart';
import 'package:bullbear/features/presentation/bloc/manage_local_data/local_stock_data_bloc.dart';
import 'package:bullbear/features/presentation/widgets/alertdialog_custom.dart';
import 'package:bullbear/features/presentation/widgets/custom_textfield.dart';
import 'package:bullbear/features/presentation/widgets/snak_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  TextEditingController searchEdit = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: AppBar(
          title: const Text('Home'),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: CustomTextfield(
                hint: 'Search...',
                onChanged: (value) => context.read<GetServerDataBloc>().add(LoadServerData(value)),
                controller: searchEdit,
              ),
            ),
          ),
        ),
      ),
      body: BlocConsumer<GetServerDataBloc, GetServerDataState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetServerDataLoaded) {
            if (searchEdit.text.isEmpty) {
              return Center(
                child: Lottie.asset('assets/stock.json',width:  150,
                height: 150,
                fit: BoxFit.cover,),
              );
            }
            return searchEdit.text.isEmpty?Center(
                child: Lottie.asset('assets/stock.json', width: 150,
                height: 150,
                fit: BoxFit.cover,),
              ): ListView.builder(
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
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                          blurStyle: BlurStyle.normal,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: ListTile(
                        title: Text(
                          data.companyName,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            letterSpacing: 1,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            customAlertDialog(
                              context: context,
                              title: 'Add',
                              message: 'Add to watchlist',
                              firstButtonAction: () => Navigator.pop(context),
                              firstButtonText: 'Cancel',
                              secondButtonAction: () {
                                context.read<LocalStockDataBloc>().add(AddData(data));
                                showCustomSnackbar(
                                  context,
                                  'Added to watchlist',
                                  'The stock added in watchlist',
                                  Colors.green,
                                );
                                Navigator.pop(context);
                              },
                              secondButtonText: 'Add',
                            );
                          },
                          icon: const Icon(Icons.bookmark_add_outlined),
                        ),
                        subtitle: Text('Stock rate: ₹${data.stockPrice}'),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (state is GetServerDataFailed) {
            return Center(
              child: Text(state.errorMsg),
            );
          } else if (state is GetServerDataLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetServerDataInitial) {
            return Center(
              child: Lottie.asset('assets/stock.json',width:  150,
                height: 150,
                fit: BoxFit.cover,),
            );
          }
          return Center(
            child: Lottie.asset('assets/stock.json',width:  150,
                height: 150,
                fit: BoxFit.cover,),
          );
        },
      ),
    );
  }
}
