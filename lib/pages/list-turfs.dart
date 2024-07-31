import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spoco_app/model/turf.dart';

class ListTurfs extends StatefulWidget {
  const ListTurfs({ Key? key }) : super(key: key);

  @override
  _ListTurfsState createState() => _ListTurfsState();
}

class _ListTurfsState extends State<ListTurfs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        //stream is representing data as snapshots
        stream: FirebaseFirestore.instance.collection('turfs').snapshots() ,
        builder: (context, snapshot) {
          //snapshot contains data in real time
          if(snapshot.connectionState ==ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.hasError){
            return Center(
              child:Text("Something Went Wrong"),
            );
          }
          //length of collection is zero
          if(!snapshot.hasData){
            return Center(
              child:Text("No Turf Found!"),
            );
          }
          
          // List<Turf> turfs =  snapshot.data!.docs.map((doc)=>Turf.fromMap(doc.data()) as Map<String,dynamic>).toList();
          List<Turf> turfs = snapshot.data!.docs
              .map((doc) => Turf.fromMap(doc.data() as Map<String, dynamic>))
              .toList();
          return ListView(
            // children: turfs.map((turf)=> Card(

            // ))

            // children: turfs
            // .map((turf)=> Card(
            //   child: Column(
            //     children: [
            //       Text("${turf.name}")
            //     ],
            //   ),
            // )),
          );
        },),
        
      
    );
  }
}

//List my turfs 
//2. Delete the turf 
//3. Turf Details page
//4. Open Multiple Image Uploader for turf in My turfs page
//
