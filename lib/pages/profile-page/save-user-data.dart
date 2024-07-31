import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spoco_app/provider/user-provider.dart';
import 'package:spoco_app/utils/util.dart';

class SaveUserDataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // print("User Data: ${user.toMap().toString}");
            try {

              
              var userProvider = Provider.of<UserProvider>(context, listen: false);
              await FirebaseFirestore.instance
                  .collection("users")
                  .doc(Util.UID) // Replace with actual user ID
                  .set(userProvider.toMap());
              Navigator.of(context).pushReplacementNamed("/home");
            } catch (e) {
              print(e);
            }
          },
          child: Text("Save Profile"),
        ),
      ),
    );
  }
}
