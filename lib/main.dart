import 'package:cashier_app/firebase_options.dart';
import 'package:cashier_app/modules/orders/orders_pre_screen.dart';
import 'package:cashier_app/shared/bloc_observer.dart';

import 'package:cashier_app/shared/network/local/cash_helper.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:firebase_core/firebase_core.dart';

import 'modules/orders/order_cubit.dart';
import 'shared/styles/themes.dart';

// import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Use the options here
  );
  await CashHelper.init();

  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // final FirebaseApp app;

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OrderCubit>(
          create: (context) => OrderCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        themeMode: ThemeMode.light,
        darkTheme: darkTheme,
        home: const OrdersPreScreen(),
      ),
    );
  }
}
