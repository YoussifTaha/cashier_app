// import 'package:buildcondition/buildcondition.dart';
// import 'package:cashier_app/modules/orders/orders_pre_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:cashier_app/layout/home_layout.dart';
// import 'package:cashier_app/modules/login/cubit/cubit.dart';
// import 'package:cashier_app/modules/login/cubit/states.dart';
// // import 'package:cashier_app/modules/onboarding/on_boarding.dart';
// import 'package:cashier_app/modules/register/register_screen.dart';
// import 'package:cashier_app/shared/network/local/cash_helper.dart';
// import 'package:cashier_app/shared/styles/colors.dart';
// import '../../shared/components/components.dart';

// class LoginScreen extends StatelessWidget {
//   var emailController = TextEditingController();

//   var passwordController = TextEditingController();

//   var formkey = GlobalKey<FormState>();

//   bool isVisible = true;

//   LoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => LogInCubit(),
//       child: BlocConsumer<LogInCubit, LoginStates>(
//         listener: (context, state) {
//           if (state is LoginSuccessState) {
//             CashHelper.saveData(key: 'uId', value: state.uId).then((value) {
//               if (CashHelper.getData(key: 'onBoarding') != null) {
//                 navigateAndFinish(context, const OrdersPreScreen());
//               } else {
//                 navigateAndFinish(context, OrdersPreScreen());
//               }
//             });
//           }
//           if (state is LoginErrorStates) {
//             showToast(text: state.error, state: ToastStates.error);
//           }
//         },
//         builder: (context, state) {
//           return Scaffold(
//             backgroundColor: dark,
//             // appBar: AppBar(),
//             body: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Center(
//                 child: SingleChildScrollView(
//                   child: Form(
//                     key: formkey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         const Text(
//                           'Login',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 40.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 40.0,
//                         ),
//                         defaultform(
//                             focusedBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide(
//                               color: Colors.white,
//                             )),
//                             prefixIconColor: Colors.white,
//                             labelStyle: const TextStyle(
//                               color: Colors.white,
//                             ),
//                             TextStyle: const TextStyle(
//                               color: Colors.white,
//                             ),
//                             controller: (emailController),
//                             type: TextInputType.emailAddress,
//                             validate: (value) {
//                               if (value!.isEmpty) {
//                                 return 'Email Address cannot be empty';
//                               }
//                               return null;
//                             },
//                             labeltext: 'Email Address',
//                             prefix: Icons.email),
//                         const SizedBox(
//                           height: 15.0,
//                         ),
//                         defaultform(
//                             focusedBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide(
//                               color: Colors.white,
//                             )),
//                             prefixIconColor: Colors.white,
//                             suffixIconColor: Colors.white,
//                             labelStyle: const TextStyle(
//                               color: Colors.white,
//                             ),
//                             TextStyle: const TextStyle(
//                               color: Colors.white,
//                             ),
//                             controller: (passwordController),
//                             isPassword: LogInCubit.get(context).isPassword,
//                             type: TextInputType.visiblePassword,
//                             validate: (value) {
//                               if (value!.isEmpty) {
//                                 return 'Password cannot be empty';
//                               }
//                               return null;
//                             },
//                             labeltext: 'Password',
//                             suffixPressed: () {
//                               LogInCubit.get(context)
//                                   .changePasswordVisibility();
//                             },
//                             suffix: LogInCubit.get(context).suffix,
//                             prefix: Icons.lock),
//                         const SizedBox(
//                           height: 15.0,
//                         ),
//                         BuildCondition(
//                           condition: state is! LoginLoadingState,
//                           builder: (context) => defaultButton(
//                             text: 'LOGIN',
//                             backgroundColor: primaryOrange,
//                             function: () {
//                               if (formkey.currentState!.validate()) {
//                                 LogInCubit.get(context).userLogin(
//                                   email: emailController.text,
//                                   password: passwordController.text,
//                                 );
//                               }
//                             },
//                           ),
//                           fallback: (context) =>
//                               const Center(child: CircularProgressIndicator()),
//                         ),
//                         const SizedBox(
//                           height: 15.0,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text(
//                               'Don\'t have an account?',
//                               style: TextStyle(
//                                 color: Colors.white,
//                               ),
//                             ),
//                             TextButton(
//                                 onPressed: () {
//                                   navigateTo(context, RegisterScreen());
//                                 },
//                                 child: const Text('Register Now')),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
