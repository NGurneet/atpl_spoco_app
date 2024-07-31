import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:spoco_app/widgets/app_widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({ Key? key }) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
   TextEditingController nameController= TextEditingController();
    TextEditingController emailController= TextEditingController();
    TextEditingController passwordController = TextEditingController();
  register() async{
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
     if (email.isNotEmpty && password.isNotEmpty) {
      /*
      // Execute Firebase Auth Code
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      print("User Created with : Email: $email | Password: $password");
      print("Credential: $credential");
      */

      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        //uid
        String uid = credential.user!.uid;
        print("User Created with : Email: $email | Password: $password");
        print("Credential: $credential");
        final userData = <String, dynamic>{
          "name": name,
          "email": email,
          "createdOn": DateTime.now()
        };
    //     FirebaseFirestore.instance.collection("users").
    //     add(user).then((DocumentReference doc) =>
    // print('DocumentSnapshot added with ID: ${doc.id}'));
    FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .set(userData)
            .then((value) {
          

        Navigator.of(context).pushReplacementNamed("/home");
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
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(

      appBar: AppBar(title: Text("Register"),
      backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Register here",),

            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: "Name"
              ),
            ),
            const SizedBox(height: 12,),

            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: "Email"
              ),
            ),
            const SizedBox(height: 12,),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password"
              ),
            ),
            const SizedBox(height: 12,),
            //AppElevatedButton(text: "Register in", onPressed: register()),
            ElevatedButton(onPressed: (){
              register();
              
              }, child: const Text("Register in"))
            ,
            const SizedBox(height: 12,),
            TextButton(onPressed: (){
              Navigator.pushReplacementNamed(context, "/login");
            }, child: const Text("Existing user? Log in here")),

          ],
        ),
        ),


      
    );
  }
}