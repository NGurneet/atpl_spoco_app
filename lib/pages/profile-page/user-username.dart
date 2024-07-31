import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:spoco_app/model/user.dart';
import 'package:spoco_app/provider/user-provider.dart';

class UserUsername extends StatefulWidget {
  const UserUsername({Key? key}) : super(key: key);

  @override
  _UserUsernameState createState() => _UserUsernameState();
}

class _UserUsernameState extends State<UserUsername> {
  final AppUser user = AppUser.getAppUserEmptyObject();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  bool _isUsernameAvailable = true;

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

  InputDecoration userProfileInputDecoration({
    required String hintText,
  }) {
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

  Future<void> _checkUsernameAvailability(String username) async {
    final result = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    setState(() {
      _isUsernameAvailable = result.docs.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter Your Username"),
        backgroundColor: Color(0xFF48bb78),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter Your Username",
                style: profileTextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _usernameController,
                decoration: userProfileInputDecoration(
                    hintText: "Enter Your Username"),
                onSaved: (value) {
                  user.username = value!;
                  var userProvider = Provider.of<UserProvider>(context, listen: false);
                userProvider.updateUser(userProvider.user..username = value!);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username';
                  } else if (!_isUsernameAvailable) {
                    return 'Username already taken';
                  }
                  return null;
                },
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    _checkUsernameAvailability(value);
                  }
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          // Print or save the entered username
                          print("Username: ${user.username}");
                          // Navigate to the next page or perform any action
                          Navigator.pushNamed(context, '/save-user-profile'); // Replace with actual route
                        }
                      },
                      child: Text(
                        "Next",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
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
                  ),
                ],
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
