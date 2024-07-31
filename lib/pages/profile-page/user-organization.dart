import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spoco_app/model/user.dart';
import 'package:spoco_app/provider/user-provider.dart';

class UserOrganization extends StatefulWidget {
  const UserOrganization({Key? key}) : super(key: key);

  @override
  _UserOrganizationState createState() => _UserOrganizationState();
}

class _UserOrganizationState extends State<UserOrganization> {
  final AppUser user = AppUser.getAppUserEmptyObject();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Organization Details"),
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
                "Enter Your School/College/Organization",
                style: profileTextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: userProfileInputDecoration(
                    hintText: "Enter Your School/College/Organization"),
                onSaved: (value) {
                  user.schoolCollegeOrgName = value!;
                  var userProvider = Provider.of<UserProvider>(context, listen: false);
                userProvider.updateUser(userProvider.user..schoolCollegeOrgName = value!);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your school/college/organization';
                  }
                  return null;
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
                          // Print or save the entered organization
                          print("Organization: ${user.schoolCollegeOrgName}");
                          // Navigate to the next page or perform any action
                          Navigator.pushNamed(context, '/add-user-username'); // Replace with actual route
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
                        padding: EdgeInsets.symmetric(vertical: 16),
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
