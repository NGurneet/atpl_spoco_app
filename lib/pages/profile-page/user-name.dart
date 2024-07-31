// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:spoco_app/model/user.dart';
// import 'package:spoco_app/provider/user-provider.dart';

// class UserName extends StatefulWidget {
//   const UserName({Key? key}) : super(key: key);

//   @override
//   _UserNameState createState() => _UserNameState();
// }

// class _UserNameState extends State<UserName> {
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

//   Widget UserNameForm() {
//     return Form(
//       key: formKey,
//       child: Column(
//         children: <Widget>[
//           TextFormField(
//             decoration: userProfileInputDecoration(hintText: "Name"),
//             onSaved: (value) {
//               if (value != null) {
//                 user.name = value;
//                 var userProvider = Provider.of<UserProvider>(context, listen: false);
//                 userProvider.updateUser(userProvider.user..name = value!);
//               }
//             },
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter your name';
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
//         padding: EdgeInsets.all(16),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const SizedBox(height: 12),
//             UserNameForm(),
//             const SizedBox(height: 12),
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       if (formKey.currentState?.validate() ?? false) {
//                         formKey.currentState?.save();
//                         print("User Name: ${user.name}");
//                         Navigator.pushNamed(context, '/add-user-phone');
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
//                       backgroundColor: Color(0xFF48bb78),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       padding: EdgeInsets.symmetric(vertical: 16),
//                     ),
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

class UserName extends StatefulWidget {
  const UserName({Key? key}) : super(key: key);

  @override
  _UserNameState createState() => _UserNameState();
}

class _UserNameState extends State<UserName> {
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

  Widget UserNameForm() {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          Text(
            "Enter Your Name",
            style: profileTextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: userProfileInputDecoration(hintText: "Name"),
            onSaved: (value) {
              if (value != null) {
                user.name = value;
                var userProvider = Provider.of<UserProvider>(context, listen: false);
                userProvider.updateUser(userProvider.user..name = value);
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                formKey.currentState?.save();
                print("User Name: ${user.name}");
                Navigator.pushNamed(context, '/add-user-phone');
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
                UserNameForm(),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
