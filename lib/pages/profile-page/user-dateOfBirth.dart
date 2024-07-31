import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spoco_app/model/user.dart';
import 'package:spoco_app/provider/user-provider.dart';

class UserDateOfBirth extends StatefulWidget {
  const UserDateOfBirth({Key? key}) : super(key: key);

  @override
  _UserDateOfBirthState createState() => _UserDateOfBirthState();
}

class _UserDateOfBirthState extends State<UserDateOfBirth> {
  final AppUser user = AppUser.getAppUserEmptyObject();

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

  Future<void> pickDateOfBirth() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime(2024),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      setState(() {
        user.dateOfBirth = date;
        user.age = DateTime.now().year - date.year;
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.updateUser(userProvider.user
          ..dateOfBirth = date
          ..age = user.age);
        print("User Age is: ${user.age}");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            Text("Enter Your Date of Birth", style: profileTextStyle()),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: pickDateOfBirth,
              child: Text(
                "Pick Date of Birth",
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
            if (user.dateOfBirth != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  "Selected Date: ${user.dateOfBirth?.toLocal().toString().split(' ')[0]}",
                  style: profileTextStyle(fontSize: 18.0),
                ),
              ),
            if (user.age != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  "User Age: ${user.age}",
                  style: profileTextStyle(fontSize: 18.0),
                ),
              ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (user.dateOfBirth != null) {
                        Navigator.pushNamed(context, '/next-page'); // Update to the next page route
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please pick a date of birth")),
                        );
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
          ],
        ),
      ),
    );
  }
}
