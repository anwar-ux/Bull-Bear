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
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: AppBar(
          title: Text('Home'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: CustomTextfield(
                hint: 'Search...',
                onChanged: (value) => context.read<GetServerDataBloc>().add(LoadServerData(value)),
              ),
            ),
          ),
        ),
      ),
      body: BlocConsumer<GetServerDataBloc, GetServerDataState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetServerDataLoaded) {
            if (state.data.length==0) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LottieBuilder.asset('assets/no_data_animation.json'),
                    const SizedBox(height: 20),
                    const Text(
                      'No results found!',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              );
            }
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
              child: LottieBuilder.asset('assets/Animation - 1727270222094.json'),
            );
          }
          return Center(
            child: LottieBuilder.asset('assets/Animation - 1727270222094.json'),
          );
        },
      ),
    );
  }
}
