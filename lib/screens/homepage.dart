import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:v_app/variables.dart';
import 'package:v_app/screens/videoconferencescreen.dart';
import 'package:v_app/screens/profilescreen.dart';
    
    class HomePage extends StatefulWidget {
      const HomePage({Key? key}) : super(key: key);
    
      @override
      _HomePageState createState() => _HomePageState();
    }
    
    class _HomePageState extends State<HomePage> {
      int page=0;
      List pageoptions=[
        VideoConferenceScreen(),
        ProfileScreen()
      ];
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.grey[250],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: Colors.blue,
            selectedLabelStyle: mystyle(17,Colors.blue),
            unselectedItemColor: Colors.black,
            unselectedLabelStyle: mystyle(17,Colors.black),
            currentIndex: page,
            onTap: (index){
              setState(() {
                page=index;
              });
            },
            items: [
              BottomNavigationBarItem(
                label: "video call",
                icon:Icon(Icons.video_call,size:32),
        ),
              BottomNavigationBarItem(
                label:"profile",
                icon:Icon(Icons.video_call,size:32),
              )
            ],
          ),
          body: pageoptions[page],

        );
      }
    }
