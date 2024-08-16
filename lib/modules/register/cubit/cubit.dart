// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:cashier_app/models/login_model.dart';
// import 'package:cashier_app/modules/register/cubit/states.dart';

// class RegisterCubit extends Cubit<RegisterStates> {
//   RegisterCubit() : super(RegisterInitialState());

//   static RegisterCubit get(context) => BlocProvider.of(context);

//   String uId = '';

//   void userRegister({
//     required String email,
//     required String password,
//     required String userName,
//     required String phone,
//   }) {
//     emit(RegisterLoadingState());
//     print('hello');

//     FirebaseAuth.instance
//         .createUserWithEmailAndPassword(email: email, password: password)
//         .then((value) {
//       print(value.user?.email);

//       userCreate(
//           email: email, userName: userName, phone: phone, uId: value.user!.uid);
//       // emit(RegisterSuccessState());
//       uId = value.user!.uid;
//       print(uId);
//     }).catchError((error) {
//       print(error);
//       emit(RegisterErrorStates(error.toString()));
//     });
//   }

//   void userCreate({
//     required String email,
//     required String userName,
//     required String phone,
//     required String uId,
//   }) {
//     LoginModel model = LoginModel(
//       email: email,
//       phone: phone,
//       userName: userName,
//       uId: uId,
//       isEmailVerified: false,
//     );

//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(uId)
//         .set(model.toMap())
//         .then((value) {
//       emit(RegisterCreateUserSuccessState());
//     }).catchError((error) {
//       print(error);
//       emit(RegisterCreateUserErrorStates(error.toString()));
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
