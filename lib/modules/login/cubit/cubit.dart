// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:cashier_app/modules/login/cubit/states.dart';

// class LogInCubit extends Cubit<LoginStates> {
//   LogInCubit() : super(LoginInitialState());

//   static LogInCubit get(context) => BlocProvider.of(context);

//   void userLogin({
//     required String email,
//     required String password,
//   }) {
//     emit(LoginLoadingState());
//     FirebaseAuth.instance
//         .signInWithEmailAndPassword(email: email, password: password)
//         .then((value) {
//       print(value.user?.email);
//       print(value.user?.uid);
//       emit(LoginSuccessState(value.user!.uid));
//     }).catchError((error) {
//       emit(LoginErrorStates(error.toString()));
//     });
//   }

//   bool isPassword = true;
//   IconData suffix = Icons.visibility_outlined;

//   void changePasswordVisibility() {
//     isPassword = !isPassword;
//     suffix =
//         isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
//     emit(PasswordVisibilityState());
//   }
// }
