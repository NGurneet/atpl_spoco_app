
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spoco_app/utils/util.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ super.key }) ;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController emailController= TextEditingController();
    TextEditingController passwordController = TextEditingController();
    
    

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }
  @override
  void dispose(){
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  

  login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if(email.isNotEmpty&& password.isNotEmpty){

      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        print("User Created with : Email: $email | Password: $password");
        print("Credential: $credential");
        User? user = FirebaseAuth.instance.currentUser;

        Util.UID = user!.uid;
        Future<void> initUserLocation() async{
        await Util.updateLocation();
        print("[User Location = ${Util.geoPoint}]");
      }
        initUserLocation();

        Navigator.pushReplacementNamed(context, "/home");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
      print("Details: Email $email | Password: $password");
    }
    else{
      print("Missing Details");
    }
  }

  styleTextField( String hintText){
    return InputDecoration(
      hintText: hintText,
      contentPadding: 
        const EdgeInsets.all(16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), 
        borderSide: const BorderSide(color: Colors.blue, width: 2.5)), 
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.redAccent, width: 2.5)),
        focusedBorder: const  OutlineInputBorder(
        // borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.cyan, width: 2.5))
    );
  }

  InputDecoration styleNewTextField(String hintText) {
    return InputDecoration(
      hintText: hintText,
      filled: true,
      fillColor: Colors.grey[200],
      contentPadding: const EdgeInsets.all(16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 129, 201, 189),
          width: 2.5,
        ),
      ),
      // boxShadow: const [
      //   BoxShadow(
      //     color: Colors.black26,
      //     blurRadius: 5,
      //     offset: Offset(0, 3),
      //   ),
      // ],
    );
  }


  
  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      
      body:Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 129, 201, 189),
              Color.fromARGB(255, 35, 154, 186),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Container(height: 400,),
              Container(
                padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 20,
                        offset: Offset(0, 4),
                      ),
                    ],
                  )
                  ,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      SizedBox(height: 40,),
                      Text("Log in"),
                      SizedBox(height: 12,),
                       TextField(
                      controller: emailController,
                      decoration: styleNewTextField("Email"),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: styleNewTextField("Password"),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(onPressed: login, child: Text("Log in")),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, "/add-user-email");
                      },
                      child: const Text("New user? Register here"),
                    ),
                    SizedBox(height: 20,),
                    ],
                  ),
              ),
              
            ],
           
          ),
        ),
        
      ),
      // body: Padding(
      //   padding: EdgeInsets.all(16),
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Text("Welcome",),

      //       TextField(
      //         controller: emailController,
      //         // decoration: InputDecoration(
      //         //   labelText: "Email"
      //         // ),
      //         decoration: styleTextField("Email"),
      //       ),
      //       const SizedBox(height: 12,),
      //       TextField(
      //         controller: passwordController,
      //         obscureText: true,
      //         decoration: styleTextField("Password"),
      //       ),
      //       const SizedBox(height: 12,),
      //       ElevatedButton(onPressed: (){
      //         login();
              
      //       }, style: ElevatedButton.styleFrom(
      //         //backgroundColor: Color(0xFF81C9BD),
      //       ),
      //       child: const Text("Log in"))
      //       ,
      //       const SizedBox(height: 12,),
      //       TextButton(onPressed: (){

      //         Navigator.pushReplacementNamed(context, "/register");
      //       }, child: const Text("New user? Register here")),

      //     ],
      //   ),
      //   ),
    );
  }
}

// child: Center(
        //   child: Padding(
        //     padding: const EdgeInsets.all(16),
        //     child: Column(
        //       children: [
        //         Container(
        //         padding: const EdgeInsets.all(16),
        //         decoration: BoxDecoration(
        //           color: Colors.white,
        //           borderRadius: BorderRadius.circular(10),
        //           boxShadow: [
        //             BoxShadow(
        //               color: Colors.black26,
        //               blurRadius: 10,
        //               offset: Offset(0, 4),
        //             ),
        //           ],
        //         ),
        //         child: Column(
        //           mainAxisSize: MainAxisSize.min,
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             const Text(
        //               "Welcome",
        //               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        //             ),
        //             const SizedBox(height: 12),
        //             TextField(
        //               controller: emailController,
        //               decoration: styleTextField("Email"),
        //             ),
        //             const SizedBox(height: 12),
        //             TextField(
        //               controller: passwordController,
        //               obscureText: true,
        //               decoration: styleTextField("Password"),
        //             ),
        //             const SizedBox(height: 12),
        //             ElevatedButton(
        //               onPressed: login,
        //               style: ElevatedButton.styleFrom(
        //                 padding: const EdgeInsets.symmetric(
        //                     horizontal: 32, vertical: 16),
        //               ),
        //               child: const Text("Log in"),
        //             ),
        //             const SizedBox(height: 12),
        //             TextButton(
        //               onPressed: () {
        //                 Navigator.pushReplacementNamed(context, "/register");
        //               },
        //               child: const Text("New user? Register here"),
        //             ),
        //           ],
        //         ),
        //       ),
        //       ]
               
        //     ),
        //   ),
        // ),