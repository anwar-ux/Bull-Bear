import 'package:bullbear/features/data/models/hive_model.dart';
import 'package:bullbear/features/presentation/bloc/get_server_data/get_server_data_bloc.dart';
import 'package:bullbear/features/presentation/bloc/manage_local_data/local_stock_data_bloc.dart';
import 'package:bullbear/features/presentation/pages/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<LocalStock>(LocalStockAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetServerDataBloc(),
        ),
        BlocProvider(
          create: (context) => LocalStockDataBloc(),
        )
      ],
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
        ),
        home:const UserBottomNavigation(),
      ),
    );
  }
}
