import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spoco_app/model/user.dart';
import 'package:spoco_app/utils/util.dart';
import 'package:country_state_city_picker/country_state_city_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

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
              });
            },
            onStateChanged:(value) {
              setState(() {
                user.state = value;
              });
            },
             onCityChanged:(value) {
              setState(() {
                user.city = value;
              });
            },
            
            )
          ],
        )
      );
  }

  AppUser user = AppUser.getAppUserEmptyObject();
  final formKey = GlobalKey<FormState>();
  List<String> sportsList = <String>['Cricket', 'Badminton', 'Soccer', 'Tennis'];
  List<String> roles = ['Player','Coach','Turf/Ground Owner'];
  List<String> levelsPlayedList = ['International','National','State','District','Zonal', 'Other'];
  
  saveUserDataInFirebase(){
    
    formKey.currentState!.save();
    print('User Data: ${user.toMap().toString()}');
    try{
    FirebaseFirestore.instance
            .collection("users")
            .doc(Util.UID)
            .set(user.toMap())
            .then((value) {
          

        Navigator.of(context).pushReplacementNamed("/home");
           });
      
      } catch (e) {
        print(e);
      }
    } 

    pickupProfImage(){
      
    }
    

  
  

  pickDateOfBirth() async{
    DateTime? date = await  showDatePicker(
      context: context,
      
      initialDate: DateTime(2024),
      firstDate: DateTime(1900),
      lastDate: DateTime.now());

      if(date!=null){
        setState(() {
          user.dateOfBirth = date;
          user.age = DateTime.now().year - date.year;
          print("User Age is: ${user.age}");
          //user.age = 
        });
      }
  }

  
  
  // userRoleDropDownMenu(){
  //   String dropdownValue = roles.first;
    
  //   return DropdownButtonFormField(items: roles.map<DropdownMenuItem<String>>((String value) {
  //       return DropdownMenuItem<String>(
  //         value: dropdownValue,
  //         child: Text(value),
          
  //       );
  //     }).toList(),
  //     onChanged: (String? value) {
  //       // This is called when the user selects an item.
  //       setState(() {
  //         dropdownValue = value!;
          
  //         user.role = value!;
  //       });
  //     });
  // }
  userRoleDropDownMenu() {
    return DropdownButtonFormField<String>(
      value: user.role.isNotEmpty ? user.role : roles.first,
      decoration: InputDecoration(
        labelText: 'Select Role',
        border: OutlineInputBorder(),
      ),
      items: roles.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? value) {
        setState(() {
          user.role = value!;
        });
      },
    );
  }

  // sportsDropDownMenu(){
  //   String dropdownValue = sportsList.first;
    
  //   return DropdownButtonFormField<String>(
  //     value: dropdownValue,
  //     //initialValue: user.sports,
  //      elevation: 16,
  //       onChanged: (String? value) {
  //       // This is called when the user selects an item.
  //       setState(() {
  //         dropdownValue = value!;
          
  //         user.sports = value!;
  //       });
  //     },
  //     items: sportsList.map<DropdownMenuItem<String>>((String value) {
  //       return DropdownMenuItem<String>(
  //         value: value,
  //         child: Text(value),
          
  //       );
  //     }).toList(),
  //   );
  // }
  sportsDropDownMenu() {
    return DropdownButtonFormField<String>(
      value: user.sports.isNotEmpty ? user.sports : sportsList.first,
      decoration: InputDecoration(
        labelText: 'Select Sport',
        border: OutlineInputBorder(),
      ),
      elevation: 16,
      onChanged: (String? value) {
        setState(() {
          user.sports = value!;
        });
      },
      items: sportsList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  levelPlayedDropDownMenu() {
    return DropdownButtonFormField<String>(
      value: user.highestPlayedLevel.isNotEmpty ? user.highestPlayedLevel : levelsPlayedList.first,
      decoration: InputDecoration(
        labelText: 'Select Highest Level Played',
        border: OutlineInputBorder(),
      ),
      elevation: 16,
      onChanged: (String? value) {
        setState(() {
          user.highestPlayedLevel = value!;
        });
      },
      items: levelsPlayedList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  UserProfileForm(){
    return Form(
      key: formKey ,
      child: Column(
        children: <Widget>[
          TextFormField(
                    decoration:
                        const InputDecoration(labelText: "Enter Your Name"),
                    onSaved: (value) {
                      user.name = value!;
                    },
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: "Enter Your Phone"),
                    initialValue: user.phone.isNotEmpty ? user.phone : "",
                    onSaved: (value) {
                      user.phone = value!;
                    },
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: "Enter Your Email"),
                    onSaved: (value) {
                      user.email = value!;
                    },
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text("Select Gender:"),
                      ListTile(
                        title: const Text("Male"),
                        leading: Radio<String>(
                          value: "Male",
                          groupValue: user.gender,
                          onChanged: (value) {
                            setState(() {
                              user.gender = value!;
                            });
                          },
                        ),
                      ),
                      ListTile(
                        title: const Text("Female"),
                        leading: Radio<String>(
                          value: "Female",
                          groupValue: user.gender,
                          onChanged: (value) {
                            setState(() {
                              user.gender = value!;
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  DropdownButtonFormField<String>(
                    value: user.sports,
                    items: ["Select Sports", "Cricket", "Badminton", "Soccer"]
                        .map((element) {
                      return DropdownMenuItem<String>(
                          value: element, child: Text(element));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        user.sports = value!;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Enter Your Address Line"),
                    onSaved: (value) {
                      user.addressLine = value!;
                    },
                  ),
                  countriesDropDownMenu(),
                  // TextFormField(
                  //   decoration:
                  //       const InputDecoration(labelText: "Enter Your City"),
                  //   onSaved: (value) {
                  //     user.city = value!;
                  //   },
                  // ),
                  // TextFormField(
                  //   decoration:
                  //       const InputDecoration(labelText: "Enter Your State"),
                  //   onSaved: (value) {
                  //     user.state = value!;
                  //   },
                  // ),
                  // TextFormField(
                  //   decoration:
                  //       const InputDecoration(labelText: "Enter Your Country"),
                  //   onSaved: (value) {
                  //     user.country = value!;
                  //   },
                  // ),
                  DropdownButtonFormField<String>(
                    value: user.role,
                    items: ["Select Role", "Player", "Coach", "TurfOwner"]
                        .map((element) {
                      return DropdownMenuItem<String>(
                          value: element, child: Text(element));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        user.role = value!;
                      });
                    },
                  ),
                  DropdownButtonFormField<String>(
                    value: user.highestPlayedLevel,
                    items: [
                      "Select Highest Played Level",
                      "Zonal",
                      "District",
                      "State"
                    ].map((element) {
                      return DropdownMenuItem<String>(
                          value: element, child: Text(element));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        user.highestPlayedLevel = value!;
                      });
                    },
                  ),
                  ListTile(
                    title: (Text(
                        "Date of Birth: ${user.dateOfBirth.day}/${user.dateOfBirth.month}/${user.dateOfBirth.year}")),
                    trailing: const Icon(Icons.calendar_today),
                    onTap: pickDateOfBirth,
                  ),
                  SwitchListTile(
                    title: const Text("Have you Represented a Club ?"),
                    value: user.representClub,
                    onChanged: (value) {
                      setState(() {
                        user.representClub = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Enter Your Club Name"),
                    onSaved: (value) {
                      user.clubName = value!;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                        labelText: "Enter Your School/College/Organization"),
                    onSaved: (value) {
                      user.schoolCollegeOrgName = value!;
                    },
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: "Enter Your Username"),
                    onSaved: (value) {
                      // write the firebase query to check if the same username exists
                      user.username = value!;
                    },
                  ),
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: ElevatedButton(
                          onPressed: saveUserDataInFirebase,
                          child: const Text("Save Profile")))

        ],

      )
    );
  }

  // submitForm(){
  //   if (formKey.currentState?.validate() ?? false){
  //     formKey.currentState!.save();

  //   }
  //   else {
  //     print("Error...");
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserProfileForm(),
              SizedBox(height: 20),
              
            ],
          ),
        ),
      ),
      
    );
  }
}