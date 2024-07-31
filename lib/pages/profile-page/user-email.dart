// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:spoco_app/model/user.dart';
// import 'package:spoco_app/provider/user-provider.dart';
// import 'package:spoco_app/utils/util.dart';

// class UserEmail extends StatefulWidget {
//   const UserEmail({Key? key}) : super(key: key);

//   @override
//   _UserEmailState createState() => _UserEmailState();
// }

// class _UserEmailState extends State<UserEmail> {

  
//   final AppUser user = AppUser.getAppUserEmptyObject();
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController confirmPasswordController = TextEditingController();

//   register() async{
 
//     String email = emailController.text.trim();
//     String password = passwordController.text.trim();
//      if (email.isNotEmpty && password.isNotEmpty) {
//       /*
//       // Execute Firebase Auth Code
//       final credential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: email, password: password);

//       print("User Created with : Email: $email | Password: $password");
//       print("Credential: $credential");
//       */

//       try {
//         final credential =
//             await FirebaseAuth.instance.createUserWithEmailAndPassword(
//           email: email,
//           password: password,
//         );
//         //uid
//         String uid = credential.user!.uid;
//         Util.UID = uid;
//         print("User Created with : Email: $email | Password: $password");
//         print("Credential: $credential");
//         final userData = <String, dynamic>{
         
//           "email": email,
//           "createdOn": DateTime.now()
//         };
//     //     FirebaseFirestore.instance.collection("users").
//     //     add(user).then((DocumentReference doc) =>
//     // print('DocumentSnapshot added with ID: ${doc.id}'));
//     FirebaseFirestore.instance
//             .collection("users")
//             .doc(uid)
//             .set(userData)
//             .then((value) {
          

//         Navigator.of(context).pushReplacementNamed("/add-user-name");
//            });
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'weak-password') {
//           print('The password provided is too weak.');
//         } else if (e.code == 'email-already-in-use') {
//           print('The account already exists for that email.');
//         }
//       } catch (e) {
//         print(e);
//       }
//     } else {
//       print("Missing Details: Email: $email | Password: $password");
//     }
//   }  

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

//   Widget UserProfileForm() {
//     return Form(
//       key: formKey,
//       child: Column(
//         children: <Widget>[
//           TextFormField(
//             decoration: userProfileInputDecoration(hintText: "Email"),
//             keyboardType: TextInputType.emailAddress,
//             controller: emailController,
//             onSaved: (value) {
//               if (value != null) {
//                 user.email = value;
                
//                 var userProvider = Provider.of<UserProvider>(context, listen: false);
//                 userProvider.updateUser(userProvider.user..email = value!);
                
//               }
//             },
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter your email';
//               }
//               // Simple email validation regex
//               if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                 return 'Please enter a valid email';
//               }
//               return null;
//             },
//           ),
//           TextFormField(
//             controller: passwordController,
//             decoration: userProfileInputDecoration(hintText: "Password"),
//             obscureText: true,
            
            
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter your password';
//               }
//               if (value.length < 6) {
//                 return 'Password must be at least 6 characters long';
//               }
//               return null;
//             },
//           ),
//           SizedBox(height: 12),
//           TextFormField(
//             controller: confirmPasswordController,
//             decoration: userProfileInputDecoration(hintText: "Confirm Password"),
//             obscureText: true,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please confirm your password';
//               }
//               if (value != passwordController.text) {
//                 return 'Passwords do not match';
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
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(24),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SizedBox(height: 50),
//               Text("Register", style: profileTextStyle(fontSize: 30.0)),
//               SizedBox(height: 30),
//               UserProfileForm(),
//               SizedBox(height: 30),
//               ElevatedButton(
//                 onPressed: () {
//                   if (formKey.currentState?.validate() ?? false) {
//                     formKey.currentState?.save();
//                     print("User Email: ${user.email}");
//                     register();
//                   }
//                 },
//                 child: Text(
//                   "Register",
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Color(0xFF48bb78),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spoco_app/model/user.dart';
import 'package:spoco_app/provider/user-provider.dart';
import 'package:spoco_app/utils/util.dart';

class UserEmail extends StatefulWidget {
  const UserEmail({Key? key}) : super(key: key);

  @override
  _UserEmailState createState() => _UserEmailState();
}

class _UserEmailState extends State<UserEmail> {
  final AppUser user = AppUser.getAppUserEmptyObject();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  bool _isPasswordHidden = true;
  bool _isConfirmPasswordHidden = true;

  register() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String uid = credential.user!.uid;
        Util.UID = uid;
        print("User Created with : Email: $email | Password: $password");
        print("Credential: $credential");
        final userData = <String, dynamic>{
          "email": email,
          "createdOn": DateTime.now()
        };
        FirebaseFirestore.instance.collection("users").doc(uid).set(userData).then((value) {
          Navigator.of(context).pushReplacementNamed("/add-user-name");
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("Missing Details: Email: $email | Password: $password");
    }
  }

  InputDecoration userProfileInputDecoration({required String hintText, Widget? suffixIcon}) {
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
      suffixIcon: suffixIcon,
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

  Widget UserProfileForm() {
    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: userProfileInputDecoration(hintText: "Email"),
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
            onSaved: (value) {
              if (value != null) {
                user.email = value;
                var userProvider = Provider.of<UserProvider>(context, listen: false);
                userProvider.updateUser(userProvider.user..email = value);
              }
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          SizedBox(height: 12),
          TextFormField(
            controller: passwordController,
            decoration: userProfileInputDecoration(
              hintText: "Password",
              suffixIcon: IconButton(
                icon: Icon(
                  _isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordHidden = !_isPasswordHidden;
                  });
                },
              ),
            ),
            obscureText: _isPasswordHidden,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 6) {
                return 'Password must be at least 6 characters long';
              }
              return null;
            },
          ),
          SizedBox(height: 12),
          TextFormField(
            controller: confirmPasswordController,
            decoration: userProfileInputDecoration(
              hintText: "Confirm Password",
              suffixIcon: IconButton(
                icon: Icon(
                  _isConfirmPasswordHidden ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _isConfirmPasswordHidden = !_isConfirmPasswordHidden;
                  });
                },
              ),
            ),
            obscureText: _isConfirmPasswordHidden,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Text("Register", style: profileTextStyle(fontSize: 30.0)),
              SizedBox(height: 30),
              UserProfileForm(),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    formKey.currentState?.save();
                    print("User Email: ${user.email}");
                    register();
                  }
                },
                child: Text(
                  "Register",
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
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

