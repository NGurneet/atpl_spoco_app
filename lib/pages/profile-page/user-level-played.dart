import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spoco_app/model/user.dart';
import 'package:spoco_app/provider/user-provider.dart'; // Import your AppUser model

class UserLevelPlayed extends StatefulWidget {
  const UserLevelPlayed({Key? key}) : super(key: key);

  @override
  _UserLevelPlayedState createState() => _UserLevelPlayedState();
}

class _UserLevelPlayedState extends State<UserLevelPlayed> {
  final AppUser user = AppUser.getAppUserEmptyObject();

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

  Widget buildLevelButton(String level) {
    bool isSelected = user.highestPlayedLevel == level;
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            user.highestPlayedLevel = level;
            var userProvider = Provider.of<UserProvider>(context, listen: false);
                userProvider.updateUser(userProvider.user..highestPlayedLevel = level!);
          });
        },
        child: Text(
          level,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Highest Played Level"),
        backgroundColor: Color(0xFF48bb78),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select Highest Played Level",
              style: profileTextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                buildLevelButton("Zonal"),
                SizedBox(width: 10),
                buildLevelButton("District"),
                SizedBox(width: 10),
                buildLevelButton("State"),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Print or save the selected level
                      print("Selected Highest Played Level: ${user.highestPlayedLevel}");
                      // Navigate to the next page or perform any action
                      Navigator.pushReplacementNamed(context, '/add-user-club');
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
