import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spoco_app/model/user.dart';
import 'package:spoco_app/provider/user-provider.dart';

class UserClub extends StatefulWidget {
  const UserClub({Key? key}) : super(key: key);

  @override
  _UserClubState createState() => _UserClubState();
}

class _UserClubState extends State<UserClub> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Club Representation"),
        backgroundColor: Color(0xFF48bb78),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Have you Represented a Club?",
              style: profileTextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            SwitchListTile(
              title: Text(
                "Have you Represented a Club?",
                style: profileTextStyle(fontSize: 20),
              ),
              value: user.representClub,
              onChanged: (value) {
                setState(() {
                  user.representClub = value;
                  var userProvider = Provider.of<UserProvider>(context, listen: false);
                userProvider.updateUser(userProvider.user..representClub = value!);
                });
              },
              activeColor: Color(0xFF48bb78),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Print or save the club representation status
                      print("Represent Club: ${user.representClub}");
                      // Navigate to the next page or perform any action
                      Navigator.pushNamed(context, '/add-user-organization'); // Replace with actual route
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
