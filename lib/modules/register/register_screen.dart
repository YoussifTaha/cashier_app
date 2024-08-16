// import 'package:buildcondition/buildcondition.dart';
// import 'package:cashier_app/modules/orders/orders_pre_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:cashier_app/layout/home_layout.dart';
// import 'package:cashier_app/modules/login/cubit/cubit.dart';
// import 'package:cashier_app/modules/login/cubit/states.dart';
// import 'package:cashier_app/modules/register/cubit/cubit.dart';
// import 'package:cashier_app/modules/register/cubit/states.dart';
// import '../../shared/components/components.dart';

// class RegisterScreen extends StatelessWidget {
//   RegisterScreen({super.key});

//   var emailController = TextEditingController();

//   var userNameController = TextEditingController();

//   var phoneController = TextEditingController();

//   var passwordController = TextEditingController();

//   var formkey = GlobalKey<FormState>();

//   bool isVisible = true;

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => RegisterCubit(),
//       child: BlocConsumer<RegisterCubit, RegisterStates>(
//         listener: (context, state) {
//           if (state is RegisterCreateUserSuccessState) {
//             navigateAndFinish(context, const OrdersPreScreen());
//           }
//         },
//         builder: (context, state) {
//           return Scaffold(
//             appBar: AppBar(),
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
//                           'Register',
//                           style: TextStyle(
//                             fontSize: 40.0,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(
//                           height: 40.0,
//                         ),
//                         defaultform(
//                             controller: (userNameController),
//                             type: TextInputType.name,
//                             validate: (value) {
//                               if (value!.isEmpty) {
//                                 return 'User name cannot be empty';
//                               }
//                               return null;
//                             },
//                             labeltext: 'User Name',
//                             prefix: Icons.person),
//                         const SizedBox(
//                           height: 15.0,
//                         ),
//                         defaultform(
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
//                             controller: (phoneController),
//                             type: TextInputType.phone,
//                             validate: (value) {
//                               if (value!.isEmpty) {
//                                 return 'Phone number cannot be empty';
//                               }
//                               return null;
//                             },
//                             labeltext: 'Phone Number',
//                             prefix: Icons.phone),
//                         const SizedBox(
//                           height: 15.0,
//                         ),
//                         defaultform(
//                             controller: (passwordController),
//                             isPassword: RegisterCubit.get(context).isPassword,
//                             type: TextInputType.visiblePassword,
//                             validate: (value) {
//                               if (value!.isEmpty) {
//                                 return 'Password cannot be empty';
//                               }
//                               return null;
//                             },
//                             labeltext: 'Password',
//                             suffixPressed: () {
//                               RegisterCubit.get(context)
//                                   .changePasswordVisibility();
//                             },
//                             suffix: RegisterCubit.get(context).suffix,
//                             prefix: Icons.lock),
//                         const SizedBox(
//                           height: 15.0,
//                         ),
//                         BuildCondition(
//                           condition: state is! RegisterLoadingState,
//                           builder: (context) => defaultButton(
//                             text: 'Register',
//                             function: () {
//                               if (formkey.currentState!.validate()) {
//                                 RegisterCubit.get(context).userRegister(
//                                     email: emailController.text,
//                                     password: passwordController.text,
//                                     userName: userNameController.text,
//                                     phone: phoneController.text);
//                               }
//                             },
//                           ),
//                           fallback: (context) =>
//                               const Center(child: CircularProgressIndicator()),
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
