import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spoco_app/model/user.dart';
import 'package:spoco_app/provider/user-provider.dart';

class UserSports extends StatefulWidget {
  const UserSports({Key? key}) : super(key: key);

  @override
  _UserSportsState createState() => _UserSportsState();
}

class _UserSportsState extends State<UserSports> {
  List<String> sportsList = <String>['Cricket', 'Badminton', 'Soccer', 'Tennis'];
  String? selectedSport;

  @override
  void initState() {
    super.initState();
    selectedSport = sportsList.first; // Set default value
  }

  void _onSportSelected(String sport) {
    setState(() {
      selectedSport = sport;
      user.sports = sport;
      var userProvider = Provider.of<UserProvider>(context, listen: false);
                userProvider.updateUser(userProvider.user..sports = sport!);
    });
  }

  Widget sportsButton(String sport) {
    return ElevatedButton(
      onPressed: () => _onSportSelected(sport),
      style: ElevatedButton.styleFrom(
        backgroundColor: selectedSport == sport ? Color(0xFF48bb78) : Colors.grey.shade300,
        foregroundColor: selectedSport == sport ? Colors.white : Colors.black,
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 5,
      ),
      child: Text(
        sport,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
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

  AppUser user = AppUser.getAppUserEmptyObject();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            Text("Choose Your Sport", style: profileTextStyle()),
            SizedBox(height: 12),
            Wrap(
              spacing: 10.0, // Horizontal space between buttons
              runSpacing: 10.0, // Vertical space between lines of buttons
              children: sportsList.map((sport) => sportsButton(sport)).toList(),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      print(user.name);
                      print(user);
                      print("User Data: ${user.toMap().toString()}");
                      Navigator.pushNamed(context, "/add-user-country");
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
