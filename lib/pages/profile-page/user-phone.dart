// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:spoco_app/model/user.dart';
// import 'package:spoco_app/provider/user-provider.dart';

// class UserPhone extends StatefulWidget {
//   const UserPhone({Key? key}) : super(key: key);

//   @override
//   _UserPhoneState createState() => _UserPhoneState();
// }

// class _UserPhoneState extends State<UserPhone> {
//   final AppUser user = AppUser.getAppUserEmptyObject();
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();

//   InputDecoration userProfileInputDecoration({required String hintText}) {
//     return InputDecoration(
//       hintText: hintText,
//       filled: true,
//       fillColor: Colors.grey.shade200,
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(8.0)),
//         borderSide: BorderSide(
//           color: Colors.grey,
//           width: 1.0,
//         ),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(8.0)),
//         borderSide: BorderSide(
//           color: Color(0xFF48bb78),
//           width: 2.0,
//         ),
//       ),
//     );
//   }

//   TextStyle profileTextStyle({
//     double fontSize = 20.0,
//     FontWeight fontWeight = FontWeight.bold,
//     Color color = Colors.black,
//   }) {
//     return TextStyle(
//       fontSize: fontSize,
//       fontWeight: fontWeight,
//       color: color,
//     );
//   }

//   BoxDecoration containerDecoration() {
//     return BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.circular(20),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black26,
//           blurRadius: 20,
//           offset: Offset(0, 4),
//         ),
//       ],
//     );
//   }

//   Widget UserPhoneForm() {
//     return Form(
//       key: formKey,
//       child: Column(
//         children: <Widget>[
//           TextFormField(
//             decoration: userProfileInputDecoration(hintText: "Phone"),
//             keyboardType: TextInputType.phone,
//             onSaved: (value) {
//               if (value != null) {
//                 user.phone = value;
//                 var userProvider = Provider.of<UserProvider>(context, listen: false);
//                 userProvider.updateUser(userProvider.user..phone = value!);
//               }
//             },
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter your phone number';
//               }
//               return null;
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.all(24),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             const SizedBox(height: 12),
//             UserPhoneForm(),
//             const SizedBox(height: 12),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (formKey.currentState?.validate() ?? false) {
//                         formKey.currentState?.save();
//                         print("User Phone: ${user.phone}");
//                         Navigator.pushNamed(context, "/add-user-sports");
//                       }
//                     },
//                     child: Text(
//                       "Next",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xFF48bb78),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
//                 ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 12),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spoco_app/model/user.dart';
import 'package:spoco_app/provider/user-provider.dart';

class UserPhone extends StatefulWidget {
  const UserPhone({Key? key}) : super(key: key);

  @override
  _UserPhoneState createState() => _UserPhoneState();
}

class _UserPhoneState extends State<UserPhone> {
  final AppUser user = AppUser.getAppUserEmptyObject();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  InputDecoration userProfileInputDecoration({required String hintText}) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: Colors.grey.shade200,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(
          color: Color(0xFF48bb78),
          width: 2.0,
        ),
      ),
    );
  }

  TextStyle profileTextStyle({
    double fontSize = 20.0,
    FontWeight fontWeight = FontWeight.bold,
    Color color = Colors.black,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }

  BoxDecoration containerDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 20,
          offset: Offset(0, 4),
        ),
      ],
    );
  }

  Widget UserPhoneForm() {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Enter Your Phone Number",
            style: profileTextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: userProfileInputDecoration(hintText: "Phone"),
            keyboardType: TextInputType.phone,
            onSaved: (value) {
              if (value != null) {
                user.phone = value;
                var userProvider = Provider.of<UserProvider>(context, listen: false);
                userProvider.updateUser(userProvider.user..phone = value);
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your phone number';
              }
              return null;
            },
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                formKey.currentState?.save();
                print("User Phone: ${user.phone}");
                Navigator.pushNamed(context, "/add-user-sports");
              }
            },
            child: Text(
              "Next",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF48bb78),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 50),
                UserPhoneForm(),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
