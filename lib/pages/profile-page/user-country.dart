import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spoco_app/model/user.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:spoco_app/provider/user-provider.dart';

class UserCountry extends StatefulWidget {
  const UserCountry({ Key? key }) : super(key: key);

  @override
  _UserCountryState createState() => _UserCountryState();
}

class _UserCountryState extends State<UserCountry> {

  countriesDropDownMenu(){
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        
        child: 
         Column(
          children: [
            SelectState(
              onCountryChanged: (value) {
              setState(() {
                user.country = value;
                var userProvider = Provider.of<UserProvider>(context, listen: false);
                userProvider.updateUser(userProvider.user..country = value!);
              });
            },
            onStateChanged:(value) {
              setState(() {
                user.state = value;
                var userProvider = Provider.of<UserProvider>(context, listen: false);
                userProvider.updateUser(userProvider.user..state = value!);
              });
            },
             onCityChanged:(value) {
              setState(() {
                user.city = value;
                var userProvider = Provider.of<UserProvider>(context, listen: false);
                userProvider.updateUser(userProvider.user..city = value!);
              });
            },
            
            )
          ],
        )
      );
  }
  InputDecoration userProfileInputDecoration({
  required String hintText,
  
}) {
  return InputDecoration(
    hintText: hintText,
    
    filled: true,
    fillColor: Colors.grey.shade200, // Very light greyish color
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)), // Rounded corners
      borderSide: BorderSide(
        color: Colors.grey, // Simple border color
        width: 1.0,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)), // Rounded corners
      borderSide: BorderSide(
        color: Color(0xFF48bb78), // Focused border color
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

containerDecoration (){
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
  UserProfileForm(){
    return Form(
      key: formKey ,
      child: Column(
        children: <Widget>[
          TextFormField(
                    decoration: userProfileInputDecoration(hintText: "Email",),
                    onSaved: (value) {
                      user.email = value!;
                    },
                  ),
                  
                  // Padding(
                  //     padding: const EdgeInsets.all(16),
                  //     child: ElevatedButton(
                  //         onPressed: saveUserDataInFirebase,
                  //         child: const Text("Save Profile")))

        ],

      )
    );
  }
  final formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            
            children: [
              // Container(height: 400,),
              // Container(
              //   padding: const EdgeInsets.all(16),
              //     decoration: containerDecoration(),
                  
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [

              //       const SizedBox(height: 40,),
              //       Text("Enter Your Email" , style: profileTextStyle(),),
              //       const SizedBox(height: 12,),
              //         UserProfileForm(),
              //       const SizedBox(height: 12),
                    
              //       // TextButton(
              //       //   onPressed: () {
              //       //     Navigator.pushReplacementNamed(context, "/register");
              //       //   },
              //       //   child: const Text("New user? Register here"),
              //       // ),
              //       SizedBox(height: 20,),
              //       ],
              //     ),
              // ),
              SizedBox(height: 12,),
               Text("Choose Your Country" , style: profileTextStyle(),),
                    const SizedBox(height: 12,),
                      countriesDropDownMenu(),
                    const SizedBox(height: 12,),
              Row(
                children: [
                  Expanded(
                  child: ElevatedButton(onPressed: (){
                        print(user.name);
                        print(user.name);
                        Navigator.pushReplacementNamed(context, '/add-user-role');
                      }, child: Text("Next", 
                      style: TextStyle(color: Colors.white, 
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      ),),
                      style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF48bb78),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                ),
                      
                      ),
                      
                
                ),
                ]
              ),
              const SizedBox(height: 12),
            ],
           
          ),
        ),
        
      
    );
  }
}
