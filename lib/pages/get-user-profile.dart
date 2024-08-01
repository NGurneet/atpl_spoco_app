import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:spoco_app/model/user.dart';

import 'package:spoco_app/utils/util.dart'; // Assuming Util class contains UID

class GetUserProfile extends StatefulWidget {
  const GetUserProfile({Key? key}) : super(key: key);

  @override
  _GetUserProfileState createState() => _GetUserProfileState();
}

class _GetUserProfileState extends State<GetUserProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? user;
  AppUser? appUser;
  File? _image;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(user!.uid).get();
      setState(() {
        appUser = AppUser.fromMap(userDoc.data() as Map<String, dynamic>);
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      await _uploadImage();
    }
  }

  Future<void> _uploadImage() async {
    if (_image != null) {
      final storageRef = FirebaseStorage.instance.ref();
      final profilePicsRef = storageRef.child("profile-pics/${Util.UID}.png");
      try {
        await profilePicsRef.putFile(_image!);
        String imageURL = await profilePicsRef.getDownloadURL();
        setState(() {
          appUser!.imageURL = imageURL;
        });
        await _saveUserInFirebaseFirestore();
      } catch (e) {
        print("Something went wrong while uploading the image.");
        print(e);
      }
    }
  }

  Future<void> _saveUserInFirebaseFirestore() async {
    try {
      await _firestore.collection("users").doc(Util.UID).set(appUser!.toMap());
      print("User data saved in Firestore: ${appUser!.toMap()}");
    } catch (e) {
      print("Exception while saving user profile");
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: appUser == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: _image != null
                            ? FileImage(_image!)
                            : appUser!.imageURL.isNotEmpty
                                ? NetworkImage(appUser!.imageURL)
                                : AssetImage('assets/default_avatar.png') as ImageProvider,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.teal,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      appUser!.name,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      appUser!.email,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      leading: Icon(Icons.phone, color: Colors.teal),
                      title: Text(appUser!.phone),
                    ),
                    ListTile(
                      leading: Icon(Icons.sports, color: Colors.teal),
                      title: Text(appUser!.sports),
                    ),
                    ListTile(
                      leading: Icon(Icons.location_city, color: Colors.teal),
                      title: Text("${appUser!.city}, ${appUser!.state}, ${appUser!.country}"),
                    ),
                    ListTile(
                      leading: Icon(Icons.account_circle, color: Colors.teal),
                      title: Text(appUser!.role),
                    ),
                    ListTile(
                      leading: Icon(Icons.emoji_events, color: Colors.teal),
                      title: Text(appUser!.highestPlayedLevel),
                    ),
                    ListTile(
                      leading: Icon(Icons.calendar_today, color: Colors.teal),
                      title: Text("Age: ${appUser!.age ?? 'Not specified'}"),
                    ),
                    ListTile(
                      leading: Icon(Icons.sports_score_outlined, color: Colors.teal),
                      title: Text("${appUser!.representClub}"),
                    ),
                    ListTile(
                      leading: Icon(Icons.school, color: Colors.teal),
                      title: Text(appUser!.schoolCollegeOrgName),
                    ),
                    ListTile(
                      leading: Icon(Icons.person, color: Colors.teal),
                      title: Text(appUser!.username),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Joined on: ${appUser!.createdOn.toLocal().toString().split(' ')[0]}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
