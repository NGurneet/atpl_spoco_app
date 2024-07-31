import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spoco_app/model/user.dart';
import 'package:spoco_app/provider/user-provider.dart';

class UserRole extends StatefulWidget {
  const UserRole({Key? key}) : super(key: key);

  @override
  _UserRoleState createState() => _UserRoleState();
}

class _UserRoleState extends State<UserRole> {
  final AppUser user = AppUser.getAppUserEmptyObject();

  Widget buildRoleButton(String role) {
    bool isSelected = user.role == role;
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            user.role = role;
            var userProvider = Provider.of<UserProvider>(context, listen: false);
                userProvider.updateUser(userProvider.user..role = role!);
          });
        },
        child: Text(
          role,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Color(0xFF48bb78) : Colors.grey.shade200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          padding: EdgeInsets.symmetric(vertical: 16),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Your Role"),
        backgroundColor: Color(0xFF48bb78),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Your Role",
              style: profileTextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                buildRoleButton("Player"),
                SizedBox(width: 10),
                buildRoleButton("Coach"),
                SizedBox(width: 10),
                buildRoleButton("TurfOwner"),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Print or save the selected role
                      print("Selected Role: ${user.role}");
                      // Navigate to the next page or perform any action
                      Navigator.pushNamed(context, '/add-user-level');
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
    );
  }
}
