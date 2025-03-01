// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:r_creative/Controller/provider/Forgot_Password.dart';
// import 'package:r_creative/view/widgets/Coustom_button.dart';
// import 'package:r_creative/view/widgets/Coustom_text.dart';
// import 'package:r_creative/view/widgets/validation.dart';
// class ForgotScreen extends StatelessWidget {
//   final TextEditingController contactController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       Provider.of<ForgotProvider>(context, listen: false).setDeviceToken(
//         "f7OW_uHRSNKkYEi8JyTFHK:APA91bEbuovN97LQ6QIqwO8Aj85gIQ57m0Hm6Pm4V2M8kiiQ8efq77csFofJvdAganDTDyQlalqp2iIBJuA-X45J5aaqoU7Du9hm-5nEaryP8OSNhouCHLNq3R3YTGxFfP0SinCf0P"
//       );
//     });
    
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Consumer<ForgotProvider>(
//           builder: (context, provider, child) {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CustomTextFormField(
//                   controller: contactController,
//                  labelText: "Phone Number",
//                   validator: (value) => ValidationUtils.validatePhoneNumber(value),
//                   keyboardType: TextInputType.phone,
//                 ),
//                 const SizedBox(height: 10),
//                 CustomTextFormField(
//                   controller: passwordController,
//                   labelText: "Password",
//                   validator: (value) => ValidationUtils.validate(value, 'Password'),
//                   isPassword: true,
//                 ),
//                 const SizedBox(height: 20),
//                 provider.isLoading
//                     ? const CircularProgressIndicator()
//                     : CustomButton(
//                      onPressed: () {
//                           provider.forgetpass(
//                             context,
//                             contactController.text.trim(),
//                             passwordController.text.trim(),
//                           );
//                         },
//                        buttonText: 'ResetPassword',
//                       ),
                    
//                 if (provider.errorMessage != null)
//                   Padding(
//                     padding: const EdgeInsets.only(top: 10),
//                     child: Text(
//                       provider.errorMessage!,
//                       style: const TextStyle(color: Colors.red),
//                     ),
//                   ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }