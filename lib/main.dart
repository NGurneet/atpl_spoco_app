import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:spoco_app/firebase_options.dart';
import 'package:spoco_app/pages/get-user-profile.dart';
import 'package:spoco_app/pages/home-page.dart';
import 'package:spoco_app/pages/login-page.dart';
import 'package:spoco_app/pages/my-turfs-page.dart';
import 'package:spoco_app/pages/profile-page/save-user-data.dart';
import 'package:spoco_app/pages/profile-page/user-club.dart';
import 'package:spoco_app/pages/profile-page/user-country.dart';
import 'package:spoco_app/pages/profile-page/user-email.dart';
import 'package:spoco_app/pages/profile-page/user-level-played.dart';
import 'package:spoco_app/pages/profile-page/user-name.dart';
import 'package:spoco_app/pages/profile-page/user-organization.dart';
import 'package:spoco_app/pages/profile-page/user-phone.dart';
import 'package:spoco_app/pages/profile-page/user-role.dart';
import 'package:spoco_app/pages/profile-page/user-sports.dart';
import 'package:spoco_app/pages/profile-page/user-username.dart';
import 'package:spoco_app/pages/register-page.dart';
import 'package:spoco_app/pages/splash.dart';
import 'package:spoco_app/provider/user-provider.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: const MainApp(),
    ),
    
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
     "/": (context) => const Splash(),
      '/home': (context) => const HomePage(),
      // '/first-screen':(context) => const FirstScreen(),
      // "/second-screen": (context)=> const SecondScreen(),/
      // '/hotels':(context) => const ListDishes(),
      '/login':(context)=> const LoginPage(),
      '/register':(context)=> const RegisterPage(),
      '/add-turf': (context) => const MyTurfsPage(),
      '/add-user-name': (context) => const UserName(),
      '/add-user-phone': (context) => const UserPhone(),
      '/add-user-email': (context) => const UserEmail(),
      '/add-user-sports': (context) => const UserSports(),
      '/add-user-country': (context) => const UserCountry(),
      '/add-user-role': (context) => const UserRole(),
      '/add-user-level': (context) => const UserLevelPlayed(),
      '/add-user-club': (context) => const UserClub(),
      '/add-user-organization':(context) => UserOrganization(),
      '/add-user-username':(context) => UserUsername(),
      '/save-user-profile': (context) => SaveUserDataPage(),
       '/get-user-profile':(context)=> const GetUserProfile(),
      // '/register-turf':(context)=> const RegisterTurf(),
      // '/slider-page':(context)=> const SliderPage(),
      // '/add-task': (context)=> const AddTask(),
      // '/get-all-task': (context) => const AllTaskList(), 

    },
    theme: new ThemeData(scaffoldBackgroundColor: const Color(0xFFEFEFEF)),
    // theme: ThemeData(
    //     primaryColor: Color(0xFF48bb78),
    //     accentColor: Color(0xFFFFD700),
    //     backgroundColor: Color(0xFFFFFFFF),
    //     textTheme: const TextTheme(
    //       bodyText1: TextStyle(color: Color(0xFF333333)),
    //     ),
    //   ),
    
  );
  
  }
}
