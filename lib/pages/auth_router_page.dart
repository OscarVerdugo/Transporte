// import 'package:app/pages/AuthPages/phone_registration_page.dart';
// import 'package:app/pages/AuthPages/phone_validation_page.dart';
// import 'package:app/pages/AuthPages/signin_page.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:app/api/auth_provider.dart';

// import 'package:app/pages/home_page.dart';

// class AuthRouterPage extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => AuthProvider(),
//       child: Consumer(
//         builder: (context, AuthProvider user,_){
//           print(user.status);
//           switch(user.status){
//             case Status.Unauthenticated:
//               return LoginPage();
//             case Status.Authenticated:
//               return HomePage();
//               break;
//             case Status.Authenticating:
//               return loading();
//             case Status.Uninitialized:
//               return loading();
//             case Status.UnverifiedPhone:
//               return PhoneValidationPage();
//             case Status.WithoutPhone:
//               return PhoneRegistrationPage();
//           }
//             return loading();
//         }
//       ),
//     );
//   }


//   Widget loading(){
//     return Scaffold(
//       backgroundColor: Color(0xFFF7F7FA),
//       body: Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(Color(0xFF29DF96))))
//     );
//   }
// }