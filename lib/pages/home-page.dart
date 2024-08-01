
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spoco_app/pages/get-user-profile.dart';
import 'package:spoco_app/pages/list-my-turfs.dart';
import 'package:spoco_app/pages/multi-image-upload.dart';
import 'package:spoco_app/pages/my-turfs-page.dart';
import 'package:spoco_app/pages/profile-page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  // getLocationOfUser() async {
  //   Position position = await _determinePosition();
  //   // Current Location of User
  //   print("Location/Position is: ${position.latitude}, ${position.longitude}");
  //   Util.geoPoint = GeoPoint(position.latitude, position.longitude);
  // }

  List<Widget> widgets = [
    const Text("Home Page"), // 0
    // const MyTurfsPage(), // 1
    const ListMyTurfs(), // 2
    const  MyTurfsPage(),
    const  GetUserProfile()// 3
  ];

  List<BottomNavigationBarItem> navBaritems = [
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        label: "Home"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.sports_football), label: "Turfs"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.sports_handball), label: "Players"),
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
  ];

  logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed("/");
  }

  onItemSelected(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    //getLocationOfUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page"), actions: [
        IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(Icons.logout))
      ]),
      body: Center(child: widgets[selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        items: navBaritems,
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber[500],
        unselectedItemColor: Colors.black54,
        onTap: onItemSelected,
      ),
    );
  }
}